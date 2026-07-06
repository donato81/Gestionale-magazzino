import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../../../core/feedback/app_feedback_controller.dart';
import '../../../core/feedback/app_feedback_view.dart';
import '../../../core/messages/app_messages.dart';

class LoginPage extends StatefulWidget {
  final AppFeedbackController feedbackController;
  final Future<void> Function({required String email, required String password}) onSignIn;

  const LoginPage({
    super.key,
    required this.feedbackController,
    required this.onSignIn,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_isLoading) return;
    final email = _emailController.text;
    final password = _passwordController.text;

    // Validate inputs
    if (email.trim().isEmpty) {
      widget.feedbackController.showError(AppMessages.emailRequired);
      // ignore: deprecated_member_use
      SemanticsService.announce(AppMessages.emailRequired, TextDirection.ltr);
      return;
    }
    if (password.isEmpty) {
      widget.feedbackController.showError(AppMessages.passwordRequired);
      // ignore: deprecated_member_use
      SemanticsService.announce(AppMessages.passwordRequired, TextDirection.ltr);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onSignIn(email: email, password: password);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48.0),
              Center(
                child: Text(
                  AppMessages.login,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 36.0),
              
              // Persistent Feedback View
              AppFeedbackView(controller: widget.feedbackController),
              const SizedBox(height: 12.0),

              // Email field
              Semantics(
                label: AppMessages.email,
                textField: true,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: AppMessages.email,
                    border: OutlineInputBorder(),
                  ),
                  autofillHints: const [AutofillHints.email],
                ),
              ),
              const SizedBox(height: 20.0),

              // Password field
              Semantics(
                label: AppMessages.password,
                textField: true,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: AppMessages.password,
                    border: OutlineInputBorder(),
                  ),
                  autofillHints: const [AutofillHints.password],
                ),
              ),
              const SizedBox(height: 32.0),

              // Submit Button
              Semantics(
                button: true,
                label: AppMessages.signIn,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue.shade200,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          AppMessages.signIn,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
