import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_temp_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/services/temp_actionable_step_service.dart';

class TempActionableStepController extends ChangeNotifier {
  final TempActionableStepService _service;
  List<TempActionableStepResponse> _steps = [];
  TempActionableStepResponse? _step;
  bool _isLoading = false;

  List<TempActionableStepResponse> get steps => _steps;
  TempActionableStepResponse? get step => _step;
  bool get isLoading => _isLoading;

  TempActionableStepController({required TempActionableStepService service})
      : _service = service;

  Future<void> fetchTempActionableSteps() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getTempActionableSteps();
      _steps = response.data;
    } catch (e) {
      print('임시 실행 단계 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTempActionableStep(String stepId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _step = await _service.getTempActionableStep(stepId);
    } catch (e) {
      print('임시 실행 단계 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTempActionableStep(
      String stepId, TempActionableStepUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _step = await _service.updateTempActionableStep(stepId, request);
    } catch (e) {
      print('임시 실행 단계 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
