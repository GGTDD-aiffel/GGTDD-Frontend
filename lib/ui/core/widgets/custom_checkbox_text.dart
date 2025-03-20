import 'package:flutter/material.dart';

class CustomCheckboxText extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;
  final Color checkColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomCheckboxText({
    required this.value,
    required this.onChanged,
    required this.text,
    this.checkColor = Colors.blue,
    this.textColor = Colors.black,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: checkColor,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
