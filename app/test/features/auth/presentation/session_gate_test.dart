import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/auth/presentation/session_gate.dart';
import 'package:app/features/auth/presentation/login_page.dart';
import 'package:app/features/auth/presentation/auth_placeholder_page.dart';
import 'package:app/core/session/app_session_controller.dart';
import 'package:app/core/feedback/app_feedback_controller.dart';
import 'package:app/core/messages/app_messages.dart';

void main() {
  group('SessionGate Widget Tests', () {
    late AppSessionController sessionController;
    late AppFeedbackController feedbackController;
    late bool retryCalled;

    setUp(() {
      sessionController = AppSessionController();
      feedbackController = AppFeedbackController();
      retryCalled = false;
    });

    Widget buildGate() {
      return MaterialApp(
        home: SessionGate(
          sessionController: sessionController,
          feedbackController: feedbackController,
          onRetryProfileCheck: () {
            retryCalled = true;
          },
          onSignIn: ({required email, required password}) async {},
          onSignOut: () {},
        ),
      );
    }

    testWidgets('status unknown without error displays loading indicator and text', (WidgetTester tester) async {
      await tester.pumpWidget(buildGate());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text(AppMessages.checkingSession), findsOneWidget);
      expect(find.byType(LoginPage), findsNothing);
    });

    testWidgets('status unknown with error displays error and retry button', (WidgetTester tester) async {
      await tester.pumpWidget(buildGate());

      feedbackController.showError('Some check failed');
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Some check failed'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, AppMessages.retry), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, AppMessages.retry));
      expect(retryCalled, isTrue);
    });

    testWidgets('status unauthenticated displays LoginPage', (WidgetTester tester) async {
      await tester.pumpWidget(buildGate());

      sessionController.setUnauthenticated();
      await tester.pump();

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('status authenticatedWithoutProfile displays onboarding placeholder', (WidgetTester tester) async {
      await tester.pumpWidget(buildGate());

      sessionController.setAuthenticatedWithoutProfile();
      await tester.pump();

      expect(find.byType(AuthPlaceholderPage), findsOneWidget);
      expect(find.text(AppMessages.profileNotCreatedYet), findsOneWidget);
      expect(find.text(AppMessages.onboardingWillBeImplemented), findsOneWidget);
    });

    testWidgets('status authenticatedWithProfile displays home placeholder', (WidgetTester tester) async {
      await tester.pumpWidget(buildGate());

      sessionController.setAuthenticatedWithProfile(
        profileId: 'prof_1',
        companyId: 'comp_1',
        companyName: 'Company Name',
      );
      await tester.pump();

      expect(find.byType(AuthPlaceholderPage), findsOneWidget);
      expect(find.text(AppMessages.loginCompleted), findsOneWidget);
      expect(find.text(AppMessages.homeWillBeImplemented), findsOneWidget);
    });
  });
}
