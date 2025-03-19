import 'package:ggtdd_frontend/data/model/api_subtask_model.dart';
import 'package:ggtdd_frontend/data/repositories/subtask_repository.dart';

class SubtaskService {
  final SubtaskRepository _repository;

  SubtaskService({required SubtaskRepository repository})
      : _repository = repository;

  Future<SubtaskResponse> createSubtask(SubtaskCreateRequest request) async {
    return await _repository.createSubtask(request);
  }

  Future<SubtaskResponse?> getSubtask(String subtaskId) async {
    return await _repository.fetchSubtask(subtaskId);
  }

  Future<SubtaskListResponse> getSubtasks() async {
    return await _repository.fetchSubtasks();
  }

  Future<SubtaskResponse> updateSubtask(
      String subtaskId, SubtaskUpdateRequest request) async {
    return await _repository.updateSubtask(subtaskId, request);
  }

  Future<void> deleteSubtask(String subtaskId) async {
    await _repository.deleteSubtask(subtaskId);
  }
}
