import 'package:flutter/material.dart';

class IconTextButtonCombination extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color textColor;
  final Color buttonColor;
  final double fontSize;
  final FontWeight fontWeight;

  const IconTextButtonCombination({
    required this.icon,
    required this.text,
    required this.onPressed,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.buttonColor = Colors.blue,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.arrow_forward, color: buttonColor),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
