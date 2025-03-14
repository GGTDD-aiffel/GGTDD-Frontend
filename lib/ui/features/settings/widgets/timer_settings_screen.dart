import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/bottom_nav_bar.dart';

class TimerSettingsScreen extends StatelessWidget {
  final String userId;

  const TimerSettingsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('타이머 설정')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '기본',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('집중 시간'),
                trailing: const Text('25분'),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const Text(
                '뽀모도로 1',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('집중 시간'),
                trailing: const Text('25분'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('휴식 시간'),
                trailing: const Text('5분'),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const Text(
                '뽀모도로 2',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('집중 시간'),
                trailing: const Text('50분'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('휴식 시간'),
                trailing: const Text('10분'),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const Text(
                '뽀모도로 3',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('집중 시간'),
                trailing: const Text('90분'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('휴식 시간'),
                trailing: const Text('15분'),
                onTap: () {},
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('저장됨', '타이머 설정이 저장되었습니다');
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
