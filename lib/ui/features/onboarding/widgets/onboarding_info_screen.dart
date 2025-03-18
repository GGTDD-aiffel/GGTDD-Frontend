import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingInfoScreen extends StatefulWidget {
  const OnBoardingInfoScreen({super.key});

  @override
  State<OnBoardingInfoScreen> createState() => _OnBoardingInfoScreenState();
}

class _OnBoardingInfoScreenState extends State<OnBoardingInfoScreen> {
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

  final List<int> _years = List.generate(
      DateTime.now().year - 1920 + 1, (index) => DateTime.now().year - index);
  final List<int> _months = List.generate(12, (index) => index + 1);
  final List<int> _days = List.generate(31, (index) => index + 1);

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _getHeaderText() {
    if (_name == null) {
      return '안녕하세요!\n이름을 알려주세요.';
    } else if (_location == null) {
      return '${_name}님,\n어디에 살고 계신가요?';
    } else if (_birthday == null) {
      return '${_name}님은\n언제 태어나셨나요?';
    } else if (_occupation == null) {
      return '${_name}님의\n직업이 궁금해요.';
    } else if (_mbti == null) {
      return '${_name}님의\nMBTI를 알려주세요.';
    } else {
      return '모든 정보를\n입력해주셨네요!';
    }
  }

  void _showNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('이름을 입력해주세요'),
            titlePadding:
                const EdgeInsets.only(top: 15, bottom: 0, left: 20, right: 20),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      setDialogState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: '이름을 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _nameController.text.isNotEmpty
                          ? () {
                              setState(() {
                                _name = _nameController.text;
                              });
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _nameController.text.isNotEmpty
                            ? const Color(0xFF90CAF9)
                            : const Color(0xFFE3F2FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
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
        );
      },
    );
  }

  void _showLocationDialog() {
    String? selectedLocation;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('거주지를 선택해주세요'),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: _locations.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          setDialogState(() {
                            if (selectedLocation == _locations[index]) {
                              selectedLocation = null;
                            } else {
                              selectedLocation = _locations[index];
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedLocation == _locations[index]
                              ? const Color(0xFF90CAF9)
                              : const Color(0xFFE3F2FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          _locations[index],
                          style: TextStyle(
                            color: selectedLocation == _locations[index]
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: selectedLocation != null
                          ? () {
                              setState(() {
                                _location = selectedLocation;
                              });
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE3F2FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
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
        );
      },
    );
  }

  void _showBirthdayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('생년월일을 선택해주세요'),
          titlePadding:
              const EdgeInsets.only(top: 15, bottom: 0, left: 20, right: 20),
          content: SizedBox(
            height: 350,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 32,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedYear = _years[index];
                            });
                          },
                          children:
                              _years.map((year) => Text('$year')).toList(),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 32,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMonth = _months[index];
                            });
                          },
                          children:
                              _months.map((month) => Text('$month')).toList(),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 32,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedDay = _days[index];
                            });
                          },
                          children: _days.map((day) => Text('$day')).toList(),
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
                      setState(() {
                        _birthday =
                            '${_selectedYear ?? _years[0]}년 ${_selectedMonth ?? _months[0]}월 ${_selectedDay ?? _days[0]}일';
                      });
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
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
      },
    );
  }

  void _showOccupationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('직업을 선택해주세요'),
          titlePadding:
              const EdgeInsets.only(top: 15, bottom: 0, left: 20, right: 20),
          content: SizedBox(
            height: 350,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedOccupationIndex = index;
                      });
                    },
                    children: _occupations
                        .map((occupation) => Text(occupation))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _occupation =
                            _occupations[_selectedOccupationIndex ?? 0];
                      });
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
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
      },
    );
  }

  void _showMBTIDialog() {
    String? selectedMbti;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) => Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'MBTI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: _mbtiTypes.length,
                    itemBuilder: (context, index) => ElevatedButton(
                      onPressed: () {
                        setDialogState(() {
                          if (selectedMbti == _mbtiTypes[index]) {
                            selectedMbti = null;
                          } else {
                            selectedMbti = _mbtiTypes[index];
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMbti == _mbtiTypes[index]
                            ? const Color(0xFF90CAF9)
                            : const Color(0xFFE3F2FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        _mbtiTypes[index],
                        style: TextStyle(
                          color: selectedMbti == _mbtiTypes[index]
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
                              borderRadius: BorderRadius.circular(4),
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
                          onPressed: selectedMbti != null
                              ? () {
                                  setState(() {
                                    _mbti = selectedMbti;
                                    _mbtiSelections = {
                                      'energy': '',
                                      'information': '',
                                      'decision': '',
                                      'lifestyle': '',
                                    };
                                  });
                                  Navigator.pop(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE3F2FD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
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
      },
    );
  }

  void _showMBTIDetailDialog() {
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

    void showTooltip(BuildContext context, String text) {
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

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
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
                    fontSize: 12,
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
                            setState(() {
                              _mbti = _mbtiSelections.values.join('');
                              _mbtiSelections = {
                                'energy': '',
                                'information': '',
                                'decision': '',
                                'lifestyle': '',
                              };
                            });
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
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
    Function(BuildContext, String) showTooltip,
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
                onLongPress: () {
                  showTooltip(context, tooltips[entry.key]!);
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
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                  child: Text(
                    '${entry.key} : ${entry.value}',
                    style: TextStyle(
                      color: _mbtiSelections[key] == entry.key
                          ? Colors.black
                          : Colors.grey,
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
                      const Text('MBTI'),
                      const SizedBox(height: 8),
                      _buildInputField('MBTI를 선택해 주세요', _mbti, _showMBTIDialog),
                      const SizedBox(height: 20),
                    ],
                    if (_name != null &&
                        _location != null &&
                        _birthday != null) ...[
                      const Text('직업'),
                      const SizedBox(height: 8),
                      _buildInputField(
                          '직업을 선택해 주세요', _occupation, _showOccupationDialog),
                      const SizedBox(height: 20),
                    ],
                    if (_name != null && _location != null) ...[
                      const Text('생년월일'),
                      const SizedBox(height: 8),
                      _buildInputField(
                          '생년월일을 선택해 주세요', _birthday, _showBirthdayDialog),
                      const SizedBox(height: 20),
                    ],
                    if (_name != null) ...[
                      const Text('거주지'),
                      const SizedBox(height: 8),
                      _buildInputField(
                          '거주지를 선택해 주세요', _location, _showLocationDialog),
                      const SizedBox(height: 20),
                    ],
                    const Text('이름'),
                    const SizedBox(height: 8),
                    _buildInputField('이름을 입력해 주세요', _name, _showNameDialog),
                    if (_name != null &&
                        _location != null &&
                        _birthday != null &&
                        _occupation != null &&
                        _mbti != null) ...[
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/inbox');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            '다음',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, String? value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: value != null ? Colors.grey[100] : Colors.white,
        ),
        child: Text(
          value ?? hint,
          style: TextStyle(
            color: value != null ? Colors.black : Colors.grey,
            fontSize: 16,
          ),
          textAlign: value != null ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }
}
