import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:gap/gap.dart';

class AppFeaturesScreen extends StatelessWidget {
  final String userId;

  const AppFeaturesScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일반 설정')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '페이지',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('인트로 페이지'),
                value: true,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('랜딩 페이지'),
                value: true,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('집중 페이지'),
                value: true,
                onChanged: (value) {},
              ),
              const Gap(20),
              const Text(
                '기능',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('테마'),
                trailing: const Text('라이트'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('언어'),
                trailing: const Text('한국어'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('글꼴'),
                trailing: const Text('기본'),
                onTap: () {},
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('저장됨', '일반 설정이 저장되었습니다');
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
