import 'package:ggtdd_frontend/data/model/api_default_timer_model.dart';
import 'package:ggtdd_frontend/data/repositories/default_timer_repository.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_timer_model.dart';

class DefaultTimerService {
  final DefaultTimerRepository _repository;

  DefaultTimerService({required DefaultTimerRepository repository})
      : _repository = repository;

  Future<DefaultTimer> createDefaultTimer(
      DefaultTimerCreateRequest request) async {
    return await _repository.createDefaultTimer(request);
  }

  Future<DefaultTimer?> getDefaultTimer(String timerId) async {
    return await _repository.fetchDefaultTimer(timerId);
  }

  Future<DefaultTimerListResponse> getDefaultTimers() async {
    return await _repository.fetchDefaultTimers();
  }

  Future<DefaultTimer> updateDefaultTimer(
      String timerId, DefaultTimerUpdateRequest request) async {
    return await _repository.updateDefaultTimer(timerId, request);
  }

  Future<void> deleteDefaultTimer(String timerId) async {
    await _repository.deleteDefaultTimer(timerId);
  }
}
