enum AppFeedbackType {
  success,
  error,
  warning,
  info,
}

class AppFeedbackMessage {
  final String text;
  final AppFeedbackType type;
  final String? accessibilityText;
  final bool shouldAnnounce;

  const AppFeedbackMessage({
    required this.text,
    required this.type,
    this.accessibilityText,
    this.shouldAnnounce = true,
  });

  String get effectiveAccessibilityText => accessibilityText ?? text;
}
