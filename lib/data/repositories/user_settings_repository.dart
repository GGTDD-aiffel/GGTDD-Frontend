import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_settings_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_setting_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserSettingsRepository {
  Future<UserSettingsCreateResponse> createUserSettings(String userId) async {
    try {
      final settingId =
          FirebaseFirestore.instance.collection('user_settings').doc().id;
      final settingsData = {
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
        return UserSettingsCreateResponse(
          code: 200,
          status: 'success',
          message: '유저 설정 생성 성공',
          data: UserSettings.fromJson(data, docId: settingId),
        );
      }
      throw Exception('생성된 유저 설정을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 설정 생성 오류: $e');
      return UserSettingsCreateResponse(
        code: 500,
        status: 'error',
        message: '유저 설정 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<UserSettingsResponseDto> fetchUserSettings(String settingId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('user_settings', settingId);
      if (data != null) {
        return UserSettingsResponseDto(
          code: 200,
          status: 'success',
          message: '유저 설정 조회 성공',
          data: UserSettingsResponse(
            settings: UserSettings.fromJson(data, docId: settingId),
          ),
        );
      }
      return UserSettingsResponseDto(
        code: 404,
        status: 'not_found',
        message: '유저 설정을 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('유저 설정 조회 오류: $e');
      return UserSettingsResponseDto(
        code: 500,
        status: 'error',
        message: '유저 설정 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserSettingsUpdateResponse> updateUserSettings(
      String settingId, UserSettingsUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_settings', settingId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('user_settings', settingId);
      if (data != null) {
        return UserSettingsUpdateResponse(
          code: 200,
          status: 'success',
          message: '유저 설정 수정 성공',
          data: UserSettings.fromJson(data, docId: settingId),
        );
      }
      throw Exception('수정된 유저 설정을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 설정 수정 오류: $e');
      return UserSettingsUpdateResponse(
        code: 500,
        status: 'error',
        message: '유저 설정 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<UserSettingsDeleteResponse> deleteUserSettings(
      String settingId) async {
    try {
      await FirebaseUtils.deleteDocument('user_settings', settingId);
      return UserSettingsDeleteResponse(
        code: 200,
        status: 'success',
        message: '유저 설정 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('유저 설정 삭제 오류: $e');
      return UserSettingsDeleteResponse(
        code: 500,
        status: 'error',
        message: '유저 설정 삭제 실패: $e',
        data: null,
      );
    }
  }
}
