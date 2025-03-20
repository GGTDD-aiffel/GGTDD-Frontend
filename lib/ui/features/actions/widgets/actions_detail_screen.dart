import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';

class ActionDetailScreen extends StatelessWidget {
  final String id;

  ActionDetailScreen({super.key, required this.id});

  final Map<String, String> actionDetails = {
    '1': 'Finish presentation by preparing slides and notes.',
    '2': 'Send email to team about project updates.',
    '3': 'Plan next sprint with tasks and deadlines.',
  };

  final Map<String, List<String>> actionContext = {
    '1': ['개발자', '오전', '사무실', '중요'],
    '2': ['매니저', '오후', '집', '긴급'],
    '3': ['연구자', '저녁', '카페', '아이디어'],
  };

  void _showTimerSelection(BuildContext context) {
    print('Showing timer selection modal for id: $id'); // 디버깅 로그
    String? selectedTimerType;
    int? selectedFocus;
    int? selectedBreak;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('타이머 선택'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('기본 (25분)'),
                  onTap: () {
                    setState(() {
                      selectedTimerType = 'basic';
                      selectedFocus = 25;
                      selectedBreak = 0;
                    });
                  },
                  tileColor:
                      selectedTimerType == 'basic' ? Colors.grey[200] : null,
                ),
                ListTile(
                  title: const Text('뽀모도로 1 (25분 / 5분)'),
                  onTap: () {
                    setState(() {
                      selectedTimerType = 'pomodoro1';
                      selectedFocus = 25;
                      selectedBreak = 5;
                    });
                  },
                  tileColor: selectedTimerType == 'pomodoro1'
                      ? Colors.grey[200]
                      : null,
                ),
                ListTile(
                  title: const Text('뽀모도로 2 (50분 / 10분)'),
                  onTap: () {
                    setState(() {
                      selectedTimerType = 'pomodoro2';
                      selectedFocus = 50;
                      selectedBreak = 10;
                    });
                  },
                  tileColor: selectedTimerType == 'pomodoro2'
                      ? Colors.grey[200]
                      : null,
                ),
                ListTile(
                  title: const Text('뽀모도로 3 (90분 / 15분)'),
                  onTap: () {
                    setState(() {
                      selectedTimerType = 'pomodoro3';
                      selectedFocus = 90;
                      selectedBreak = 15;
                    });
                  },
                  tileColor: selectedTimerType == 'pomodoro3'
                      ? Colors.grey[200]
                      : null,
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedTimerType != null) {
                print(
                    'Selected timer: $selectedTimerType, focus: $selectedFocus, break: $selectedBreak');
                Navigator.pop(context);
                Get.toNamed(
                  '/focus/$id/timer',
                  arguments: {
                    'type': selectedTimerType,
                    'focus': selectedFocus,
                    'break': selectedBreak,
                  },
                );
              } else {
                Get.snackbar('오류', '타이머를 선택해주세요');
              }
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String description = actionDetails[id] ?? 'No details available';
    final List<String> tags =
        actionContext[id] ?? []; // 변수명 변경: context -> tags

    return Scaffold(
      appBar: AppBar(title: Text('Action #$id')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Action Details - ID: $id',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('Focus button pressed for id: $id'); // 디버깅 로그
                    _showTimerSelection(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('집중하기', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: tags.map((tag) => Chip(label: Text(tag))).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }
}
