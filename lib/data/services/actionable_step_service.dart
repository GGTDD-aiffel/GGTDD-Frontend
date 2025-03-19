import 'package:ggtdd_frontend/data/model/api_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/repositories/actionable_step_repository.dart';

class ActionableStepService {
  final ActionableStepRepository _repository;

  ActionableStepService({required ActionableStepRepository repository})
      : _repository = repository;

  Future<ActionableStepResponse> createActionableStep(
      ActionableStepCreateRequest request) async {
    return await _repository.createActionableStep(request);
  }

  Future<ActionableStepResponse?> getActionableStep(String stepId) async {
    return await _repository.fetchActionableStep(stepId);
  }

  Future<ActionableStepListResponse> getActionableSteps(
      {int page = 1, int limit = 10}) async {
    return await _repository.fetchActionableSteps(page: page, limit: limit);
  }

  Future<ActionableStepResponse> updateActionableStep(
      String stepId, ActionableStepUpdateRequest request) async {
    return await _repository.updateActionableStep(stepId, request);
  }

  Future<void> deleteActionableStep(String stepId) async {
    await _repository.deleteActionableStep(stepId);
  }
}
