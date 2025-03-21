import 'package:flutter/material.dart';

class SimpleTextWidgetRow extends StatelessWidget {
  final String text;
  final Widget rightWidget;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const SimpleTextWidgetRow({
    super.key,
    required this.text,
    required this.rightWidget,
    this.textStyle,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: padding!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textStyle ?? const TextStyle(fontSize: 16),
            ),
            rightWidget,
          ],
        ),
      ),
    );
  }
}
