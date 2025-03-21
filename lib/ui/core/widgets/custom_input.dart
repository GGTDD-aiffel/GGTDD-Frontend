import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String placeholder;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomInput({
    this.placeholder = '',
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderRadius = 4.0,
    this.width = 300.0,
    this.height = 50.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
