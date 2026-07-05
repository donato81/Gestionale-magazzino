import 'package:flutter/semantics.dart';

class AccessibilityService {
  const AccessibilityService();

  void announce(String message, TextDirection textDirection) {
    if (message.trim().isEmpty) {
      return;
    }
    // ignore: deprecated_member_use
    SemanticsService.announce(message, textDirection);
  }
}
