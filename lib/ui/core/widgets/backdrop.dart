import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackDrop extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTap;
  final Widget? child;

  const BackDrop({
    super.key,
    this.color,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap ?? () => Get.back(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: color ?? Colors.black.withOpacity(0.2),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}
