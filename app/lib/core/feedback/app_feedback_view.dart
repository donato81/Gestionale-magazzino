import 'package:flutter/material.dart';
import 'app_feedback_controller.dart';
import 'app_feedback_message.dart';

class AppFeedbackView extends StatelessWidget {
  final AppFeedbackController controller;

  const AppFeedbackView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppFeedbackMessage?>(
      valueListenable: controller,
      builder: (context, message, child) {
        if (message == null) {
          return const SizedBox.shrink();
        }

        IconData icon;
        Color color;
        String label;

        switch (message.type) {
          case AppFeedbackType.success:
            icon = Icons.check_circle_outline;
            color = Colors.green.shade700;
            label = 'Successo: ';
            break;
          case AppFeedbackType.error:
            icon = Icons.error_outline;
            color = Colors.red.shade700;
            label = 'Errore: ';
            break;
          case AppFeedbackType.warning:
            icon = Icons.warning_amber_outlined;
            color = Colors.orange.shade800;
            label = 'Attenzione: ';
            break;
          case AppFeedbackType.info:
            icon = Icons.info_outline;
            color = Colors.blue.shade700;
            label = 'Info: ';
            break;
        }

        return Semantics(
          liveRegion: true,
          label: '$label${message.effectiveAccessibilityText}',
          child: Container(
            key: const ValueKey('app_feedback_container'),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color, width: 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: color,
                  semanticLabel: label,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
