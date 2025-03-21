import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomModalContainer extends StatelessWidget {
  final Widget? title;
  final Widget? body;
  final Widget? bottom;

  const CustomModalContainer({
    super.key,
    this.title,
    this.body,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.9,
        maxWidth: 400,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null) ...[
            title!,
            const Gap(16),
          ],
          if (body != null) ...[
            body!,
            const Gap(16),
          ],
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}
