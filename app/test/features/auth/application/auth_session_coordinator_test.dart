import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/auth/application/auth_session_coordinator.dart';
import 'package:app/features/auth/data/auth_service.dart';
import 'package:app/features/auth/data/profile_service.dart';
import 'package:app/features/auth/domain/auth_profile_check_result.dart';
import 'package:app/core/session/app_session_controller.dart';
import 'package:app/core/session/app_session_state.dart';
import 'package:app/core/feedback/app_feedback_controller.dart';
import 'package:app/core/messages/app_messages.dart';

class FakeAuthService implements AuthService {
  User? _currentUser;
  final _controller = StreamController<AuthState>.broadcast();
  int signInCallCount = 0;
  int signOutCallCount = 0;

  User? Function(String email, String password)? onSignIn;
  Future<void> Function()? onSignOutCustom;

  void setCurrentUser(User? user) {
    _currentUser = user;
  }

  void emit(AuthState state) {
    _controller.add(state);
  }

  void emitError(Object error) {
    _controller.addError(error);
  }

  @override
  User? get currentUser => _currentUser;

  @override
  Stream<AuthState> get authStateChanges => _controller.stream;

  @override
  Future<User> signInWithPassword({
    required String email,
    required String password,
  }) async {
    signInCallCount++;
    await Future.delayed(const Duration(milliseconds: 10));
    if (onSignIn != null) {
      final user = onSignIn!(email, password);
      if (user == null) {
        throw const AuthException('Invalid login credentials', statusCode: '400');
      }
      return user;
    }
    throw const AuthException('Invalid login credentials', statusCode: '400');
  }

  @override
  Future<void> signOut() async {
    signOutCallCount++;
    await Future.delayed(const Duration(milliseconds: 10));
    if (onSignOutCustom != null) {
      await onSignOutCustom!();
    }
    _currentUser = null;
  }

  void dispose() {
    _controller.close();
  }
}

class FakeProfileService implements ProfileService {
  int checkCallCount = 0;
  AuthProfileCheckResult Function(User user)? onCheck;

  @override
  Future<AuthProfileCheckResult> checkProfileForUser(User user) async {
    checkCallCount++;
    await Future.delayed(const Duration(milliseconds: 10));
    if (onCheck != null) {
      return onCheck!(user);
    }
    return AuthProfileCheckResult.missing();
  }
}

