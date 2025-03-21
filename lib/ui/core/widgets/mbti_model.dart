import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_tag_box.dart';

class MbtiModal extends StatefulWidget {
  final String? initialMbti;
  final Function(String) onSelected;

  const MbtiModal({
    super.key,
    this.initialMbti,
    required this.onSelected,
  });

  @override
  _MbtiModalState createState() => _MbtiModalState();
}

class _MbtiModalState extends State<MbtiModal> {
  String? _energy;
  String? _information;
  String? _decision;
  String? _organization;

  @override
  void initState() {
    super.initState();
    if (widget.initialMbti != null && widget.initialMbti!.length == 4) {
      _energy = widget.initialMbti![0];
      _information = widget.initialMbti![1];
      _decision = widget.initialMbti![2];
      _organization = widget.initialMbti![3];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'MBTI 선택',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(24),
            _buildDimensionRow(
              '에너지 충전 방식',
              ['E: 외향적', 'I: 내향적'],
              _energy,
              (value) => setState(() => _energy = value),
            ),
            const Gap(12),
            _buildDimensionRow(
              '정보 처리 방식',
              ['S: 감각적', 'N: 직관적'],
              _information,
              (value) => setState(() => _information = value),
            ),
            const Gap(12),
            _buildDimensionRow(
              '의사결정 방식',
              ['T: 사고형', 'F: 감정형'],
              _decision,
              (value) => setState(() => _decision = value),
            ),
            const Gap(12),
            _buildDimensionRow(
              '생활 조직 방식',
              ['J: 판단형', 'P: 인식형'],
              _organization,
              (value) => setState(() => _organization = value),
            ),
            const Gap(4),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Text('각 버튼을 1초 정도 누르고 있으면 간단한 설명을 보실 수 있어요.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 201, 201, 201))),
            ),
            const Gap(12),
            Center(
              child: CustomButton(
                text: '입력하기',
                onPressed: () {
                  if (_energy != null &&
                      _information != null &&
                      _decision != null &&
                      _organization != null) {
                    final mbti =
                        _energy! + _information! + _decision! + _organization!;
                    widget.onSelected(mbti);
                    Get.back();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 차원을 선택해주세요.')),
                    );
                  }
                },
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }

  Widget _buildDimensionRow(
    String title,
    List<String> options,
    String? selected,
    Function(String) onSelect,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        const Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: options.map((option) {
            final value = option[0];
            final isSelected = selected == value;
            return CustomTagBox(
              width: 130,
              height: 50,
              text: option,
              backgroundColor: isSelected
                  ? Theme.of(context).primaryColor
                  : const Color(0xFFDBDBDB),
              textColor: isSelected ? Colors.white : Colors.black,
              border: null,
              onTap: () => onSelect(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
