import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/routing/app_routes.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_divider.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_icon_text_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_modal.dart';
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

    void _showRemoveUserModal() {
      Get.dialog(
        CustomModal(
          defaultTitle: '탈퇴하기',
          defaultBodyText: '정말로 탈퇴하시겠습니까?',
          onPressed: () {
            print("탈퇴하기");
          },
        ),
      );
    }

    void _showLogoutModal() {
      Get.dialog(
        CustomModal(
          defaultTitle: '로그아웃',
          defaultBodyText: '정말로 로그아웃하시겠습니까?',
          onPressed: () {
            print("로그아웃");
          },
        ),
      );
    }

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
                  const Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Text(
                      '개인화',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Gap(12),
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
                        const Gap(8),
                        CustomDivider(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          widthPercentage: 0.90,
                        ),
                        const Gap(8),
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
                  const Gap(24),
                  const Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Text(
                      '기능',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Gap(12),
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
                        const Gap(8),
                        CustomDivider(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          widthPercentage: 0.90,
                        ),
                        const Gap(8),
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
                  const Gap(24),
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
                  onPressed: _showRemoveUserModal,
                ),
                const Gap(18),
                CustomButton(
                  text: '로그아웃',
                  width: buttonWidth,
                  height: 48,
                  borderRadius: 10,
                  backgroundColor: const Color(0xFFFFFFFF),
                  textColor: const Color(0xFFFF0000),
                  fontWeight: FontWeight.bold,
                  onPressed: _showLogoutModal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
