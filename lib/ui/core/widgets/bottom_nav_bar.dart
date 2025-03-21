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
    return Container(
      height: 90,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFD9D9D9).withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_rounded, '홈', 0),
          _buildNavItem(Icons.inventory, '수집', 1),
          _buildNavItem(Icons.description, '구체화', 2),
          _buildNavItem(Icons.play_arrow, '액션', 3),
          _buildNavItem(Icons.settings, '설정', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected ? const Color(0xFF4169E1) : Colors.black;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
