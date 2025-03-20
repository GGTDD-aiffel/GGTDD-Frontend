import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final Widget content;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;

  const CustomModal({
    required this.content,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: content,
      ),
    );
  }
}
