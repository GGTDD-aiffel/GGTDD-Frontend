import 'package:ggtdd_frontend/data/model/api_default_timer_model.dart';
import 'package:ggtdd_frontend/data/repositories/default_timer_repository.dart';

class DefaultTimerService {
  final DefaultTimerRepository _repository;

  DefaultTimerService({required DefaultTimerRepository repository})
      : _repository = repository;

  Future<DefaultTimerCreateResponse> createDefaultTimer(
      DefaultTimerCreateRequest request) async {
    return await _repository.createDefaultTimer(request);
  }

  Future<DefaultTimerResponseDto> getDefaultTimer(String timerId) async {
    return await _repository.fetchDefaultTimer(timerId);
  }

  Future<DefaultTimerListResponseDto> getDefaultTimers() async {
    return await _repository.fetchDefaultTimers();
  }

  Future<DefaultTimerUpdateResponse> updateDefaultTimer(
      String timerId, DefaultTimerUpdateRequest request) async {
    return await _repository.updateDefaultTimer(timerId, request);
  }

  Future<DefaultTimerDeleteResponse> deleteDefaultTimer(String timerId) async {
    return await _repository.deleteDefaultTimer(timerId);
  }
}
