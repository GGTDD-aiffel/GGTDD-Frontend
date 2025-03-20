import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/ui/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8.0,
    this.width = 200.0,
    this.height = 50.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = backgroundColor ??
        (isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary);
    final defaultTextColor = textColor ??
        (isDarkMode ? AppColors.darkPrimaryText : AppColors.lightPrimaryText);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultBackgroundColor,
          foregroundColor: defaultTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
