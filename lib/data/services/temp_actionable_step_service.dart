import 'package:ggtdd_frontend/data/model/api_temp_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/repositories/temp_actionable_step_repository.dart';

class TempActionableStepService {
  final TempActionableStepRepository _repository;

  TempActionableStepService({required TempActionableStepRepository repository})
      : _repository = repository;

  Future<TempActionableStepResponse> createTempActionableStep(
      TempActionableStepCreateRequest request) async {
    return await _repository.createTempActionableStep(request);
  }

  Future<TempActionableStepResponse?> getTempActionableStep(
      String stepId) async {
    return await _repository.fetchTempActionableStep(stepId);
  }

  Future<TempActionableStepListResponse> getTempActionableSteps() async {
    return await _repository.fetchTempActionableSteps();
  }

  Future<TempActionableStepResponse> updateTempActionableStep(
      String stepId, TempActionableStepUpdateRequest request) async {
    return await _repository.updateTempActionableStep(stepId, request);
  }

  Future<void> deleteTempActionableStep(String stepId) async {
    await _repository.deleteTempActionableStep(stepId);
  }
}
