import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/data/services/actionable_step_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/actionable_step_model.dart';

class ActionableStepController extends ChangeNotifier {
  final ActionableStepService _service;
  List<ActionableStep> _steps = [];
  ActionableStep? _step;
  PaginationMeta? _meta;
  bool _isLoading = false;

  List<ActionableStep> get steps => _steps;
  ActionableStep? get step => _step;
  PaginationMeta? get meta => _meta;
  bool get isLoading => _isLoading;

  ActionableStepController({required ActionableStepService service})
      : _service = service;

  Future<void> fetchActionableSteps({int page = 1, int limit = 10}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await _service.getActionableSteps(page: page, limit: limit);
      if (response.code == 200 && response.data != null) {
        _steps = response.data!.steps;
        _meta = response.data!.meta;
        print('실행 단계 리스트 조회 성공: ${response.message}');
      } else {
        print('실행 단계 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('실행 단계 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchActionableStep(String stepId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getActionableStep(stepId);
      if (response.code == 200 && response.data != null) {
        _step = response.data!.step;
        print('실행 단계 조회 성공: ${response.message}');
      } else {
        print('실행 단계 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('실행 단계 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateActionableStep(
      String stepId, ActionableStepUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.updateActionableStep(stepId, request);
      if (response.code == 200 && response.data != null) {
        _step = response.data!.step;
        print('실행 단계 수정 성공: ${response.message}');
      } else {
        print('실행 단계 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('실행 단계 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
