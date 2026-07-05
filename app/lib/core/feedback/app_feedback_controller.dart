import 'package:flutter/foundation.dart';
import 'app_feedback_message.dart';

class AppFeedbackController extends ValueNotifier<AppFeedbackMessage?> {
  AppFeedbackController() : super(null);

  void showSuccess(
    String text, {
    String? accessibilityText,
    bool shouldAnnounce = true,
  }) {
    value = AppFeedbackMessage(
      text: text,
      type: AppFeedbackType.success,
      accessibilityText: accessibilityText,
      shouldAnnounce: shouldAnnounce,
    );
  }

  void showError(
    String text, {
    String? accessibilityText,
    bool shouldAnnounce = true,
  }) {
    value = AppFeedbackMessage(
      text: text,
      type: AppFeedbackType.error,
      accessibilityText: accessibilityText,
      shouldAnnounce: shouldAnnounce,
    );
  }

  void showWarning(
    String text, {
    String? accessibilityText,
    bool shouldAnnounce = true,
  }) {
    value = AppFeedbackMessage(
      text: text,
      type: AppFeedbackType.warning,
      accessibilityText: accessibilityText,
      shouldAnnounce: shouldAnnounce,
    );
  }

  void showInfo(
    String text, {
    String? accessibilityText,
    bool shouldAnnounce = true,
  }) {
    value = AppFeedbackMessage(
      text: text,
      type: AppFeedbackType.info,
      accessibilityText: accessibilityText,
      shouldAnnounce: shouldAnnounce,
    );
  }

  void clear() {
    value = null;
  }
}
