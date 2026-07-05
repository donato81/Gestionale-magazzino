import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/core/accessibility/accessibility_service.dart';

void main() {
  // Ensure the binding is initialized so that SemanticsService.announce doesn't crash on channel communication
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AccessibilityService Tests', () {
    const service = AccessibilityService();

    test('announce ignores empty message and does not throw', () {
      expect(
        () => service.announce('', TextDirection.ltr),
        returnsNormally,
      );
    });

    test('announce ignores blank message (spaces only) and does not throw', () {
      expect(
        () => service.announce('    ', TextDirection.ltr),
        returnsNormally,
      );
    });

    test('announce with valid message does not throw', () {
      expect(
        () => service.announce('Valid announcement message', TextDirection.ltr),
        returnsNormally,
      );
    });
  });
}
