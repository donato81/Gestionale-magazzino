import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/auth/presentation/login_page.dart';
import 'package:app/core/feedback/app_feedback_controller.dart';
import 'package:app/core/messages/app_messages.dart';

void main() {
  group('LoginPage Widget Tests', () {
    late AppFeedbackController feedbackController;
    late int signInCallCount;
    late Future<void> Function({required String email, required String password}) onSignInMock;

    setUp(() {
      feedbackController = AppFeedbackController();
      signInCallCount = 0;
      onSignInMock = ({required email, required password}) async {
        signInCallCount++;
        await Future.delayed(const Duration(milliseconds: 50));
      };
    });

    Widget buildLoginPage() {
      return MaterialApp(
        home: LoginPage(
          feedbackController: feedbackController,
          onSignIn: onSignInMock,
        ),
      );
    }

    testWidgets('fields and submit button are present, password is obscured', (WidgetTester tester) async {
      await tester.pumpWidget(buildLoginPage());

      expect(find.widgetWithText(TextField, AppMessages.email), findsOneWidget);
      expect(find.widgetWithText(TextField, AppMessages.password), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, AppMessages.signIn), findsOneWidget);

      final passwordField = tester.widget<TextField>(find.widgetWithText(TextField, AppMessages.password));
      expect(passwordField.obscureText, isTrue);
    });

    testWidgets('submit with empty email produces feedback', (WidgetTester tester) async {
      await tester.pumpWidget(buildLoginPage());

      await tester.enterText(find.widgetWithText(TextField, AppMessages.password), 'secret123');
      await tester.tap(find.widgetWithText(ElevatedButton, AppMessages.signIn));
      await tester.pump();

      expect(feedbackController.value?.text, AppMessages.emailRequired);
      expect(signInCallCount, 0);
    });

    testWidgets('submit with empty password produces feedback', (WidgetTester tester) async {
      await tester.pumpWidget(buildLoginPage());

      await tester.enterText(find.widgetWithText(TextField, AppMessages.email), 'test@example.com');
      await tester.tap(find.widgetWithText(ElevatedButton, AppMessages.signIn));
      await tester.pump();

      expect(feedbackController.value?.text, AppMessages.passwordRequired);
      expect(signInCallCount, 0);
    });

    testWidgets('submit is triggered and multiple taps during submission are ignored', (WidgetTester tester) async {
      await tester.pumpWidget(buildLoginPage());

      await tester.enterText(find.widgetWithText(TextField, AppMessages.email), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextField, AppMessages.password), 'secret123');

      await tester.tap(find.widgetWithText(ElevatedButton, AppMessages.signIn));
      await tester.tap(find.widgetWithText(ElevatedButton, AppMessages.signIn));
      
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 100));

      expect(signInCallCount, 1);
    });

    testWidgets('persistent error remains visible in AppFeedbackView', (WidgetTester tester) async {
      await tester.pumpWidget(buildLoginPage());

      feedbackController.showError('Login failed dramatically');
      await tester.pump();

      expect(find.text('Login failed dramatically'), findsOneWidget);
    });
  });
}
