import 'package:flutter/material.dart';

class CustomTagBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Border? border;
  final double textSize;
  final Color textColor;
  final IconData? leftIcon;
  final String text;
  final IconData? buttonIcon;
  final VoidCallback? onButtonPressed;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Offset buttonOffset;
  final Color leftIconColor;
  final Color buttonIconColor;
  final VoidCallback? onTap;

  const CustomTagBox({
    required this.width,
    required this.height,
    required this.text,
    this.borderRadius = 8.0,
    this.border,
    this.textSize = 16.0,
    this.textColor = Colors.black,
    this.leftIcon,
    this.buttonIcon,
    this.onButtonPressed,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor = Colors.white,
    this.buttonOffset = const Offset(-8.0, -8.0),
    this.leftIconColor = Colors.black,
    this.buttonIconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
