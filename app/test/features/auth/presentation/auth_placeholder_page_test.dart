import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/auth/presentation/auth_placeholder_page.dart';
import 'package:app/core/messages/app_messages.dart';

void main() {
  group('AuthPlaceholderPage Widget Tests', () {
    late bool signOutCalled;

    setUp(() {
      signOutCalled = false;
    });

    Widget buildPlaceholder(AuthPlaceholderType type) {
      return MaterialApp(
        home: AuthPlaceholderPage(
          type: type,
          onSignOut: () {
            signOutCalled = true;
          },
        ),
      );
    }

    testWidgets('onboarding placeholder renders correctly with signOut button', (WidgetTester tester) async {
      await tester.pumpWidget(buildPlaceholder(AuthPlaceholderType.onboarding));

      expect(find.text(AppMessages.profileNotCreatedYet), findsOneWidget);
      expect(find.text(AppMessages.onboardingWillBeImplemented), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, AppMessages.signOut), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, AppMessages.signOut));
      expect(signOutCalled, isTrue);
    });

    testWidgets('home placeholder renders correctly with signOut button', (WidgetTester tester) async {
      await tester.pumpWidget(buildPlaceholder(AuthPlaceholderType.home));

      expect(find.text(AppMessages.loginCompleted), findsOneWidget);
      expect(find.text(AppMessages.homeWillBeImplemented), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, AppMessages.signOut), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, AppMessages.signOut));
      expect(signOutCalled, isTrue);
    });
  });
}
