import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_context_tag_model.dart';
import 'package:ggtdd_frontend/data/services/actionable_step_context_tag_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/actionable_step_context_tag_model.dart';

class ActionableStepContextTagController extends ChangeNotifier {
  final ActionableStepContextTagService _service;
  List<ActionableStepContextTag> _tags = [];
  ActionableStepContextTag? _tag;
  bool _isLoading = false;

  List<ActionableStepContextTag> get tags => _tags;
  ActionableStepContextTag? get tag => _tag;
  bool get isLoading => _isLoading;

  ActionableStepContextTagController(
      {required ActionableStepContextTagService service})
      : _service = service;

  Future<void> fetchActionableStepContextTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getActionableStepContextTags();
      if (response.code == 200 && response.data != null) {
        _tags = response.data!.tags;
        print('실행 단계 맥락 태그 리스트 조회 성공: ${response.message}');
      } else {
        print(
            '실행 단계 맥락 태그 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.getActionableStepContextTag(tagId);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('실행 단계 맥락 태그 조회 성공: ${response.message}');
      } else {
        print(
            '실행 단계 맥락 태그 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response =
          await _service.updateActionableStepContextTag(tagId, request);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('실행 단계 맥락 태그 수정 성공: ${response.message}');
      } else {
        print(
            '실행 단계 맥락 태그 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('실행 단계 맥락 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
