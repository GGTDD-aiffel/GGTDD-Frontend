import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/controllers/user_controller.dart';
import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_repository.dart';
import 'package:ggtdd_frontend/data/services/user_service.dart';

class UserInfoScreen extends StatefulWidget {
  final String userId;

  const UserInfoScreen({super.key, required this.userId});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late UserController _controller;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _mbtiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = UserController(
      service: UserService(repository: UserRepository()),
    );
    _controller.fetchUser(widget.userId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _residenceController.dispose();
    _occupationController.dispose();
    _mbtiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('유저 정보')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_controller.user == null) {
            return const Center(child: Text('유저 정보를 찾을 수 없습니다.'));
          }

          final user = _controller.user!.user;
          _nameController.text = user.name;
          _emailController.text = user.email;
          _birthDateController.text =
              user.birthDate.toIso8601String().substring(0, 10);
          _residenceController.text = user.residence;
          _occupationController.text = user.occupationId!;
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
                    decoration:
                        const InputDecoration(labelText: '생일 (YYYY-MM-DD)'),
                    keyboardType: TextInputType.datetime,
                  ),
                  TextField(
                    controller: _residenceController,
                    decoration: const InputDecoration(labelText: '거주지'),
                  ),
                  TextField(
                    controller: _occupationController,
                    decoration: const InputDecoration(labelText: '직업 (ID)'),
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
                          occupationId: _occupationController.text.isNotEmpty
                              ? _occupationController.text
                              : null,
                          mbti: _mbtiController.text.isNotEmpty
                              ? _mbtiController.text
                              : null,
                          updatedAt: DateTime.now(),
                        );
                        await _controller.updateUser(widget.userId, request);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('유저 정보가 저장되었습니다.')),
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
