import 'package:flutter/material.dart';

class CustomSelectBox extends StatelessWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?> onChanged;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final Color fontColor;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomSelectBox({
    required this.items,
    required this.value,
    required this.onChanged,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderRadius = 4.0,
    this.fontColor = Colors.black,
    this.width = 200.0,
    this.height = 50.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          );
        }).toList(),
        isExpanded: true,
        underline: SizedBox(),
      ),
    );
  }
}
