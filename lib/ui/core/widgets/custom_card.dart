import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double width;
  final double? height;
  final double? maxWidth;
  final EdgeInsets padding;
  final double borderRadius;
  final Border? border;

  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.width = double.infinity,
    this.height,
    this.maxWidth,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 10.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          maxWidth != null ? BoxConstraints(maxWidth: maxWidth!) : null,
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ?? Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}
