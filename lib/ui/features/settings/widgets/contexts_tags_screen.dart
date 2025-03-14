import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/bottom_nav_bar.dart';

class ContextTagsScreen extends StatelessWidget {
  final String userId;

  const ContextTagsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('맥락 설정')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '맥락 설정',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('9가지 맥락'),
                onTap: () =>
                    Get.toNamed('/settings/$userId/context_tags/context'),
              ),
              ListTile(
                title: const Text('시간, 공간, 기타 태그'),
                onTap: () => Get.toNamed('/settings/$userId/context_tags/tags'),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('저장됨', '맥락 설정이 저장되었습니다');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('저장하기', style: TextStyle(fontSize: 18)),
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
