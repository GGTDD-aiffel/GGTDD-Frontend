import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_subtask_model.dart';
import 'package:ggtdd_frontend/data/services/subtask_service.dart';

class SubtaskController extends ChangeNotifier {
  final SubtaskService _service;
  List<SubtaskResponse> _subtasks = [];
  SubtaskResponse? _subtask;
  bool _isLoading = false;

  List<SubtaskResponse> get subtasks => _subtasks;
  SubtaskResponse? get subtask => _subtask;
  bool get isLoading => _isLoading;

  SubtaskController({required SubtaskService service}) : _service = service;

  Future<void> fetchSubtasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getSubtasks();
      _subtasks = response.data;
    } catch (e) {
      print('서브태스크 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubtask(String subtaskId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _subtask = await _service.getSubtask(subtaskId);
    } catch (e) {
      print('서브태스크 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateSubtask(
      String subtaskId, SubtaskUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _subtask = await _service.updateSubtask(subtaskId, request);
    } catch (e) {
      print('서브태스크 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
