import 'package:enable_bluetooh_profile_task/utils/colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String message;
  final TextStyle? textStyle;

  const TextWidget({super.key, required this.message, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(message, style: const TextStyle(color: textColor)),
    );
  }
}
