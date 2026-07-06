import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/auth_service.dart';
import '../data/profile_service.dart';
import '../domain/auth_profile_check_result.dart';
import '../../../core/session/app_session_controller.dart';
import '../../../core/session/app_session_state.dart';
import '../../../core/feedback/app_feedback_controller.dart';
import '../../../core/errors/supabase_error_mapper.dart';
import '../../../core/messages/app_messages.dart';
import '../../../core/accessibility/accessibility_service.dart';

class AuthSessionCoordinator {
  final AuthService _authService;
  final ProfileService _profileService;
  final AppSessionController _sessionController;
  final AppFeedbackController _feedbackController;
  final AccessibilityService? _accessibilityService;

  StreamSubscription<AuthState>? _authSubscription;
  String? _lastResolvedUserId;

  bool _isSigningIn = false;
  bool _isSigningOut = false;
  bool _isCheckingProfile = false;
  bool _isResolving = false;

  AuthSessionCoordinator({
    required AuthService authService,
    required ProfileService profileService,
    required AppSessionController sessionController,
    required AppFeedbackController feedbackController,
    AccessibilityService? accessibilityService,
  })  : _authService = authService,
        _profileService = profileService,
        _sessionController = sessionController,
        _feedbackController = feedbackController,
        _accessibilityService = accessibilityService;

  Future<void> initialize() async {
    _sessionController.setUnknown();
    _feedbackController.clear();

    // 1. Initial check of currentUser
    final initialUser = _authService.currentUser;
    if (initialUser != null) {
      await _resolveSessionForUser(initialUser);
    } else {
      _sessionController.setUnauthenticated();
    }

    // 2. Register single auth state changes stream listener
    _authSubscription = _authService.authStateChanges.listen(
      (authState) async {
        final event = authState.event;
        final user = authState.session?.user;

        // signedOut event or null user -> unauthenticated
        if (event == AuthChangeEvent.signedOut || user == null) {
          _lastResolvedUserId = null;
          _sessionController.setUnauthenticated();
          _feedbackController.clear();
          return;
        }

        // We handle only specific events: initialSession, signedIn, tokenRefreshed
        if (event == AuthChangeEvent.initialSession ||
            event == AuthChangeEvent.signedIn ||
            event == AuthChangeEvent.tokenRefreshed) {
          
          // Deduplication
          if (user.id == _lastResolvedUserId) {
            final currentStatus = _sessionController.value.status;
            if (currentStatus == AppSessionStatus.authenticatedWithProfile ||
                currentStatus == AppSessionStatus.authenticatedWithoutProfile) {
              // Same user and already authenticated, ignore (especially for tokenRefreshed)
              return;
            }
          }

          await _resolveSessionForUser(user);
          return;
        }

        // Explicit no-op for any other event
      },
      onError: (error) {
        final appException = SupabaseErrorMapper.map(error);
        _feedbackController.showError(appException.message);
        _announce(appException.message);
      },
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty) {
      _feedbackController.showError(AppMessages.emailRequired);
      _announce(AppMessages.emailRequired);
      return;
    }
    if (password.isEmpty) {
      _feedbackController.showError(AppMessages.passwordRequired);
      _announce(AppMessages.passwordRequired);
      return;
    }

    if (_isSigningIn) return;
    _isSigningIn = true;

    try {
      _feedbackController.clear();
      final user = await _authService.signInWithPassword(
        email: email,
        password: password,
      );

      await _resolveSessionForUser(user);
    } catch (e) {
      final appException = SupabaseErrorMapper.map(e);
      _feedbackController.showError(appException.message);
      _announce(appException.message);
    } finally {
      _isSigningIn = false;
    }
  }

  Future<void> signOut() async {
    if (_isSigningOut) return;
    _isSigningOut = true;

    try {
      _feedbackController.clear();
      await _authService.signOut();
      _lastResolvedUserId = null;
      _sessionController.setUnauthenticated();
      _feedbackController.showSuccess(AppMessages.logoutSuccess);
      _announce(AppMessages.logoutSuccess);
    } catch (e) {
      final appException = SupabaseErrorMapper.map(e);
      _feedbackController.showError(appException.message);
      _announce(appException.message);
    } finally {
      _isSigningOut = false;
    }
  }

  Future<void> retryProfileCheck() async {
    if (_isCheckingProfile) return;
    _isCheckingProfile = true;

    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) {
        _sessionController.setUnauthenticated();
        return;
      }
      await _resolveSessionForUser(currentUser);
    } finally {
      _isCheckingProfile = false;
    }
  }

  void dispose() {
    _authSubscription?.cancel();
  }

  Future<void> _resolveSessionForUser(User user) async {
    if (_isResolving) return;
    _isResolving = true;

    try {
      _sessionController.setUnknown();
      _feedbackController.clear();

      final result = await _profileService.checkProfileForUser(user);
      _lastResolvedUserId = user.id;

      switch (result.status) {
        case AuthProfileCheckStatus.missing:
        case AuthProfileCheckStatus.incomplete:
          _sessionController.setAuthenticatedWithoutProfile(user: user);
          if (_isSigningIn) {
            _announce('${AppMessages.loginSuccess} ${AppMessages.profileNotCreatedYet}');
          } else {
            _announce(AppMessages.profileNotCreatedYet);
          }
          break;
        case AuthProfileCheckStatus.complete:
          _sessionController.setAuthenticatedWithProfile(
            user: user,
            profileId: result.profileId!,
            companyId: result.companyId!,
            companyName: result.companyName!,
          );
          if (_isSigningIn) {
            _announce('${AppMessages.loginSuccess} ${AppMessages.loginCompleted}');
          } else {
            _announce(AppMessages.loginCompleted);
          }
          break;
      }
    } catch (e) {
      _lastResolvedUserId = null; // Reset to allow retry/re-check
      final appException = SupabaseErrorMapper.map(e);
      _feedbackController.showError(appException.message);
      _announce(appException.message);
      _sessionController.setUnknown(); // keep unknown status with error
    } finally {
      _isResolving = false;
    }
  }

  void _announce(String message) {
    _accessibilityService?.announce(message, TextDirection.ltr);
  }
}
