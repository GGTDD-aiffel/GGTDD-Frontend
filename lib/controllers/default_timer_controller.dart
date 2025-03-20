import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_default_timer_model.dart';
import 'package:ggtdd_frontend/data/services/defaul_timer_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_timer_model.dart';

class DefaultTimerController extends ChangeNotifier {
  final DefaultTimerService _service;
  List<DefaultTimer> _timers = [];
  DefaultTimer? _timer;
  bool _isLoading = false;

  List<DefaultTimer> get timers => _timers;
  DefaultTimer? get timer => _timer;
  bool get isLoading => _isLoading;

  DefaultTimerController({required DefaultTimerService service})
      : _service = service;

  Future<void> fetchDefaultTimers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultTimers();
      if (response.code == 200 && response.data != null) {
        _timers = response.data!.timers;
        print('기본 타이머 리스트 조회 성공: ${response.message}');
      } else {
        print('기본 타이머 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 타이머 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDefaultTimer(String timerId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultTimer(timerId);
      if (response.code == 200 && response.data != null) {
        _timer = response.data!.timer;
        print('기본 타이머 조회 성공: ${response.message}');
      } else {
        print('기본 타이머 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 타이머 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDefaultTimer(
      String timerId, DefaultTimerUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.updateDefaultTimer(timerId, request);
      if (response.code == 200 && response.data != null) {
        _timer = response.data;
        print('기본 타이머 수정 성공: ${response.message}');
      } else {
        print('기본 타이머 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 타이머 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
