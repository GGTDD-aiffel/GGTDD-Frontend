import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/ui/core/theme/app_colors.dart';

class SettingsContainer extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget bottomNavigationBar;

  const SettingsContainer(
      {super.key,
      required this.child,
      this.appBar,
      required this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
                bottom: 24,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
