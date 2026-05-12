import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {

    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {

      case 'active':
        backgroundColor =
            Colors.green.withOpacity(0.15);

        textColor = Colors.green;
        break;

      case 'paused':
        backgroundColor =
            Colors.orange.withOpacity(0.15);

        textColor = Colors.orange;
        break;

      default:
        backgroundColor =
            Colors.red.withOpacity(0.15);

        textColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color: backgroundColor,

        borderRadius:
        BorderRadius.circular(30),
      ),

      child: Text(
        status,

        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}