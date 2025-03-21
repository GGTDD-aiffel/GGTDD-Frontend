import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/routing/app_routes.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_icon_text_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_simple_app_bar.dart';

class ContextTagsScreen extends StatefulWidget {
  final String userId;

  const ContextTagsScreen({super.key, required this.userId});

  @override
  _ContextTagScreenState createState() => _ContextTagScreenState();
}

class _ContextTagScreenState extends State<ContextTagsScreen> {
  int contextCount = 0;
  List<String> commonTags = [];

  @override
  void initState() {
    super.initState();
    contextCount = 9;
    commonTags = ['시간', '공간', '기타'];
  }

  Widget buildContextText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$contextCount',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14.0,
            ),
          ),
          const TextSpan(
            text: '가지 맥락',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTagsText() {
    List<TextSpan> spans = [];
    for (int i = 0; i < commonTags.length; i++) {
      spans.add(TextSpan(
        text: commonTags[i],
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14.0,
        ),
      ));
      if (i < commonTags.length - 1) {
        spans.add(const TextSpan(
          text: ', ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ));
      }
    }
    spans.add(const TextSpan(
      text: ' 태그',
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
      ),
    ));

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(title: '맥락 설정'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '개인화 맥락',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF999999),
                ),
              ),
              const Gap(6),
              CustomCard(
                backgroundColor: const Color(0xFFFFFFFF),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: CustomIconTextButton(
                  textWidget: buildContextText(),
                  fontSize: 14.0,
                  padding: EdgeInsets.zero,
                  rightIcon: Icons.arrow_forward_ios,
                  rightIconColor: const Color(0x999999).withOpacity(0.6),
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.settingsContextRoles
                          .replaceFirst(':user_id', widget.userId),
                    );
                  },
                ),
              ),
              const Gap(12),
              const Text(
                '공통 태그',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF999999),
                ),
              ),
              const Gap(6),
              CustomCard(
                backgroundColor: const Color(0xFFFFFFFF),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: CustomIconTextButton(
                  textWidget: buildTagsText(),
                  fontSize: 14.0,
                  padding: EdgeInsets.zero,
                  rightIcon: Icons.arrow_forward_ios,
                  rightIconColor: const Color(0x999999).withOpacity(0.6),
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.settingsCustomTags
                          .replaceFirst(':user_id', widget.userId),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
    );
  }
}
