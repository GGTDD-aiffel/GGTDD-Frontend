import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Map<String, dynamic>> actionSteps = [
    {
      'id': '1',
      'title': '프레젠테이션 슬라이드 완성하기',
      'tags': {'맥락': '업무', '시간': '오전', '공간': '사무실', '기타': '중요'},
    },
    {
      'id': '2',
      'title': '팀 이메일 업데이트 보내기',
      'tags': {'맥락': '업무', '시간': '오후', '공간': '집', '기타': '긴급'},
    },
    {
      'id': '3',
      'title': '다음 스프린트 계획 세우기',
      'tags': {'맥락': '업무', '시간': '저녁', '공간': '카페', '기타': '아이디어'},
    },
    {
      'id': '4',
      'title': '아침 명상 10분 하기',
      'tags': {'맥락': '기상 및 준비', '시간': '오전', '공간': '집', '기타': ''},
    },
    {
      'id': '5',
      'title': '출근길에 팟캐스트 듣기',
      'tags': {'맥락': '출퇴근길', '시간': '오전', '공간': '지하철', '기타': ''},
    },
    {
      'id': '6',
      'title': '친구 만나러 카페 가기',
      'tags': {'맥락': '목적 이동', '시간': '오후', '공간': '카페', '기타': ''},
    },
    {
      'id': '7',
      'title': '점심으로 샐러드 먹기',
      'tags': {'맥락': '식사', '시간': '점심', '공간': '식당', '기타': ''},
    },
    {
      'id': '8',
      'title': '30분 조깅하기',
      'tags': {'맥락': '개인 활동', '시간': '저녁', '공간': '공원', '기타': ''},
    },
    {
      'id': '9',
      'title': '책 20페이지 읽기',
      'tags': {'맥락': '휴식', '시간': '밤', '공간': '집', '기타': ''},
    },
    {
      'id': '10',
      'title': '가족과 저녁 식사 준비하기',
      'tags': {'맥락': '가족/사회 시간', '시간': '저녁', '공간': '집', '기타': ''},
    },
  ];

  void _showContextSelection(BuildContext context) {
    String? selectedContext;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('어떤 맥락의 액션을 추천받으시겠습니까?'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var context in [
                    '기상 및 준비',
                    '출퇴근길',
                    '목적 이동',
                    '업무',
                    '식사',
                    '개인 활동',
                    '휴식',
                    '가족/사회 시간',
                    '취침 전',
                  ])
                    ListTile(
                      title: Text(context),
                      onTap: () {
                        setState(() {
                          selectedContext = context;
                        });
                      },
                      tileColor:
                          selectedContext == context ? Colors.grey[200] : null,
                    ),
                ],
              ),
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
              if (selectedContext != null) {
                Navigator.pop(context);
                // 선택된 맥락에 따라 추천 액션 찾기 (여기서는 단순히 첫 번째 일치하는 액션 선택)
                final recommendedAction = actionSteps.firstWhere(
                  (action) => action['tags']['맥락'] == selectedContext,
                  orElse: () => actionSteps.first, // 없으면 첫 번째 액션 추천
                );
                Get.toNamed('/actions/${recommendedAction['id']}');
              } else {
                Get.snackbar('오류', '맥락을 선택해주세요');
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
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: actionSteps.length,
                  itemBuilder: (context, index) {
                    final action = actionSteps[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              action['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                if (action['tags']['맥락'] != '')
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(action['tags']['맥락']),
                                  ),
                                if (action['tags']['시간'] != '')
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(action['tags']['시간']),
                                  ),
                                if (action['tags']['공간'] != '')
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(action['tags']['공간']),
                                  ),
                                if (action['tags']['기타'] != '')
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(action['tags']['기타']),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => _showContextSelection(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '지금 실행할 액션 추천받기',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
