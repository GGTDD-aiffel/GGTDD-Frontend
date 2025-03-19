import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_context_tag_model.dart';
import 'package:ggtdd_frontend/data/services/actionable_step_context_tag_service.dart';

class ActionableStepContextTagController extends ChangeNotifier {
  final ActionableStepContextTagService _service;
  List<ActionableStepContextTagResponse> _tags = [];
  ActionableStepContextTagResponse? _tag;
  bool _isLoading = false;

  List<ActionableStepContextTagResponse> get tags => _tags;
  ActionableStepContextTagResponse? get tag => _tag;
  bool get isLoading => _isLoading;

  ActionableStepContextTagController(
      {required ActionableStepContextTagService service})
      : _service = service;

  Future<void> fetchActionableStepContextTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getActionableStepContextTags();
      _tags = response.data;
    } catch (e) {
      print('실행 단계 맥락 태그 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchActionableStepContextTag(String tagId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag = await _service.getActionableStepContextTag(tagId);
    } catch (e) {
      print('실행 단계 맥락 태그 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateActionableStepContextTag(
      String tagId, ActionableStepContextTagUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag = await _service.updateActionableStepContextTag(tagId, request);
    } catch (e) {
      print('실행 단계 맥락 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
