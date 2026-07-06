import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/supabase_config.dart';
import 'core/session/app_session_controller.dart';
import 'core/feedback/app_feedback_controller.dart';
import 'core/accessibility/accessibility_service.dart';
import 'features/auth/data/auth_service.dart';
import 'features/auth/data/profile_service.dart';
import 'features/auth/application/auth_session_coordinator.dart';
import 'app/app_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.anonKey,
  );

  final sessionController = AppSessionController();
  final feedbackController = AppFeedbackController();
  const accessibilityService = AccessibilityService();

  final authService = SupabaseAuthService(Supabase.instance.client);
  final profileService = SupabaseProfileService(Supabase.instance.client);

  final coordinator = AuthSessionCoordinator(
    authService: authService,
    profileService: profileService,
    sessionController: sessionController,
    feedbackController: feedbackController,
    accessibilityService: accessibilityService,
  );

  // Initialize coordinator (triggers checking initial session / setting auth listeners)
  await coordinator.initialize();

  runApp(
    AppRoot(
      sessionController: sessionController,
      feedbackController: feedbackController,
      onRetryProfileCheck: coordinator.retryProfileCheck,
      onSignIn: coordinator.signIn,
      onSignOut: coordinator.signOut,
    ),
  );
}
