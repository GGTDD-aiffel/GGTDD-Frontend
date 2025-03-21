import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/theme/app_colors.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_bottom_select_box.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_divider.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_icon_text_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_simple_app_bar.dart';

class AppFeaturesScreen extends StatefulWidget {
  final String userId;

  const AppFeaturesScreen({super.key, required this.userId});

  @override
  _AppFeaturesScreenState createState() => _AppFeaturesScreenState();
}

class _AppFeaturesScreenState extends State<AppFeaturesScreen> {
  Map<String, bool> pageStates = {
    '인트로 페이지': true,
    '랜딩 페이지': true,
    '집중 페이지': true,
  };

  Map<String, String> featureSelections = {
    '테마': '라이트',
    '언어': '한국어',
    '글꼴': '기본',
  };

  String? currentSelectionKey;

  final Map<String, List<String>> featureOptions = {
    '테마': ['라이트', '다크'],
    '언어': ['한국어', '영어', '일본어', '중국어'],
    '글꼴': ['기본', '고딕', '명조', '나눔'],
  };

  void _togglePageState(String page) {
    setState(() {
      pageStates[page] = !pageStates[page]!;
    });
  }

  void _showSelectBox(String key) {
    setState(() {
      currentSelectionKey = key;
    });
    Get.bottomSheet(
      CustomBottomSelectBox(
        options: featureOptions[key]!,
        selectedOption: featureSelections[key],
        onSelected: (value) {
          setState(() {
            featureSelections[key] = value;
            currentSelectionKey = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 400.0 : screenWidth;

    return Scaffold(
      appBar: CustomSimpleAppBar(title: '일반 설정'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Gap(6),
                  const Text(
                    '페이지',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              CustomCard(
                backgroundColor: const Color(0xFFFFFFFF),
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconTextButton(
                      text: '인트로 페이지 ${pageStates['인트로 페이지']! ? 'on' : 'off'}',
                      rightIcon: pageStates['인트로 페이지']!
                          ? Icons.toggle_on
                          : Icons.toggle_off,
                      rightIconColor:
                          pageStates['인트로 페이지']! ? Colors.green : Colors.grey,
                      rightIconSize: 36.0,
                      onPressed: () => _togglePageState('인트로 페이지'),
                    ),
                    const Gap(4),
                    CustomDivider(
                      width: cardWidth * 0.95,
                      color: const Color(0xFF999999).withOpacity(0.3),
                    ),
                    const Gap(4),
                    CustomIconTextButton(
                      text: '랜딩 페이지 ${pageStates['랜딩 페이지']! ? 'on' : 'off'}',
                      rightIcon: pageStates['랜딩 페이지']!
                          ? Icons.toggle_on
                          : Icons.toggle_off,
                      rightIconColor:
                          pageStates['랜딩 페이지']! ? Colors.green : Colors.grey,
                      rightIconSize: 36.0,
                      onPressed: () => _togglePageState('랜딩 페이지'),
                    ),
                    CustomDivider(
                      width: cardWidth * 0.95,
                      color: const Color(0xFF999999).withOpacity(0.3),
                    ),
                    const Gap(4),
                    CustomIconTextButton(
                      text: '집중 페이지 ${pageStates['집중 페이지']! ? 'on' : 'off'}',
                      rightIcon: pageStates['집중 페이지']!
                          ? Icons.toggle_on
                          : Icons.toggle_off,
                      rightIconColor:
                          pageStates['집중 페이지']! ? Colors.green : Colors.grey,
                      rightIconSize: 36.0,
                      onPressed: () => _togglePageState('집중 페이지'),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              Row(
                children: [
                  const Gap(6),
                  const Text(
                    '기능',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              CustomCard(
                backgroundColor: const Color(0xFFFFFFFF),
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconTextButton(
                      text: '테마: ${featureSelections['테마']}',
                      rightIcon: Icons.arrow_forward_ios,
                      rightIconSize: 20.0,
                      rightIconColor: const Color(0xFF999999).withOpacity(0.6),
                      onPressed: () => _showSelectBox('테마'),
                    ),
                    const Gap(8),
                    CustomDivider(
                      width: cardWidth * 0.95,
                      color: const Color(0xFF999999).withOpacity(0.3),
                    ),
                    const Gap(8),
                    CustomIconTextButton(
                      text: '언어: ${featureSelections['언어']}',
                      rightIcon: Icons.arrow_forward_ios,
                      rightIconSize: 20.0,
                      rightIconColor: const Color(0xFF999999).withOpacity(0.6),
                      onPressed: () => _showSelectBox('언어'),
                    ),
                    const Gap(8),
                    CustomDivider(
                      width: cardWidth * 0.95,
                      color: const Color(0xFF999999).withOpacity(0.3),
                    ),
                    const Gap(8),
                    CustomIconTextButton(
                      text: '글꼴: ${featureSelections['글꼴']}',
                      rightIcon: Icons.arrow_forward_ios,
                      rightIconSize: 20.0,
                      rightIconColor: const Color(0xFF999999).withOpacity(0.6),
                      onPressed: () => _showSelectBox('글꼴'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: CustomButton(
                  onPressed: () {
                    Get.snackbar('저장됨', '일반 설정이 저장되었습니다');
                  },
                  text: '저장하기',
                  height: 48,
                  textColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: AppColors.lightPrimary,
                ),
              ),
              const Gap(12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
    );
  }
}
