import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/controllers/occupation_controller.dart';
import 'package:ggtdd_frontend/controllers/user_controller.dart';
import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/data/repositories/occupation_repository.dart';
import 'package:ggtdd_frontend/data/repositories/user_repository.dart';
import 'package:ggtdd_frontend/data/services/occupation_service.dart';
import 'package:ggtdd_frontend/data/services/user_service.dart';

class UserInfoScreen extends StatefulWidget {
  final String userId;

  const UserInfoScreen({super.key, required this.userId});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late UserController _userController;
  late OccupationController _occupationController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _mbtiController = TextEditingController();
  String? _currentOccupationName;
  String? _currentOccupationId;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _userController = UserController(
      service: UserService(repository: UserRepository()),
    );
    _occupationController = OccupationController(
      service: OccupationService(repository: OccupationRepository()),
    );
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      print('Fetching user data for ID: ${widget.userId}');
      await _userController.fetchUser(widget.userId);
      print('User data fetched: ${_userController.user?.user.toString()}');

      if (_userController.user != null &&
          _userController.user!.user.occupationId != null) {
        print(
            'Fetching occupation for ID: ${_userController.user!.user.occupationId}');
        await _occupationController
            .fetchOccupation(_userController.user!.user.occupationId!);
        _currentOccupationName =
            _occupationController.occupation?.occupationName ?? '직업 없음';
        _currentOccupationId = _occupationController.occupation?.occupationId;
        print(
            'Occupation name: $_currentOccupationName, ID: $_currentOccupationId');
      } else {
        _currentOccupationName = '직업 없음';
        _currentOccupationId = null;
        print('No occupation ID found');
      }

      print('Fetching all occupations');
      await _occupationController.fetchOccupations();
      print(
          'Occupations raw JSON: ${_occupationController.occupations.map((o) => o.toJson()).toList()}');
      print(
          'Occupations fetched: ${_occupationController.occupations.length} items');
    } catch (e) {
      print('데이터 로드 오류: $e');
      _currentOccupationName = '직업 없음';
      _currentOccupationId = null;
    } finally {
      setState(() {
        _isDataLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _residenceController.dispose();
    _mbtiController.dispose();
    super.dispose();
  }

  void _showOccupationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 200,
          child: AnimatedBuilder(
            animation: _occupationController,
            builder: (context, child) {
              if (_occupationController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_occupationController.occupations.isEmpty) {
                return const Center(child: Text('직업 리스트가 없습니다.'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: _occupationController.occupations.length,
                itemBuilder: (context, index) {
                  final occupation = _occupationController.occupations[index];
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        _currentOccupationName = occupation.occupationName;
                        _currentOccupationId = occupation.occupationId;
                        print(
                            'Selected occupation: $_currentOccupationName, ID: $_currentOccupationId');
                      });
                      final request = UserUpdateRequest(
                        occupationId: _currentOccupationId,
                        updatedAt: DateTime.now(),
                      );
                      await _userController.updateUser(widget.userId, request);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          occupation.occupationName,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('유저 정보')),
      body: !_isDataLoaded
          ? const Center(child: CircularProgressIndicator())
          : AnimatedBuilder(
              animation:
                  Listenable.merge([_userController, _occupationController]),
              builder: (context, child) {
                if (_userController.user == null) {
                  return const Center(child: Text('유저 정보를 찾을 수 없습니다.'));
                }

                final user = _userController.user!.user;
                _nameController.text = user.name;
                _emailController.text = user.email;
                _birthDateController.text =
                    user.birthDate.toIso8601String().substring(0, 10);
                _residenceController.text = user.residence;
                _mbtiController.text = user.mbti;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: '이름'),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: '이메일'),
                        ),
                        TextField(
                          controller: _birthDateController,
                          decoration: const InputDecoration(
                              labelText: '생일 (YYYY-MM-DD)'),
                          keyboardType: TextInputType.datetime,
                        ),
                        TextField(
                          controller: _residenceController,
                          decoration: const InputDecoration(labelText: '거주지'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('직업'),
                        GestureDetector(
                          onTap: () => _showOccupationModal(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              _currentOccupationName ?? '직업 선택',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _mbtiController,
                          decoration: const InputDecoration(labelText: 'MBTI'),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final request = UserUpdateRequest(
                                residence: _residenceController.text.isNotEmpty
                                    ? _residenceController.text
                                    : null,
                                occupationId: _currentOccupationId,
                                mbti: _mbtiController.text.isNotEmpty
                                    ? _mbtiController.text
                                    : null,
                                updatedAt: DateTime.now(),
                              );
                              print('Saving with request: ${request.toJson()}');
                              await _userController.updateUser(
                                  widget.userId, request);
                              print('User update completed');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('유저 정보가 저장되었습니다.')),
                              );
                            },
                            child: const Text('저장하기'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
