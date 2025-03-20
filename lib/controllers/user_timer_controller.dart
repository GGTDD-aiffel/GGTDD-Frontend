import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_timer_model.dart';
import 'package:ggtdd_frontend/data/services/user_timer_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_timer_model.dart';

class UserTimerController extends ChangeNotifier {
  final UserTimerService _service;
  List<UserTimer> _timers = [];
  UserTimer? _timer;
  bool _isLoading = false;

  List<UserTimer> get timers => _timers;
  UserTimer? get timer => _timer;
  bool get isLoading => _isLoading;

  UserTimerController({required UserTimerService service}) : _service = service;

  Future<void> fetchUserTimers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserTimers();
      if (response.code == 200 && response.data != null) {
        _timers = response.data!.timers;
        print('유저 타이머 리스트 조회 성공: ${response.message}');
      } else {
        print('유저 타이머 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 타이머 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserTimer(String timerId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserTimer(timerId);
      if (response.code == 200 && response.data != null) {
        _timer = response.data!.timer;
        print('유저 타이머 조회 성공: ${response.message}');
      } else {
        print('유저 타이머 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 타이머 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserTimer(
      String timerId, UserTimerUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.updateUserTimer(timerId, request);
      if (response.code == 200 && response.data != null) {
        _timer = response.data;
        print('유저 타이머 수정 성공: ${response.message}');
      } else {
        print('유저 타이머 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 타이머 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