void main() {
  late FakeAuthService authService;
  late FakeProfileService profileService;
  late AppSessionController sessionController;
  late AppFeedbackController feedbackController;
  late AuthSessionCoordinator coordinator;

  final testUser = User(
    id: 'user_uuid_123',
    appMetadata: const {},
    userMetadata: const {},
    aud: 'authenticated',
    createdAt: '2026-07-06T00:00:00Z',
  );

  setUp(() {
    authService = FakeAuthService();
    profileService = FakeProfileService();
    sessionController = AppSessionController();
    feedbackController = AppFeedbackController();
    coordinator = AuthSessionCoordinator(
      authService: authService,
      profileService: profileService,
      sessionController: sessionController,
      feedbackController: feedbackController,
    );
  });

  tearDown(() {
    coordinator.dispose();
    authService.dispose();
  });

  group('AuthSessionCoordinator - initialize() Tests', () {
    test('initialize without user sets status to unauthenticated', () async {
      authService.setCurrentUser(null);
      await coordinator.initialize();

      expect(sessionController.value.status, AppSessionStatus.unauthenticated);
      expect(feedbackController.value, isNull);
    });

    test('initialize with user and profile missing sets status to authenticatedWithoutProfile', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => AuthProfileCheckResult.missing();

      await coordinator.initialize();

      expect(sessionController.value.status, AppSessionStatus.authenticatedWithoutProfile);
      expect(sessionController.value.user?.id, testUser.id);
      expect(profileService.checkCallCount, 1);
    });

    test('initialize with user and profile incomplete sets status to authenticatedWithoutProfile', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => AuthProfileCheckResult.incomplete(profileId: 'prof_123');

      await coordinator.initialize();

      expect(sessionController.value.status, AppSessionStatus.authenticatedWithoutProfile);
      expect(sessionController.value.profileId, isNull);
    });

    test('initialize with user and profile complete sets status to authenticatedWithProfile', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => AuthProfileCheckResult.complete(
            profileId: 'prof_123',
            companyId: 'comp_456',
            companyName: 'ACME Corp',
          );

      await coordinator.initialize();

      expect(sessionController.value.status, AppSessionStatus.authenticatedWithProfile);
      expect(sessionController.value.profileId, 'prof_123');
      expect(sessionController.value.companyId, 'comp_456');
      expect(sessionController.value.companyName, 'ACME Corp');
    });

    test('initialize with profile but company unreadable sets status to unknown with error feedback', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => throw const PostgrestException(
            message: 'violates row-level security',
            code: '42501',
          );

      await coordinator.initialize();

      expect(sessionController.value.status, AppSessionStatus.unknown);
      expect(feedbackController.value?.text, AppMessages.unauthorized);
    });

    test('initialize avoids double resolution of the same user.id', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => AuthProfileCheckResult.missing();

      // Start initialize
      final initFuture = coordinator.initialize();

      // Emit initialSession event on the stream for the same user
      authService.emit(AuthState(AuthChangeEvent.initialSession, Session(
        accessToken: 'abc',
        tokenType: 'bearer',
        user: testUser,
      )));

      await initFuture;
      await Future.delayed(const Duration(milliseconds: 50));

      // ProfileService should only be called once because of deduplication
      expect(profileService.checkCallCount, 1);
    });
  });

  group('AuthSessionCoordinator - signIn() Tests', () {
    test('signIn with empty email sets feedback error', () async {
      await coordinator.signIn(email: '', password: 'password123');
      expect(feedbackController.value?.text, AppMessages.emailRequired);
      expect(authService.signInCallCount, 0);
    });

    test('signIn with empty password sets feedback error', () async {
      await coordinator.signIn(email: 'test@email.com', password: '');
      expect(feedbackController.value?.text, AppMessages.passwordRequired);
      expect(authService.signInCallCount, 0);
    });

    test('signIn failed sets feedback error mapped', () async {
      authService.onSignIn = (e, p) => null; // returns null -> throws AuthException
      await coordinator.signIn(email: 'test@email.com', password: 'wrong_password');

      expect(feedbackController.value?.text, AppMessages.invalidCredentials);
      expect(sessionController.value.status, AppSessionStatus.unknown);
    });

    test('signIn succeeded with profile complete sets authenticatedWithProfile', () async {
      authService.onSignIn = (e, p) => testUser;
      profileService.onCheck = (u) => AuthProfileCheckResult.complete(
            profileId: 'prof_123',
            companyId: 'comp_456',
            companyName: 'ACME Corp',
          );

      await coordinator.signIn(email: 'test@email.com', password: 'password123');

      expect(sessionController.value.status, AppSessionStatus.authenticatedWithProfile);
      expect(sessionController.value.companyName, 'ACME Corp');
    });

    test('signIn succeeded with profile missing sets authenticatedWithoutProfile', () async {
      authService.onSignIn = (e, p) => testUser;
      profileService.onCheck = (u) => AuthProfileCheckResult.missing();

      await coordinator.signIn(email: 'test@email.com', password: 'password123');

      expect(sessionController.value.status, AppSessionStatus.authenticatedWithoutProfile);
    });

    test('dooppio signIn in progress is throttled to one call', () async {
      authService.onSignIn = (e, p) => testUser;
      profileService.onCheck = (u) => AuthProfileCheckResult.missing();

      final firstCall = coordinator.signIn(email: 'test@email.com', password: 'password123');
      final secondCall = coordinator.signIn(email: 'test@email.com', password: 'password123');

      await Future.wait([firstCall, secondCall]);

      expect(authService.signInCallCount, 1);
    });
  });

  group('AuthSessionCoordinator - signOut() Tests', () {
    test('signOut succeeded transitions to unauthenticated and sets success message', () async {
      sessionController.setAuthenticatedWithProfile(
        user: testUser,
        profileId: 'prof_123',
        companyId: 'comp_456',
        companyName: 'ACME Corp',
      );

      await coordinator.signOut();

      expect(sessionController.value.status, AppSessionStatus.unauthenticated);
      expect(sessionController.value.user, isNull);
      expect(feedbackController.value?.text, AppMessages.logoutSuccess);
      expect(authService.signOutCallCount, 1);
    });

    test('doppio signOut in progress is throttled to one call', () async {
      final firstCall = coordinator.signOut();
      final secondCall = coordinator.signOut();

      await Future.wait([firstCall, secondCall]);

      expect(authService.signOutCallCount, 1);
    });

    test('signOut failed sets mapped error', () async {
      authService.onSignOutCustom = () => throw const AuthException('Logout failed', statusCode: '500');

      await coordinator.signOut();

      expect(feedbackController.value?.text, AppMessages.genericError);
    });
  });

  group('AuthSessionCoordinator - stream changes & retry Tests', () {
    test('signedOut stream event transitions to unauthenticated', () async {
      await coordinator.initialize();
      sessionController.setAuthenticatedWithoutProfile(user: testUser);

      authService.emit(AuthState(AuthChangeEvent.signedOut, null));
      await Future.delayed(const Duration(milliseconds: 10));

      expect(sessionController.value.status, AppSessionStatus.unauthenticated);
    });

    test('tokenRefreshed with same user id is no-op if already authenticated', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => AuthProfileCheckResult.complete(
            profileId: 'prof_123',
            companyId: 'comp_456',
            companyName: 'ACME Corp',
          );

      await coordinator.initialize();
      expect(profileService.checkCallCount, 1);

      // Emit tokenRefreshed for same user
      authService.emit(AuthState(AuthChangeEvent.tokenRefreshed, Session(
        accessToken: 'new_token',
        tokenType: 'bearer',
        user: testUser,
      )));
      await Future.delayed(const Duration(milliseconds: 10));

      // No new check calls should occur
      expect(profileService.checkCallCount, 1);
    });

    test('retryProfileCheck without user transitions to unauthenticated', () async {
      authService.setCurrentUser(null);
      await coordinator.retryProfileCheck();
      expect(sessionController.value.status, AppSessionStatus.unauthenticated);
    });

    test('retryProfileCheck with user retries and resolves successfully', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => throw Exception('failed host lookup');

      await coordinator.initialize();
      expect(sessionController.value.status, AppSessionStatus.unknown);
      expect(feedbackController.value?.text, AppMessages.networkError);

      // Configure successful check for retry
      profileService.onCheck = (u) => AuthProfileCheckResult.complete(
            profileId: 'prof_123',
            companyId: 'comp_456',
            companyName: 'New Company Name',
          );

      await coordinator.retryProfileCheck();

      expect(sessionController.value.status, AppSessionStatus.authenticatedWithProfile);
      expect(sessionController.value.companyName, 'New Company Name');
      expect(feedbackController.value, isNull);
    });

    test('doppio retryProfileCheck is throttled to one call', () async {
      authService.setCurrentUser(testUser);
      profileService.onCheck = (u) => AuthProfileCheckResult.missing();

      final firstCall = coordinator.retryProfileCheck();
      final secondCall = coordinator.retryProfileCheck();

      await Future.wait([firstCall, secondCall]);

      expect(profileService.checkCallCount, 1);
    });

    test('unhandled auth events are no-op', () async {
      await coordinator.initialize();
      final previousStatus = sessionController.value.status;

      // Emit some other event like passwordRecovery
      authService.emit(AuthState(AuthChangeEvent.passwordRecovery, Session(
        accessToken: 'abc',
        tokenType: 'bearer',
        user: testUser,
      )));
      await Future.delayed(const Duration(milliseconds: 10));

      expect(sessionController.value.status, previousStatus);
    });

    test('stream onError mapped properly and keeps safe state', () async {
      await coordinator.initialize();

      authService.emitError(const AuthException('JWT expired', statusCode: '401'));
      await Future.delayed(const Duration(milliseconds: 10));

      expect(feedbackController.value?.text, AppMessages.sessionExpired);
    });
  });
}
