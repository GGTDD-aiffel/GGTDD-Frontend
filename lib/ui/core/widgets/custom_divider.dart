import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  final double? opacity;
  final double width;
  final double height;
  final Alignment alignment;

  const CustomDivider({
    super.key,
    this.color = const Color(0xFF999999),
    this.opacity = 0.3,
    required this.width,
    this.height = 1.0,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? Theme.of(context).dividerColor;
    final finalColor =
        opacity != null ? dividerColor.withOpacity(opacity!) : dividerColor;

    return Align(
      alignment: alignment,
      child: Container(
        width: width,
        height: height,
        color: finalColor,
      ),
    );
  }
}
