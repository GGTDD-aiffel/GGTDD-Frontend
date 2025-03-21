import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:gap/gap.dart';

class ContextRolesScreen extends StatelessWidget {
  final String userId;

  const ContextRolesScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('9가지 맥락')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '9가지 맥락',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var role in [
                    '기상 및 준비',
                    '출퇴근길',
                    '목적 이동',
                    '업무',
                    '식사',
                    '개인활동',
                    '휴식',
                    '가족/사회 시간',
                    '취침 전'
                  ])
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(role),
                    ),
                ],
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('저장됨', '맥락이 저장되었습니다');
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
