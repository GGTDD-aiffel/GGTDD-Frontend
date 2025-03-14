import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  static const List<String> _routes = [
    '/',
    '/inbox',
    '/recognition',
    '/actions',
    '/settings',
  ];

  void _onItemTapped(int index) {
    Get.toNamed(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: '수집',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '구체화',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: '액션',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
      ],
    );
  }
}
