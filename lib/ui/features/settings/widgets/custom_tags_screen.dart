import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/theme/app_colors.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_style_tag_box.dart';
import 'package:ggtdd_frontend/ui/features/settings/core/default_tags.dart';

class CustomTagsScreen extends StatelessWidget {
  final String userId;

  const CustomTagsScreen({super.key, required this.userId});

  Map<String, Map<String, List<Map<String, dynamic>>>> _groupTags() {
    final groupedTags = <String, Map<String, List<Map<String, dynamic>>>>{};

    for (var tag in DefaultTags.defaultTags) {
      final type = tag['type'] as String;
      final category = tag['category'] as String;

      if (!groupedTags.containsKey(type)) {
        groupedTags[type] = {};
      }
      if (!groupedTags[type]!.containsKey(category)) {
        groupedTags[type]![category] = [];
      }
      groupedTags[type]![category]!.add(tag);
    }

    return groupedTags;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTags = _groupTags();

    return Scaffold(
      appBar: AppBar(title: const Text('시간, 공간, 기타 태그')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: groupedTags.entries.map((typeEntry) {
                      final type = typeEntry.key;
                      final categories = typeEntry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type == 'time'
                                ? '시간 태그'
                                : type == 'space'
                                    ? '공간 태그'
                                    : '기타 태그',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(10),
                          ...categories.entries.map((categoryEntry) {
                            final category = categoryEntry.key;
                            final tags = categoryEntry.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category == 'time_unit'
                                      ? '시간 단위'
                                      : category == 'meal_unit'
                                          ? '식사 단위'
                                          : category == 'week_unit'
                                              ? '일주일 단위'
                                              : category == 'day_night_unit'
                                                  ? '주야 단위'
                                                  : category == 'commute_unit'
                                                      ? '출근 단위'
                                                      : category == 'place'
                                                          ? '장소'
                                                          : category ==
                                                                  'vehicle'
                                                              ? '이동 수단'
                                                              : category ==
                                                                      'basic'
                                                                  ? '기본'
                                                                  : category,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(8),
                                CustomCard(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.all(8),
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: tags.map((tag) {
                                      return CustomStyleTagBox(
                                        height: 40,
                                        text: tag['tag_name'] as String,
                                        type: type,
                                        category: category,
                                        textSize: 12,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const Gap(20),
                              ],
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              Center(
                child: CustomButton(
                  onPressed: () {
                    Get.snackbar('저장됨', '태그가 저장되었습니다');
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
