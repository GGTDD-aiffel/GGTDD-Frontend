import 'package:ggtdd_frontend/data/model/api_user_settings_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_settings_repository.dart';

class UserSettingsService {
  final UserSettingsRepository _repository;

  UserSettingsService({required UserSettingsRepository repository})
      : _repository = repository;

  Future<UserSettingsCreateResponse> createUserSettings(String userId) async {
    return await _repository.createUserSettings(userId);
  }

  Future<UserSettingsResponseDto> getUserSettings(String settingId) async {
    return await _repository.fetchUserSettings(settingId);
  }

  Future<UserSettingsUpdateResponse> updateUserSettings(
      String settingId, UserSettingsUpdateRequest request) async {
    return await _repository.updateUserSettings(settingId, request);
  }

  Future<UserSettingsDeleteResponse> deleteUserSettings(
      String settingId) async {
    return await _repository.deleteUserSettings(settingId);
  }
}
