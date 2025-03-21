import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ggtdd_frontend/ui/core/theme/app_colors.dart';

class CustomStyleTagBox extends StatelessWidget {
  final double? width;
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
  final String type;
  final String category;

  const CustomStyleTagBox({
    required this.height,
    required this.text,
    this.width,
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
    required this.type,
    required this.category,
  });

  IconData _getIconForType(String type) {
    switch (type) {
      case 'time':
        return Icons.access_time;
      case 'space':
        return Icons.location_on;
      case 'etc':
        return Icons.menu;
      default:
        return Icons.tag;
    }
  }

  Color _getBackgroundColor(String type, String category, bool isDarkMode) {
    final index = _getColorIndex(type, category);
    return isDarkMode
        ? AppColors.tagBackgroundColorsDark[index]
        : AppColors.tagBackgroundColorsLight[index];
  }

  Color _getTextColor(String type, String category, bool isDarkMode) {
    final index = _getColorIndex(type, category);
    return isDarkMode
        ? AppColors.tagTextColorsDark[index]
        : AppColors.tagTextColorsLight[index];
  }

  Color _getIconColor(String type, String category, bool isDarkMode) {
    final index = _getColorIndex(type, category);
    return isDarkMode
        ? AppColors.tagIconColorsDark[index]
        : AppColors.tagIconColorsLight[index];
  }

  int _getColorIndex(String type, String category) {
    switch (type) {
      case 'time':
        switch (category) {
          case 'time_unit':
            return 7;
          case 'week_unit':
            return 0;
          case 'commute_unit':
            return 2;
          case 'meal_unit':
            return 1;
          case 'day_night_unit':
            return 3;
          default:
            return 0;
        }
      case 'space':
        switch (category) {
          case 'place':
            return 4;
          case 'vehicle':
            return 5;
          default:
            return 0;
        }
      case 'etc':
        switch (category) {
          case 'basic':
            return 6;
          default:
            return 0;
        }
      default:
        return 0;
    }
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor =
        _getBackgroundColor(type, category, isDarkMode);
    final effectiveTextColor = _getTextColor(type, category, isDarkMode);
    final effectiveIconColor = _getIconColor(type, category, isDarkMode);
    final effectiveIcon = _getIconForType(type);

    final textStyle = TextStyle(
      fontSize: textSize,
      color: effectiveTextColor,
      fontWeight: FontWeight.bold,
    );

    final iconWidth = textSize * 1.3;
    final textWidth = _calculateTextWidth(text, textStyle);
    final gapWidth = 8.0;
    final paddingWidth = padding.horizontal;
    final calculatedWidth = iconWidth + gapWidth + textWidth + paddingWidth;

    final effectiveWidth =
        width ?? calculatedWidth.clamp(100.0, double.infinity);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: effectiveWidth,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
        ),
        child: Row(
          children: [
            Icon(
              effectiveIcon,
              color: effectiveIconColor,
              size: textSize * 1.2,
            ),
            const Gap(8),
            Expanded(
              child: Text(
                text,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (buttonIcon != null)
              Positioned(
                right: buttonOffset.dx,
                top: buttonOffset.dy,
                child: IconButton(
                  icon: Icon(
                    buttonIcon,
                    color: buttonIconColor,
                    size: textSize,
                  ),
                  onPressed: onButtonPressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
