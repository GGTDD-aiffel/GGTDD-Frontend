import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/theme/app_colors.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_divider.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_simple_app_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/floating_add_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/simple_text_widget_row.dart';
import 'package:ggtdd_frontend/ui/features/settings/core/settings_container.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/time_picker_widget.dart';

class TimerSettingsScreen extends StatelessWidget {
  final String userId;

  const TimerSettingsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = 400.0;
    final dividerWidth = screenWidth * 0.9;

    return SettingsContainer(
      appBar: const CustomSimpleAppBar(
        title: '타이머 설정',
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
                    '기본',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF999999),
                    ),
                  ),
                ),
                const Gap(8),
                CustomCard(
                    backgroundColor: const Color(0xFFFFFFFF),
                    width: double.infinity,
                    maxWidth: maxWidth,
                    padding: const EdgeInsets.all(2),
                    child: SimpleTextWidgetRow(
                        text: '집중시간',
                        rightWidget: TimePickerWidget(
                          hours: 1,
                          minutes: 0,
                          seconds: 0,
                        ))),
                const Gap(8),
                const Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Text(
                    '뽀모도로1',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF999999),
                    ),
                  ),
                ),
                const Gap(8),
                CustomCard(
                    backgroundColor: const Color(0xFFFFFFFF),
                    width: double.infinity,
                    maxWidth: maxWidth,
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        SimpleTextWidgetRow(
                            text: '집중시간',
                            rightWidget: TimePickerWidget(
                              hours: 0,
                              minutes: 25,
                              seconds: 0,
                            )),
                        const Gap(4),
                        CustomDivider(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          widthPercentage: 0.95,
                        ),
                        const Gap(4),
                        SimpleTextWidgetRow(
                            text: '휴식시간',
                            rightWidget: TimePickerWidget(
                              hours: 0,
                              minutes: 5,
                              seconds: 0,
                            )),
                      ],
                    )),
                const Gap(8),
                const Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Text(
                    '뽀모도로2',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF999999),
                    ),
                  ),
                ),
                const Gap(8),
                CustomCard(
                    backgroundColor: const Color(0xFFFFFFFF),
                    width: double.infinity,
                    maxWidth: maxWidth,
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        SimpleTextWidgetRow(
                            text: '집중시간',
                            rightWidget: TimePickerWidget(
                              hours: 0,
                              minutes: 45,
                              seconds: 0,
                            )),
                        const Gap(4),
                        CustomDivider(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          widthPercentage: 0.95,
                        ),
                        const Gap(4),
                        SimpleTextWidgetRow(
                            text: '휴식시간',
                            rightWidget: TimePickerWidget(
                              hours: 0,
                              minutes: 15,
                              seconds: 0,
                            )),
                      ],
                    )),
                const Gap(8),
                const Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Text(
                    '뽀모도로3',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF999999),
                    ),
                  ),
                ),
                const Gap(8),
                CustomCard(
                    backgroundColor: const Color(0xFFFFFFFF),
                    width: double.infinity,
                    maxWidth: maxWidth,
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        SimpleTextWidgetRow(
                            text: '집중시간',
                            rightWidget: TimePickerWidget(
                              hours: 1,
                              minutes: 45,
                              seconds: 0,
                            )),
                        const Gap(4),
                        CustomDivider(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          widthPercentage: 0.95,
                        ),
                        const Gap(4),
                        SimpleTextWidgetRow(
                            text: '휴식시간',
                            rightWidget: TimePickerWidget(
                              hours: 0,
                              minutes: 15,
                              seconds: 0,
                            )),
                      ],
                    )),
                const Gap(24),
                SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingAddButton(
                            onPressed: () {
                              print('추가 버튼 클릭됨!');
                            },
                          ),
                        ),
                      ],
                    )),
                const Gap(36),
                Center(
                  child: CustomButton(
                    onPressed: () {
                      Get.snackbar('저장됨', '타이머 설정이 저장되었습니다');
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
          )),
        ],
      ),
    );
  }
}
