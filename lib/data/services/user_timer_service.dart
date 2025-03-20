import 'package:ggtdd_frontend/data/model/api_user_timer_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_timer_repository.dart';

class UserTimerService {
  final UserTimerRepository _repository;

  UserTimerService({required UserTimerRepository repository})
      : _repository = repository;

  Future<UserTimerCreateResponse> createUserTimer(
      UserTimerCreateRequest request) async {
    return await _repository.createUserTimer(request);
  }

  Future<UserTimerResponseDto> getUserTimer(String timerId) async {
    return await _repository.fetchUserTimer(timerId);
  }

  Future<UserTimerListResponseDto> getUserTimers() async {
    return await _repository.fetchUserTimers();
  }

  Future<UserTimerUpdateResponse> updateUserTimer(
      String timerId, UserTimerUpdateRequest request) async {
    return await _repository.updateUserTimer(timerId, request);
  }

  Future<UserTimerDeleteResponse> deleteUserTimer(String timerId) async {
    return await _repository.deleteUserTimer(timerId);
  }
}
