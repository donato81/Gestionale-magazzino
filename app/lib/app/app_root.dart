import 'package:flutter/material.dart';
import '../core/session/app_session_controller.dart';
import '../core/feedback/app_feedback_controller.dart';
import '../features/auth/presentation/session_gate.dart';

class AppRoot extends StatelessWidget {
  final AppSessionController sessionController;
  final AppFeedbackController feedbackController;
  final VoidCallback onRetryProfileCheck;
  final Future<void> Function({required String email, required String password}) onSignIn;
  final VoidCallback onSignOut;

  const AppRoot({
    super.key,
    required this.sessionController,
    required this.feedbackController,
    required this.onRetryProfileCheck,
    required this.onSignIn,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestionale Magazzino',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: SessionGate(
        sessionController: sessionController,
        feedbackController: feedbackController,
        onRetryProfileCheck: onRetryProfileCheck,
        onSignIn: onSignIn,
        onSignOut: onSignOut,
      ),
    );
  }
}
