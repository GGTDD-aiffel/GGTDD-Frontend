import 'package:ggtdd_frontend/data/model/api_actionable_step_context_tag_model.dart';
import 'package:ggtdd_frontend/data/repositories/actionable_step_context_tag_repository.dart';

class ActionableStepContextTagService {
  final ActionableStepContextTagRepository _repository;

  ActionableStepContextTagService(
      {required ActionableStepContextTagRepository repository})
      : _repository = repository;

  Future<ActionableStepContextTagResponse> createActionableStepContextTag(
      ActionableStepContextTagCreateRequest request) async {
    return await _repository.createActionableStepContextTag(request);
  }

  Future<ActionableStepContextTagResponse?> getActionableStepContextTag(
      String tagId) async {
    return await _repository.fetchActionableStepContextTag(tagId);
  }

  Future<ActionableStepContextTagListResponse>
      getActionableStepContextTags() async {
    return await _repository.fetchActionableStepContextTags();
  }

  Future<ActionableStepContextTagResponse> updateActionableStepContextTag(
      String tagId, ActionableStepContextTagUpdateRequest request) async {
    return await _repository.updateActionableStepContextTag(tagId, request);
  }

  Future<void> deleteActionableStepContextTag(String tagId) async {
    await _repository.deleteActionableStepContextTag(tagId);
  }
}
