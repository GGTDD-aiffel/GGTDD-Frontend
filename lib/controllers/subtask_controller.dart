import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_subtask_model.dart';
import 'package:ggtdd_frontend/data/services/subtask_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/sub_task_model.dart';

class SubtaskController extends ChangeNotifier {
  final SubtaskService _service;
  List<Subtask> _subtasks = [];
  Subtask? _subtask;
  bool _isLoading = false;

  List<Subtask> get subtasks => _subtasks;
  Subtask? get subtask => _subtask;
  bool get isLoading => _isLoading;

  SubtaskController({required SubtaskService service}) : _service = service;

  Future<void> fetchSubtasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getSubtasks();
      if (response.code == 200 && response.data != null) {
        _subtasks = response.data!.subtasks;
        print('서브태스크 리스트 조회 성공: ${response.message}');
      } else {
        print('서브태스크 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.getSubtask(subtaskId);
      if (response.code == 200 && response.data != null) {
        _subtask = response.data!.subtask;
        print('서브태스크 조회 성공: ${response.message}');
      } else {
        print('서브태스크 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.updateSubtask(subtaskId, request);
      if (response.code == 200 && response.data != null) {
        _subtask = response.data!.subtask;
        print('서브태스크 수정 성공: ${response.message}');
      } else {
        print('서브태스크 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('서브태스크 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
