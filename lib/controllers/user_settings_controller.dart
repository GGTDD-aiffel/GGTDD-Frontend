import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_settings_model.dart';
import 'package:ggtdd_frontend/data/services/user_settings_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_setting_model.dart';

class UserSettingsController extends ChangeNotifier {
  final UserSettingsService _service;
  UserSettings? _settings;
  bool _isLoading = false;

  UserSettings? get settings => _settings;
  bool get isLoading => _isLoading;

  UserSettingsController({required UserSettingsService service})
      : _service = service;

  Future<void> fetchUserSettings(String settingId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserSettings(settingId);
      if (response.code == 200 && response.data != null) {
        _settings = response.data!.settings;
        print('유저 설정 조회 성공: ${response.message}');
      } else {
        print('유저 설정 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 설정 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserSettings(
      String settingId, UserSettingsUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.updateUserSettings(settingId, request);
      if (response.code == 200 && response.data != null) {
        _settings = response.data;
        print('유저 설정 수정 성공: ${response.message}');
      } else {
        print('유저 설정 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 설정 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
