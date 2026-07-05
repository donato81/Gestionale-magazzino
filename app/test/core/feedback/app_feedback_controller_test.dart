import 'package:flutter_test/flutter_test.dart';
import 'package:app/core/feedback/app_feedback_message.dart';
import 'package:app/core/feedback/app_feedback_controller.dart';

void main() {
  group('AppFeedbackController Tests', () {
    late AppFeedbackController controller;

    setUp(() {
      controller = AppFeedbackController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Initial value should be null', () {
      expect(controller.value, isNull);
    });

    test('showSuccess sets success message correctly', () {
      controller.showSuccess('Operation completed successfully.');

      final msg = controller.value;
      expect(msg, isNotNull);
      expect(msg!.text, 'Operation completed successfully.');
      expect(msg.type, AppFeedbackType.success);
      expect(msg.shouldAnnounce, isTrue);
      expect(msg.effectiveAccessibilityText, 'Operation completed successfully.');
    });

    test('showError sets error message correctly', () {
      controller.showError('Operation failed.', accessibilityText: 'Error: Operation failed.');

      final msg = controller.value;
      expect(msg, isNotNull);
      expect(msg!.text, 'Operation failed.');
      expect(msg.type, AppFeedbackType.error);
      expect(msg.shouldAnnounce, isTrue);
      expect(msg.accessibilityText, 'Error: Operation failed.');
      expect(msg.effectiveAccessibilityText, 'Error: Operation failed.');
    });

    test('showWarning sets warning message correctly', () {
      controller.showWarning('Low stock!', shouldAnnounce: false);

      final msg = controller.value;
      expect(msg, isNotNull);
      expect(msg!.text, 'Low stock!');
      expect(msg.type, AppFeedbackType.warning);
      expect(msg.shouldAnnounce, isFalse);
      expect(msg.effectiveAccessibilityText, 'Low stock!');
    });

    test('showInfo sets info message correctly', () {
      controller.showInfo('Loading fresh data.');

      final msg = controller.value;
      expect(msg, isNotNull);
      expect(msg!.text, 'Loading fresh data.');
      expect(msg.type, AppFeedbackType.info);
      expect(msg.shouldAnnounce, isTrue);
    });

    test('clear clears the current feedback message', () {
      controller.showSuccess('Completed.');
      expect(controller.value, isNotNull);

      controller.clear();
      expect(controller.value, isNull);
    });
  });
}
