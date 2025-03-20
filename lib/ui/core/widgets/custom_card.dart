import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderRadius;
  final Color shadowColor;
  final double width;
  final double height;

  const CustomCard({
    required this.child,
    this.borderColor = Colors.grey,
    this.borderRadius = 10.0,
    this.shadowColor = Colors.black26,
    this.width = 300.0,
    this.height = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
