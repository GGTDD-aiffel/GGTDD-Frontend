import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_icon_text_button.dart';
import 'package:ggtdd_frontend/ui/domain/models/occupation_model.dart';

class OccupationModal extends StatefulWidget {
  final String? initialOccupationId;
  final List<Occupation> occupations;
  final Function(String, String) onSelected;

  const OccupationModal({
    super.key,
    this.initialOccupationId,
    required this.occupations,
    required this.onSelected,
  });

  @override
  _OccupationModalState createState() => _OccupationModalState();
}

class _OccupationModalState extends State<OccupationModal> {
  String? _selectedOccupationId;
  String? _selectedOccupationName;

  @override
  void initState() {
    super.initState();
    _selectedOccupationId = widget.initialOccupationId;
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
              '직업 선택',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(24),
            ListView.separated(
              shrinkWrap: true,
              itemCount: widget.occupations.length,
              separatorBuilder: (context, index) => const Gap(8),
              itemBuilder: (context, index) {
                final occupation = widget.occupations[index];
                final isSelected =
                    _selectedOccupationId == occupation.occupationId;
                return CustomIconTextButton(
                  text: occupation.occupationName,
                  fontWeight: FontWeight.bold,
                  textColor: Color(0xFF999999),
                  rightIcon: isSelected ? Icons.check : null,
                  rightIconColor: Color(0xFF4169E1),
                  onPressed: () {
                    setState(() {
                      _selectedOccupationId = occupation.occupationId;
                      _selectedOccupationName = occupation.occupationName;
                    });
                  },
                );
              },
            ),
            const Gap(24),
            CustomButton(
                onPressed: () {
                  if (_selectedOccupationId != null) {
                    widget.onSelected(
                        _selectedOccupationId!, _selectedOccupationName!);
                    Get.back();
                  }
                },
                width: double.infinity,
                text: '입력하기'),
          ],
        ),
      ),
    );
  }
}
