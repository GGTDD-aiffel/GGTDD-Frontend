import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/controllers/occupation_controller.dart';
import 'package:ggtdd_frontend/controllers/user_controller.dart';
import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/data/repositories/occupation_repository.dart';
import 'package:ggtdd_frontend/data/repositories/user_repository.dart';
import 'package:ggtdd_frontend/data/services/occupation_service.dart';
import 'package:ggtdd_frontend/data/services/user_service.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_simple_app_bar.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_card.dart';
import 'package:ggtdd_frontend/ui/core/widgets/custom_icon_text_button.dart';
import 'package:ggtdd_frontend/ui/core/widgets/mbti_model.dart';
import 'package:ggtdd_frontend/ui/core/widgets/occupation_modal.dart';
import 'package:ggtdd_frontend/ui/core/widgets/residence_modal.dart';
import 'package:ggtdd_frontend/ui/features/settings/core/settings_container.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
      await _userController.fetchUser(widget.userId);

      if (_userController.user != null) {
        final user = _userController.user!.user;
        _residenceController.text = user.residence;
        _mbtiController.text = user.mbti;

        if (user.occupationId != null) {
          await _occupationController.fetchOccupation(user.occupationId!);
          _currentOccupationName =
              _occupationController.occupation?.occupationName ?? '직업 없음';
          _currentOccupationId = _occupationController.occupation?.occupationId;
        } else {
          _currentOccupationName = '직업 선택';
          _currentOccupationId = null;
        }
      }

      await _occupationController.fetchOccupations();
    } catch (e) {
      _currentOccupationName = '직업 선택';
      _currentOccupationId = null;
      _residenceController.text = '거주지 선택';
      _mbtiController.text = 'MBTI 선택';
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

  void _showResidenceModal() {
    Get.dialog(
      ResidenceModal(
        initialResidence: _userController.user?.user.residence,
        onSelected: (selected) {
          setState(() {
            _residenceController.text = selected;
          });
        },
      ),
    );
  }

  void _showOccupationModal() {
    Get.dialog(
      OccupationModal(
        initialOccupationId: _occupationController.occupation?.occupationId,
        occupations: _occupationController.occupations.toList(),
        onSelected: (id, name) {
          setState(() {
            _currentOccupationId = id;
            _currentOccupationName = name;
          });
        },
      ),
    );
  }

  void _showMbtiModal() {
    Get.dialog(
      MbtiModal(
        initialMbti: _mbtiController.text,
        onSelected: (selected) {
          setState(() {
            _mbtiController.text = selected;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth * 0.9 > 400 ? 400.0 : screenWidth * 0.9;

    return !_isDataLoaded
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : AnimatedBuilder(
            animation:
                Listenable.merge([_userController, _occupationController]),
            builder: (context, child) {
              if (_userController.user == null) {
                return const Scaffold(
                  body: Center(child: Text('유저 정보를 찾을 수 없습니다.')),
                );
              }

              final user = _userController.user!.user;
              _nameController.text = user.name;
              _emailController.text = user.email;
              _birthDateController.text =
                  user.birthDate.toIso8601String().substring(0, 10);

              return SettingsContainer(
                appBar: const CustomSimpleAppBar(
                  title: '유저 정보',
                ),
                bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const Gap(6),
                            CustomCard(
                              backgroundColor: const Color(0xFFFFFFFF),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: CustomIconTextButton(
                                text: _nameController.text,
                                fontSize: 14.0,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            const Gap(12),
                            const Text(
                              '이메일',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const Gap(6),
                            CustomCard(
                              backgroundColor: const Color(0xFFFFFFFF),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: CustomIconTextButton(
                                text: _emailController.text,
                                fontSize: 14.0,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            const Gap(12),
                            const Text(
                              '생일',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const Gap(6),
                            CustomCard(
                              backgroundColor: const Color(0xFFFFFFFF),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: CustomIconTextButton(
                                text: _birthDateController.text,
                                fontSize: 14.0,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            const Gap(12),
                            const Text(
                              '거주지',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const Gap(6),
                            CustomCard(
                              backgroundColor: const Color(0xFFFFFFFF),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: CustomIconTextButton(
                                text: _residenceController.text,
                                fontSize: 14.0,
                                rightIcon: Icons.arrow_forward_ios,
                                rightIconColor:
                                    const Color(0x999999).withOpacity(0.6),
                                padding: EdgeInsets.zero,
                                onPressed: () => _showResidenceModal(),
                              ),
                            ),
                            const Gap(12),
                            const Text(
                              '직업',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const Gap(6),
                            CustomCard(
                              backgroundColor: const Color(0xFFFFFFFF),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: CustomIconTextButton(
                                text: _currentOccupationName ?? '직업 선택',
                                fontSize: 14.0,
                                rightIcon: Icons.arrow_forward_ios,
                                rightIconColor:
                                    const Color(0x999999).withOpacity(0.6),
                                padding: EdgeInsets.zero,
                                onPressed: () => _showOccupationModal(),
                              ),
                            ),
                            const Gap(12),
                            const Text(
                              'MBTI',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const Gap(6),
                            CustomCard(
                              backgroundColor: const Color(0xFFFFFFFF),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: CustomIconTextButton(
                                text: _mbtiController.text,
                                fontSize: 14.0,
                                rightIcon: Icons.arrow_forward_ios,
                                rightIconColor:
                                    const Color(0x999999).withOpacity(0.6),
                                padding: EdgeInsets.zero,
                                onPressed: () => _showMbtiModal(),
                              ),
                            ),
                            const Gap(24),
                            CustomButton(
                              text: '저장하기',
                              maxWidth: maxWidth,
                              onPressed: () async {
                                final request = UserUpdateRequest(
                                  residence:
                                      _residenceController.text.isNotEmpty
                                          ? _residenceController.text
                                          : null,
                                  occupationId: _currentOccupationId,
                                  mbti: _mbtiController.text.isNotEmpty
                                      ? _mbtiController.text
                                      : null,
                                  updatedAt: DateTime.now(),
                                );
                                await _userController.updateUser(
                                    widget.userId, request);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('유저 정보가 저장되었습니다.')),
                                );
                              },
                              width: double.infinity,
                              height: 48.0,
                              borderRadius: 10.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            const Gap(24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
