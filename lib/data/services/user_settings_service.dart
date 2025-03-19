import 'package:ggtdd_frontend/data/model/api_user_settings_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_settings_repository.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_setting_model.dart';

class UserSettingsService {
  final UserSettingsRepository _repository;

  UserSettingsService({required UserSettingsRepository repository})
      : _repository = repository;

  Future<UserSettings> createUserSettings(String userId) async {
    return await _repository.createUserSettings(userId);
  }

  Future<UserSettings?> getUserSettings(String settingId) async {
    return await _repository.fetchUserSettings(settingId);
  }

  Future<UserSettings> updateUserSettings(
      String settingId, UserSettingsUpdateRequest request) async {
    return await _repository.updateUserSettings(settingId, request);
  }

  Future<void> deleteUserSettings(String settingId) async {
    await _repository.deleteUserSettings(settingId);
  }
}
