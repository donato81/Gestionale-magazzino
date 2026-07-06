import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth_placeholder_page.dart';
import '../../../core/session/app_session_controller.dart';
import '../../../core/session/app_session_state.dart';
import '../../../core/feedback/app_feedback_controller.dart';
import '../../../core/feedback/app_feedback_message.dart';
import '../../../core/messages/app_messages.dart';

class SessionGate extends StatelessWidget {
  final AppSessionController sessionController;
  final AppFeedbackController feedbackController;
  final VoidCallback onRetryProfileCheck;
  final Future<void> Function({required String email, required String password}) onSignIn;
  final VoidCallback onSignOut;

  const SessionGate({
    super.key,
    required this.sessionController,
    required this.feedbackController,
    required this.onRetryProfileCheck,
    required this.onSignIn,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([sessionController, feedbackController]),
      builder: (context, _) {
        final sessionState = sessionController.value;
        final feedback = feedbackController.value;

        switch (sessionState.status) {
          case AppSessionStatus.unknown:
            if (feedback != null && feedback.type == AppFeedbackType.error) {
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48.0,
                            semanticLabel: 'Icona errore',
                          ),
                          const SizedBox(height: 16.0),
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              feedback.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          ElevatedButton.icon(
                            onPressed: onRetryProfileCheck,
                            icon: const Icon(Icons.refresh),
                            label: const Text(AppMessages.retry),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text(
                      AppMessages.checkingSession,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );

          case AppSessionStatus.unauthenticated:
            return LoginPage(
              feedbackController: feedbackController,
              onSignIn: onSignIn,
            );

          case AppSessionStatus.authenticatedWithoutProfile:
            return AuthPlaceholderPage(
              type: AuthPlaceholderType.onboarding,
              onSignOut: onSignOut,
            );

          case AppSessionStatus.authenticatedWithProfile:
            return AuthPlaceholderPage(
              type: AuthPlaceholderType.home,
              onSignOut: onSignOut,
            );
        }
      },
    );
  }
}
