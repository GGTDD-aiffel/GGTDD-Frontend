import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _name;
  String? _location;
  String? _birthday;
  String? _occupation;
  String? _mbti;
  final TextEditingController _nameController = TextEditingController();
  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;
  int? _selectedOccupationIndex;
  String? _selectedMbti;
  Map<String, String> _mbtiSelections = {
    'energy': '',
    'information': '',
    'decision': '',
    'lifestyle': '',
  };

  final List<String> _locations = [
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

  final List<String> _occupations = [
    '회사원',
    '사업자',
    '기타(프리랜서, 아르바이트 등)',
    '무직(주부 등)',
    '학생'
  ];

  final List<String> _mbtiTypes = [
    'ISTJ',
    'ISTP',
    'ESTP',
    'ESTJ',
    'ISFJ',
    'ISFP',
    'ESFP',
    'ESFJ',
    'INFJ',
    'INFP',
    'ENFP',
    'ENFJ',
    'INTJ',
    'INTP',
    'ENTP',
    'ENTJ'
  ];

  final List<int> _years = List.generate(DateTime.now().year - 1920 + 1,
      (index) => DateTime.now().year - index); // 1920년부터 현재까지 (내림차순)
  final List<int> _months = List.generate(12, (index) => index + 1);
  final List<int> _days = List.generate(31, (index) => index + 1);

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Image.asset(
                    'assets/images/ggtdd.png',
                    width: 115,
                    height: 55,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: Text(
                  _getHeaderText(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_name != null &&
                        _location != null &&
                        _birthday != null &&
                        _occupation != null) ...[
                      const Text(
                        'MBTI',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _showMBTIDialog(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color:
                                _mbti != null ? Colors.grey[100] : Colors.white,
                          ),
                          child: Text(
                            _mbti ?? 'MBTI를 선택해 주세요',
                            style: TextStyle(
                              color: _mbti != null ? Colors.black : Colors.grey,
                              fontSize: 16,
                            ),
                            textAlign: _mbti != null
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                    if (_name != null &&
                        _location != null &&
                        _birthday != null) ...[
                      const SizedBox(height: 20),
                      const Text(
                        '직업',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _showOccupationDialog(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: _occupation != null
                                ? Colors.grey[100]
                                : Colors.white,
                          ),
                          child: Text(
                            _occupation ?? '직업을 선택해 주세요',
                            style: TextStyle(
                              color: _occupation != null
                                  ? Colors.black
                                  : Colors.grey,
                              fontSize: 16,
                            ),
                            textAlign: _occupation != null
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                    if (_name != null && _location != null) ...[
                      const SizedBox(height: 20),
                      const Text(
                        '생년월일',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _showBirthdayDialog(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: _birthday != null
                                ? Colors.grey[100]
                                : Colors.white,
                          ),
                          child: Text(
                            _birthday ?? '생년월일을 선택해 주세요',
                            style: TextStyle(
                              color: _birthday != null
                                  ? Colors.black
                                  : Colors.grey,
                              fontSize: 16,
                            ),
                            textAlign: _birthday != null
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                    if (_name != null) ...[
                      if (_location != null) const SizedBox(height: 20),
                      const Text(
                        '거주지',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _showLocationDialog(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: _location != null
                                ? Colors.grey[100]
                                : Colors.white,
                          ),
                          child: Text(
                            _location ?? '거주지를 선택해 주세요',
                            style: TextStyle(
                              color: _location != null
                                  ? Colors.black
                                  : Colors.grey,
                              fontSize: 16,
                            ),
                            textAlign: _location != null
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                    if (_location != null || _name == null)
                      const SizedBox(height: 20),
                    const Text(
                      '이름',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _showNameDialog(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color:
                              _name != null ? Colors.grey[100] : Colors.white,
                        ),
                        child: Text(
                          _name ?? '이름을 입력해 주세요',
                          style: TextStyle(
                            color: _name != null ? Colors.black : Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign:
                              _name != null ? TextAlign.right : TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getHeaderText() {
    if (_name == null) {
      return '당신의 이름은 무엇인가요?';
    } else if (_location == null) {
      return '$_name님,\n당신의 거주지는 어디인가요?';
    } else if (_birthday == null) {
      return '$_name님,\n당신의 생일은 언제인가요?';
    } else if (_occupation == null) {
      return '$_name님,\n당신의 직업은 무엇인가요?';
    } else {
      return '$_name님,\n당신의 MBTI는 무엇인가요?';
    }
  }

  void _showNameDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => AlertDialog(
        title: const Text(
          '이름',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: '이름을 입력해 주세요',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    setState(() {
                      _name = _nameController.text.trim();
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE3F2FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '입력하기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => AlertDialog(
        title: const Text(
          '지역 선택',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: 300,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
            ),
            itemCount: _locations.length,
            itemBuilder: (context, index) => ElevatedButton(
              onPressed: () {
                setState(() {
                  _location = _locations[index];
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE3F2FD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _locations[index],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBirthdayDialog() {
    // 초기값 설정
    _selectedYear = _years[0]; // 현재 연도로 초기값 설정
    _selectedMonth = _months[0]; // 1월로 초기값 설정
    _selectedDay = _days[0]; // 1일로 초기값 설정

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            '생년월일',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: 0,
                          ),
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedYear = _years[index];
                            });
                          },
                          children: _years
                              .map((year) => Center(
                                    child: Text(
                                      year.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: 0,
                          ),
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMonth = _months[index];
                            });
                          },
                          children: _months
                              .map((month) => Center(
                                    child: Text(
                                      month.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: 0,
                          ),
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedDay = _days[index];
                            });
                          },
                          children: _days
                              .map((day) => Center(
                                    child: Text(
                                      day.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      this.setState(() {
                        _birthday =
                            '${_selectedYear}년 ${_selectedMonth}월 ${_selectedDay}일';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '입력하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOccupationDialog() {
    _selectedOccupationIndex = 0;

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            '직업',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: 0,
                    ),
                    itemExtent: 40,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedOccupationIndex = index;
                      });
                    },
                    children: _occupations
                        .map((occupation) => Center(
                              child: Text(
                                occupation,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      this.setState(() {
                        _occupation = _occupations[_selectedOccupationIndex!];
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '입력하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMBTIDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            'MBTI',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: _mbtiTypes.length,
                  itemBuilder: (context, index) => ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_selectedMbti == _mbtiTypes[index]) {
                          _selectedMbti = null;
                        } else {
                          _selectedMbti = _mbtiTypes[index];
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedMbti == _mbtiTypes[index]
                          ? const Color(0xFF90CAF9)
                          : const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      _mbtiTypes[index],
                      style: TextStyle(
                        color: _selectedMbti == _mbtiTypes[index]
                            ? Colors.white
                            : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showMBTIDetailDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'MBTI 모름',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedMbti != null
                          ? () {
                              this.setState(() {
                                _mbti = _selectedMbti;
                              });
                              Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE3F2FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '입력하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMBTIDetailDialog() {
    _mbtiSelections = {
      'energy': '',
      'information': '',
      'decision': '',
      'lifestyle': '',
    };

    Map<String, String> tooltips = {
      'E': '사람들과 어울리며 활력을 얻어요.',
      'I': '혼자만의 시간을 통해 에너지를 채워요.',
      'S': '구체적인 사실과 현실에 집중해요.',
      'N': '미래의 가능성과 아이디어에 끌려요.',
      'T': '논리와 객관적인 분석을 우선해요.',
      'F': '감정과 타인의 가치를 고려해요.',
      'J': '계획적이고 구조적인 삶을 선호해요.',
      'P': '유연하고 즉흥적인 삶을 즐겨요.',
    };

    OverlayEntry? overlayEntry;
    Timer? tooltipTimer;

    void hideTooltip() {
      if (overlayEntry != null) {
        OverlayEntry currentOverlay = overlayEntry!;
        overlayEntry = null;

        late OverlayEntry fadeOutOverlay;
        fadeOutOverlay = OverlayEntry(
          builder: (context) => TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 0.0),
            duration: const Duration(milliseconds: 200),
            onEnd: () {
              fadeOutOverlay.remove();
              currentOverlay.remove();
            },
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: currentOverlay.builder(context),
            ),
          ),
        );

        Overlay.of(context).insert(fadeOutOverlay);
      }
      tooltipTimer?.cancel();
    }

    void showTooltip(BuildContext context, String text, Offset position) {
      overlayEntry?.remove();

      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: const EdgeInsets.only(top: 120),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '설명',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

      tooltipTimer?.cancel();
      tooltipTimer = Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    }

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '생활 스타일',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildMBTIOption(
                  '에너지 충전 방식',
                  'energy',
                  {'E': '외향적', 'I': '내향적'},
                  setState,
                  tooltips,
                  showTooltip,
                  hideTooltip,
                  context,
                ),
                const SizedBox(height: 12),
                _buildMBTIOption(
                  '정보 처리 방식',
                  'information',
                  {'S': '감각적', 'N': '직관적'},
                  setState,
                  tooltips,
                  showTooltip,
                  hideTooltip,
                  context,
                ),
                const SizedBox(height: 12),
                _buildMBTIOption(
                  '의사결정 방식',
                  'decision',
                  {'T': '사고형', 'F': '감정형'},
                  setState,
                  tooltips,
                  showTooltip,
                  hideTooltip,
                  context,
                ),
                const SizedBox(height: 12),
                _buildMBTIOption(
                  '생활 조직 방식',
                  'lifestyle',
                  {'J': '판단형', 'P': '인식형'},
                  setState,
                  tooltips,
                  showTooltip,
                  hideTooltip,
                  context,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '각 버튼을 1초 정도 누르고 있으면 간단한 설명을 보실 수 있어요.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '해당 방식은 간단하게 생활 스타일을 고려해서 MBTI를 간략하게 유추해\n보는 것이기 때문에 더 정확한 결과를 위해서는 추가적인 MBTI 검사를\n받아보세요!',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _mbtiSelections.values.every((v) => v.isNotEmpty)
                        ? () {
                            this.setState(() {
                              _mbti = _mbtiSelections.values.join('');
                            });
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '입력하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMBTIOption(
    String title,
    String key,
    Map<String, String> options,
    StateSetter setState,
    Map<String, String> tooltips,
    Function(BuildContext, String, Offset) showTooltip,
    Function() hideTooltip,
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ...options.entries.map((entry) {
          return Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onLongPressStart: (details) {
                  showTooltip(context, tooltips[entry.key]!, Offset.zero);
                },
                onLongPressEnd: (_) {
                  hideTooltip();
                },
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_mbtiSelections[key] == entry.key) {
                        _mbtiSelections[key] = '';
                      } else {
                        _mbtiSelections[key] = entry.key;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _mbtiSelections[key] == entry.key
                        ? const Color(0xFF90CAF9)
                        : const Color(0xFFE3F2FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                  child: Text(
                    '${entry.key} : ${entry.value}',
                    style: TextStyle(
                      color: _mbtiSelections[key] == entry.key
                          ? Colors.white
                          : Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
