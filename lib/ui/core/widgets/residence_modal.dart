import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';

class ResidenceModal extends StatefulWidget {
  final String? initialResidence;
  final Function(String) onSelected;

  const ResidenceModal({
    super.key,
    this.initialResidence,
    required this.onSelected,
  });

  @override
  _ResidenceModalState createState() => _ResidenceModalState();
}

class _ResidenceModalState extends State<ResidenceModal> {
  String? _selectedResidence;
  final List<String> _residenceList = [
    '서울',
    '경기',
    '강원',
    '충청',
    '전라',
    '경상',
    '부산',
    '제주',
    '해외'
  ];

  @override
  void initState() {
    super.initState();
    _selectedResidence = widget.initialResidence;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '거주지 선택',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(24),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0,
              ),
              itemCount: _residenceList.length,
              itemBuilder: (context, index) {
                final residence = _residenceList[index];
                final isSelected = _selectedResidence == residence;
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedResidence = residence;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    residence,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
            const Gap(24),
            CustomButton(
              onPressed: () {
                widget.onSelected(_selectedResidence ?? '');
                Get.back();
              },
              text: '입력하기',
              fontWeight: FontWeight.bold,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
