import 'package:ggtdd_frontend/data/model/api_user_timer_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_timer_repository.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_timer_model.dart';

class UserTimerService {
  final UserTimerRepository _repository;

  UserTimerService({required UserTimerRepository repository})
      : _repository = repository;

  Future<UserTimer> createUserTimer(UserTimerCreateRequest request) async {
    return await _repository.createUserTimer(request);
  }

  Future<UserTimer?> getUserTimer(String timerId) async {
    return await _repository.fetchUserTimer(timerId);
  }

  Future<UserTimerListResponse> getUserTimers() async {
    return await _repository.fetchUserTimers();
  }

  Future<UserTimer> updateUserTimer(
      String timerId, UserTimerUpdateRequest request) async {
    return await _repository.updateUserTimer(timerId, request);
  }

  Future<void> deleteUserTimer(String timerId) async {
    await _repository.deleteUserTimer(timerId);
  }
}
