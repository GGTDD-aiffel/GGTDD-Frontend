import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/data/services/actionable_step_service.dart';

class ActionableStepController extends ChangeNotifier {
  final ActionableStepService _service;
  List<ActionableStepResponse> _steps = [];
  ActionableStepResponse? _step;
  PaginationMeta? _meta;
  bool _isLoading = false;

  List<ActionableStepResponse> get steps => _steps;
  ActionableStepResponse? get step => _step;
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
      _steps = response.data;
      _meta = response.meta;
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
      _step = await _service.getActionableStep(stepId);
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
      _step = await _service.updateActionableStep(stepId, request);
    } catch (e) {
      print('실행 단계 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
