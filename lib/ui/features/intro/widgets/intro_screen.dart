import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'AI로 완벽한 GTD 경험',
      'image': 'assets/images/Ellipse_43.jpg',
    },
    {
      'title': '쏟아지는 업무를 스트레스 없이 관리하세요.',
      'image': 'assets/images/Ellipse_45.png',
    },
    {
      'title': '개인 맞춤형 AI가 당신의 할 일을 최적화합니다',
      'image': 'assets/images/Ellipse_44.png',
    },
    {
      'title': '할 일 관리 앱,\n꾸준히 사용하고 계신가요?\n아니면 ...\n또 잊혀진 채 방치되고 있나요?',
      'image': 'assets/images/to-do-list.png',
      'boldText': ['꾸준히 사용하고 계신가요?'],
      'grayText': ['또 잊혀진 채 방치되고 있나요?'],
    },
    {
      'title': '문제는 단순해요.\n\'운동하기\', \'공부하기\' 같은 막연한 일 들을 ...\n시작할 동기를 잃게 되죠.',
      'image': 'assets/images/man.png',
      'boldText': ['단순해요'],
      'grayText': ['운동하기', '공부하기'],
    },
    {
      'title':
          '하지만 이렇게 바꿔보세요,\n\'오후 7시, 공원에서 30분간 가볍게 뛰기.\'\n갑자기 할 수 있을 것 같지 않나요?',
      'image': 'assets/images/details_1.png',
      'boldText': ['오후 7시, 공원에서 30분간 가볍게 뛰기.'],
      'redText': ['오후 7시, 공원에서 30분간 가볍게 뛰기.'],
    },
    {
      'title':
          'GGTDD는 그걸 대신해줍니다.\n\'공부하기\'를 이렇게\n1. 교재 10쪽 읽기,\n2. 노트 정리하기,\n3. 퀴즈 풀기,\n로 바꿔요.',
      'image': 'assets/images/critical-thinking_1.png',
      'boldText': [
        'GGTDD는 그걸 대신해줍니다.',
        '1. 교재 10쪽 읽기,',
        '2. 노트 정리하기,',
        '3. 퀴즈 풀기,'
      ],
      'grayText': ['공부하기'],
      'redText': ['1. 교재 10쪽 읽기,', '2. 노트 정리하기,', '3. 퀴즈 풀기,'],
    },
    {
      'title': '먼저, 머릿속을 비워요.\n떠오르는 모든 할 일, 아이디어, 걱정 ...\n전부 모아놓습니다.',
      'image': 'assets/images/inbox_1.png',
      'boldText': ['먼저, 머릿속을 비워요.', '전부 모아놓습니다.'],
      'grayText': ['떠오르는 모든 할 일, 아이디어, 걱정 ...'],
    },
    {
      'title': '그 다음, AI가 정리해줍니다.\n복잡한 할 일이 명확한 단계로 바꾸고,\n무엇부터 할지 알려줘요.',
      'image': 'assets/images/communication-skills_1.png',
      'boldText': ['그 다음, AI가 정리해줍니다.'],
      'grayText': ['복잡한 할 일이'],
      'redText': ['명확한 단계'],
    },
    {
      'title': '이 과정을 반복해보세요.\n할 일은 줄어들고, 머릿속은 맑아지고,\n미뤄왔던 일들이 하나씩 끝나갑니다.',
      'image': 'assets/images/loop_1.png',
      'boldText': ['이 과정을 반복해보세요.'],
    },
    {
      'title': '이제, 저희와 함께 시작해볼까요?\n당신의 할 일, 당신의 삶을\n바꿀 준비가 되셨나요?',
      'image': 'assets/images/improve_1.png',
      'boldText': ['이제, 저희와 함께 시작해볼까요?', '당신의 할 일, 당신의 삶을', '바꿀 준비가 되셨나요?'],
      'redText': ['바꿀 준비'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  Widget _buildText(String text, List<String>? boldText, List<String>? grayText,
      List<String>? redText) {
    if (boldText == null && grayText == null && redText == null) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
        ),
        textAlign: TextAlign.center,
      );
    }

    List<TextSpan> textSpans = [];
    List<String> lines = text.split('\n');

    for (String line in lines) {
      bool isRed = redText?.any((red) => line.contains(red)) ?? false;
      bool isGray = grayText?.any((gray) => line.contains(gray)) ?? false;
      bool isBold = boldText?.any((bold) => line.contains(bold)) ?? false;

      if (isRed) {
        textSpans.add(TextSpan(
          text: line + '\n',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            color: Colors.red,
          ),
        ));
      } else if (isGray) {
        textSpans.add(TextSpan(
          text: line + '\n',
          style: TextStyle(
            fontSize: 23,
            color: Colors.grey[600],
          ),
        ));
      } else if (isBold) {
        textSpans.add(TextSpan(
          text: line + '\n',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ));
      } else {
        textSpans.add(TextSpan(
          text: line + '\n',
          style: const TextStyle(
            fontSize: 23,
          ),
        ));
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: textSpans,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_currentPage < 3) ...[
              const SizedBox(height: 2),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _currentPage < 3 ? 1.0 : 0.0,
                child: Image.asset(
                  'assets/images/ggtdd.png',
                  width: 300,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 2),
            ],
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildText(
                          _pages[index]['title'],
                          _pages[index]['boldText'],
                          _pages[index]['grayText'],
                          _pages[index]['redText'],
                        ),
                        SizedBox(height: index == 6 ? 40 : 80),
                        Image.asset(
                          _pages[index]['image'],
                          width: index >= 3 ? 250 : 280,
                          height: index >= 3 ? 250 : 280,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/welcome');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '시작하기',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
