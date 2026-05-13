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
        const Color(0xff123B2A);

        textColor =
        const Color(0xff22C55E);

        break;

      case 'paused':

        backgroundColor =
        const Color(0xff4A3214);

        textColor =
        const Color(0xffF59E0B);

        break;

      default:

        backgroundColor =
        const Color(0xff3B1212);

        textColor =
        const Color(0xffEF4444);
    }

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(

        color: backgroundColor,

        borderRadius:
        BorderRadius.circular(8),
      ),

      child: Row(

        mainAxisSize: MainAxisSize.min,

        children: [

          Container(
            width: 6,
            height: 6,

            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 6),

          Text(
            status,

            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}