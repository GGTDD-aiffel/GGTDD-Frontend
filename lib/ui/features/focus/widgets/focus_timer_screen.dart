import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/bottom_nav_bar.dart';

class FocusTimerScreen extends StatefulWidget {
  final String id;

  const FocusTimerScreen({super.key, required this.id});

  @override
  State<FocusTimerScreen> createState() => _FocusTimerScreenState();
}

class _FocusTimerScreenState extends State<FocusTimerScreen> {
  late Timer _timer;
  int _secondsRemaining = 0;
  bool _isFocused = true;
  String _status = '집중 시간';
  late int _focusDuration;
  late int _breakDuration;

  final Map<String, List<String>> actionContext = {
    '1': ['개발자', '오전', '사무실', '중요'],
    '2': ['매니저', '오후', '집', '긴급'],
    '3': ['연구자', '저녁', '카페', '아이디어'],
  };

  @override
  void initState() {
    super.initState();
    final args =
        Get.arguments as Map<String, dynamic>? ?? {'focus': 25, 'break': 0};
    _focusDuration = (args['focus'] ?? 25) * 60;
    _breakDuration = (args['break'] ?? 0) * 60;
    _secondsRemaining = _focusDuration;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isFocused = !_isFocused;
          _secondsRemaining = _isFocused ? _focusDuration : _breakDuration;
          _status = _isFocused ? '집중 시간' : '휴식 시간';
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final List<String> context = actionContext[widget.id] ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('집중')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: _secondsRemaining /
                          (_isFocused ? _focusDuration : _breakDuration),
                      strokeWidth: 10,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        _status,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatTime(_secondsRemaining),
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                '액션스텝: ${actionDetails[widget.id] ?? 'No details'}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: context.map((tag) => Chip(label: Text(tag))).toList(),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _timer.cancel();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('종료', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  final Map<String, String> actionDetails = {
    '1': 'Finish presentation by preparing slides and notes.',
    '2': 'Send email to team about project updates.',
    '3': 'Plan next sprint with tasks and deadlines.',
  };
}
