import 'package:ggtdd_frontend/data/model/api_temp_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/repositories/temp_actionable_step_repository.dart';

class TempActionableStepService {
  final TempActionableStepRepository _repository;

  TempActionableStepService({required TempActionableStepRepository repository})
      : _repository = repository;

  Future<TempActionableStepCreateResponse> createTempActionableStep(
      TempActionableStepCreateRequest request) async {
    return await _repository.createTempActionableStep(request);
  }

  Future<TempActionableStepGetResponse> getTempActionableStep(
      String stepId) async {
    return await _repository.fetchTempActionableStep(stepId);
  }

  Future<TempActionableStepListResponseDto> getTempActionableSteps() async {
    return await _repository.fetchTempActionableSteps();
  }

  Future<TempActionableStepUpdateResponse> updateTempActionableStep(
      String stepId, TempActionableStepUpdateRequest request) async {
    return await _repository.updateTempActionableStep(stepId, request);
  }

  Future<TempActionableStepDeleteResponse> deleteTempActionableStep(
      String stepId) async {
    return await _repository.deleteTempActionableStep(stepId);
  }
}
