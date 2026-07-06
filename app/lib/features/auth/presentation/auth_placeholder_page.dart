import 'package:flutter/material.dart';
import '../../../core/messages/app_messages.dart';

enum AuthPlaceholderType {
  onboarding,
  home,
}

class AuthPlaceholderPage extends StatelessWidget {
  final AuthPlaceholderType type;
  final VoidCallback onSignOut;

  const AuthPlaceholderPage({
    super.key,
    required this.type,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOnboarding = type == AuthPlaceholderType.onboarding;
    final String titleText = isOnboarding
        ? AppMessages.profileNotCreatedYet
        : AppMessages.loginCompleted;
    final String bodyText = isOnboarding
        ? AppMessages.onboardingWillBeImplemented
        : AppMessages.homeWillBeImplemented;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isOnboarding ? Icons.person_add_outlined : Icons.home_outlined,
                  size: 64.0,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(height: 24.0),
                Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  bodyText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 48.0),
                Semantics(
                  label: AppMessages.signOut,
                  button: true,
                  child: ElevatedButton.icon(
                    onPressed: onSignOut,
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text(AppMessages.signOut),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
