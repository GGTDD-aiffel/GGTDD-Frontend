import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_settings_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_setting_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserSettingsRepository {
  // 유저 설정 생성
  Future<UserSettings> createUserSettings(String userId) async {
    try {
      final settingId =
          FirebaseFirestore.instance.collection('user_settings').doc().id;
      final settingsData = {
        'user_setting_id': settingId,
        'user_id': userId,
        'intro_page_enabled': true,
        'landing_page_enabled': false,
        'focus_page_enabled': true,
        'theme': 'light',
        'language': 'en',
        'font': 'default',
      };
      await FirebaseUtils.writeDocument(
          'user_settings', settingId, settingsData);
      final data =
          await FirebaseUtils.fetchDocument('user_settings', settingId);
      if (data != null) {
        return UserSettings.fromJson(data);
      }
      throw Exception('생성된 유저 설정을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 설정 생성 오류: $e');
      rethrow;
    }
  }

  // 유저 설정 조회
  Future<UserSettings?> fetchUserSettings(String settingId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('user_settings', settingId);
      if (data != null) {
        return UserSettings.fromJson(data);
      }
      return null;
    } catch (e) {
      print('유저 설정 조회 오류: $e');
      return null;
    }
  }

  // 유저 설정 수정
  Future<UserSettings> updateUserSettings(
      String settingId, UserSettingsUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_settings', settingId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('user_settings', settingId);
      if (data != null) {
        return UserSettings.fromJson(data);
      }
      throw Exception('수정된 유저 설정을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 설정 수정 오류: $e');
      rethrow;
    }
  }

  // 유저 설정 삭제
  Future<void> deleteUserSettings(String settingId) async {
    try {
      await FirebaseUtils.deleteDocument('user_settings', settingId);
    } catch (e) {
      print('유저 설정 삭제 오류: $e');
      rethrow;
    }
  }
}
