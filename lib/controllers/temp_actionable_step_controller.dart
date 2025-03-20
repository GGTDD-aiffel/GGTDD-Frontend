import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_temp_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/services/temp_actionable_step_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/temp_actionable_step_model.dart';

class TempActionableStepController extends ChangeNotifier {
  final TempActionableStepService _service;
  List<TempActionableStep> _steps = [];
  TempActionableStep? _step;
  bool _isLoading = false;

  List<TempActionableStep> get steps => _steps;
  TempActionableStep? get step => _step;
  bool get isLoading => _isLoading;

  TempActionableStepController({required TempActionableStepService service})
      : _service = service;

  Future<void> fetchTempActionableSteps() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getTempActionableSteps();
      if (response.code == 200 && response.data != null) {
        _steps = response.data!.steps;
        print('임시 실행 단계 리스트 조회 성공: ${response.message}');
      } else {
        print(
            '임시 실행 단계 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.getTempActionableStep(stepId);
      if (response.code == 200 && response.data != null) {
        _step = response.data!.step;
        print('임시 실행 단계 조회 성공: ${response.message}');
      } else {
        print('임시 실행 단계 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.updateTempActionableStep(stepId, request);
      if (response.code == 200 && response.data != null) {
        _step = response.data!.step;
        print('임시 실행 단계 수정 성공: ${response.message}');
      } else {
        print('임시 실행 단계 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('임시 실행 단계 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
