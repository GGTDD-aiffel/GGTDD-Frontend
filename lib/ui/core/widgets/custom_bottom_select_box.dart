import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSelectBox extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String> onSelected;

  const CustomBottomSelectBox({
    super.key,
    required this.options,
    this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          final isSelected = option == selectedOption;
          return ListTile(
            title: Text(
              option,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.black,
              ),
            ),
            onTap: () {
              onSelected(option);
              Get.back();
            },
          );
        }).toList(),
      ),
    );
  }
}
