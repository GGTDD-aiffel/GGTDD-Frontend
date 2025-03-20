import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  final double opacity;
  final double width;
  final double height;

  const CustomDivider({
    this.color = Colors.grey,
    this.opacity = 1.0,
    this.width = double.infinity,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
