import 'package:flutter/material.dart';

class DialogContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double? width;
  final double? maxWidth;
  final double? height;
  final BorderRadius borderRadius;

  const DialogContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.width,
    this.maxWidth,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        constraints:
            maxWidth != null ? BoxConstraints(maxWidth: maxWidth!) : null,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}
