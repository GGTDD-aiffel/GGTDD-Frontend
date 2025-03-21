import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  final double? opacity;
  final double width;
  final double? widthPercentage;
  final double height;
  final Alignment alignment;

  const CustomDivider({
    super.key,
    this.color = const Color.fromARGB(141, 158, 158, 158),
    this.opacity = 0.3,
    required this.width,
    this.widthPercentage = 0.9,
    this.height = 1.0,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? Theme.of(context).dividerColor;
    final finalColor =
        opacity != null ? dividerColor.withOpacity(opacity!) : dividerColor;

    final cardWrapper = CustomCardChildWrapper.of(context);
    final parentWidth =
        cardWrapper?.actualWidth ?? MediaQuery.of(context).size.width;

    final baseWidth = parentWidth * (widthPercentage ?? 0.9);

    final effectiveWidth = width.clamp(0, baseWidth).toDouble();

    return Align(
      alignment: alignment,
      child: Container(
        width: effectiveWidth,
        height: height,
        color: finalColor,
      ),
    );
  }
}
