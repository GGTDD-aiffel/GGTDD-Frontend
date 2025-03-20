import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  final String userId;

  const SettingsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    print('SettingsScreen userId: $userId');

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '개인화',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('유저 정보'),
                onTap: () => Get.toNamed('/settings/$userId/user_info'),
              ),
              ListTile(
                leading: const Icon(Icons.tag),
                title: const Text('맥락'),
                onTap: () => Get.toNamed('/settings/$userId/context_tags'),
              ),
              const Divider(),
              const Text(
                '기능',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: const Icon(Icons.settings_applications),
                title: const Text('일반'),
                onTap: () => Get.toNamed('/settings/$userId/app_features'),
              ),
              ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('타이머'),
                onTap: () => Get.toNamed('/settings/$userId/timer'),
              ),
              const Spacer(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('탈퇴', '탈퇴 기능은 아직 구현되지 않았습니다.');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    '탈퇴하기',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('로그아웃', '로그아웃 기능은 아직 구현되지 않았습니다.');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
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
