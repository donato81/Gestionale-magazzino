import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/core/feedback/app_feedback_controller.dart';
import 'package:app/core/feedback/app_feedback_view.dart';

void main() {
  group('AppFeedbackView Tests', () {
    late AppFeedbackController controller;

    setUp(() {
      controller = AppFeedbackController();
    });

    testWidgets('no feedback shows empty widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFeedbackView(controller: controller),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('app_feedback_container')), findsNothing);
    });

    testWidgets('error feedback displays text and has semantic live region', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFeedbackView(controller: controller),
          ),
        ),
      );

      controller.showError('Something went wrong');
      await tester.pump();

      expect(find.byKey(const ValueKey('app_feedback_container')), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);

      final Finder semanticsFinder = find.ancestor(
        of: find.byKey(const ValueKey('app_feedback_container')),
        matching: find.byType(Semantics),
      ).first;
      final Semantics semanticsWidget = tester.widget<Semantics>(semanticsFinder);
      expect(semanticsWidget.properties.liveRegion, isTrue);
      expect(semanticsWidget.properties.label, 'Errore: Something went wrong');
    });

    testWidgets('success feedback displays success text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFeedbackView(controller: controller),
          ),
        ),
      );

      controller.showSuccess('Operation successful');
      await tester.pump();

      expect(find.byKey(const ValueKey('app_feedback_container')), findsOneWidget);
      expect(find.text('Operation successful'), findsOneWidget);

      final Finder semanticsFinder = find.ancestor(
        of: find.byKey(const ValueKey('app_feedback_container')),
        matching: find.byType(Semantics),
      ).first;
      final Semantics semanticsWidget = tester.widget<Semantics>(semanticsFinder);
      expect(semanticsWidget.properties.liveRegion, isTrue);
      expect(semanticsWidget.properties.label, 'Successo: Operation successful');
    });

    testWidgets('warning feedback displays warning text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFeedbackView(controller: controller),
          ),
        ),
      );

      controller.showWarning('This is a warning');
      await tester.pump();

      expect(find.byKey(const ValueKey('app_feedback_container')), findsOneWidget);
      expect(find.text('This is a warning'), findsOneWidget);

      final Finder semanticsFinder = find.ancestor(
        of: find.byKey(const ValueKey('app_feedback_container')),
        matching: find.byType(Semantics),
      ).first;
      final Semantics semanticsWidget = tester.widget<Semantics>(semanticsFinder);
      expect(semanticsWidget.properties.liveRegion, isTrue);
      expect(semanticsWidget.properties.label, 'Attenzione: This is a warning');
    });

    testWidgets('info feedback displays info text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFeedbackView(controller: controller),
          ),
        ),
      );

      controller.showInfo('Useful info');
      await tester.pump();

      expect(find.byKey(const ValueKey('app_feedback_container')), findsOneWidget);
      expect(find.text('Useful info'), findsOneWidget);

      final Finder semanticsFinder = find.ancestor(
        of: find.byKey(const ValueKey('app_feedback_container')),
        matching: find.byType(Semantics),
      ).first;
      final Semantics semanticsWidget = tester.widget<Semantics>(semanticsFinder);
      expect(semanticsWidget.properties.liveRegion, isTrue);
      expect(semanticsWidget.properties.label, 'Info: Useful info');
    });
  });
}
