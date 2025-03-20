import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/routing/app_routes.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_divider.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_icon_text_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_simple_app_bar.dart';
import 'package:ggtdd_frontend/ui/features/settings/core/settings_container.dart';

class SettingsScreen extends StatelessWidget {
  final String userId;

  const SettingsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = 400.0;
    final buttonWidth = screenWidth > maxWidth ? maxWidth : screenWidth * 0.9;
    final cardWidth = screenWidth > maxWidth ? maxWidth : screenWidth;

    return SettingsContainer(
      appBar: const CustomSimpleAppBar(
        title: '설정',
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: const Text(
                      '개인화',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomCard(
                    backgroundColor: const Color(0xFFFFFFFF),
                    width: double.infinity,
                    maxWidth: maxWidth,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconTextButton(
                          leftIcon: Icons.person,
                          text: '유저 정보',
                          rightIcon: Icons.arrow_forward_ios,
                          padding: const EdgeInsets.all(12),
                          leftIconColor: const Color(0xFFFF0000),
                          rightIconSize: 20.0,
                          rightIconColor:
                              const Color(0xFF999999).withOpacity(0.6),
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.settingsUserInfo
                                  .replaceFirst(':user_id', userId),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        CustomDivider(
                          alignment: Alignment.centerRight,
                          width: cardWidth * 0.85,
                        ),
                        const SizedBox(height: 8),
                        CustomIconTextButton(
                          leftIcon: Icons.account_tree,
                          text: '맥락',
                          rightIcon: Icons.arrow_forward_ios,
                          padding: const EdgeInsets.all(12),
                          leftIconColor: const Color(0xFFFF0000),
                          rightIconSize: 20.0,
                          rightIconColor:
                              const Color(0xFF999999).withOpacity(0.6),
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.settingsContextTags
                                  .replaceFirst(':user_id', userId),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: const Text(
                      '기능',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomCard(
                    backgroundColor: const Color(0xFFFFFFFF),
                    width: double.infinity,
                    maxWidth: maxWidth,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconTextButton(
                          leftIcon: Icons.settings,
                          text: '일반',
                          rightIcon: Icons.arrow_forward_ios,
                          padding: const EdgeInsets.all(12),
                          leftIconColor: const Color(0xFFFF0000),
                          rightIconSize: 20.0,
                          rightIconColor:
                              const Color(0xFF999999).withOpacity(0.6),
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.settingsAppFeatures
                                  .replaceFirst(':user_id', userId),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        CustomDivider(
                          alignment: Alignment.centerRight,
                          width: cardWidth * 0.85,
                        ),
                        const SizedBox(height: 8),
                        CustomIconTextButton(
                          leftIcon: Icons.timer,
                          text: '타이머',
                          rightIcon: Icons.arrow_forward_ios,
                          padding: const EdgeInsets.all(12),
                          leftIconColor: const Color(0xFFFF0000),
                          rightIconSize: 20.0,
                          rightIconColor:
                              const Color(0xFF999999).withOpacity(0.6),
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.settingsTimer
                                  .replaceFirst(':user_id', userId),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  text: '탈퇴하기',
                  width: buttonWidth,
                  height: 48,
                  borderRadius: 10,
                  backgroundColor: const Color(0xFFFFFFFF),
                  textColor: const Color(0xFFFF0000),
                  fontWeight: FontWeight.bold,
                  onPressed: () {
                    // TODO: 탈퇴하기 로직 구현
                  },
                ),
                const SizedBox(height: 18),
                CustomButton(
                  text: '로그아웃',
                  width: buttonWidth,
                  height: 48,
                  borderRadius: 10,
                  backgroundColor: const Color(0xFFFFFFFF),
                  textColor: const Color(0xFFFF0000),
                  fontWeight: FontWeight.bold,
                  onPressed: () {
                    // TODO: 로그아웃 로직 구현
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
