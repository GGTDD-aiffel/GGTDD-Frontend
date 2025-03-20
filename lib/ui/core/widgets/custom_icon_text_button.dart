import 'package:flutter/material.dart';

class CustomIconTextButton extends StatelessWidget {
  final IconData? leftIcon;
  final String text;
  final IconData? rightIcon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? leftIconSize;
  final double? rightIconSize;
  final Color? leftIconColor;
  final Color? rightIconColor;
  final double? leftIconMargin;

  const CustomIconTextButton({
    super.key,
    this.leftIcon,
    required this.text,
    this.rightIcon,
    this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(12),
    this.textColor,
    this.fontSize = 16,
    this.fontWeight,
    this.leftIconSize = 24,
    this.rightIconSize = 24,
    this.leftIconColor,
    this.rightIconColor,
    this.leftIconMargin = 32,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextColor = textColor ?? theme.textTheme.bodyLarge?.color;

    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: padding!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (leftIcon != null) ...[
                      Icon(
                        leftIcon,
                        size: leftIconSize,
                        color: leftIconColor ?? defaultTextColor,
                      ),
                      SizedBox(width: leftIconMargin),
                    ],
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: defaultTextColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (rightIcon != null)
                Icon(
                  rightIcon,
                  size: rightIconSize,
                  color: rightIconColor ?? defaultTextColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
