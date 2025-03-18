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
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 14,
      items: const [
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: ImageIcon(AssetImage('assets/icons/Home 7.png')),
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: ImageIcon(AssetImage('assets/icons/box_open.png')),
          ),
          label: '수집',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: ImageIcon(AssetImage('assets/icons/Notes-lines-alt.png')),
          ),
          label: '구체화',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: ImageIcon(AssetImage('assets/icons/Send.png')),
          ),
          label: '액션',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: ImageIcon(AssetImage('assets/icons/Setting_5.png')),
          ),
          label: '설정',
        ),
      ],
    );
  }
}
