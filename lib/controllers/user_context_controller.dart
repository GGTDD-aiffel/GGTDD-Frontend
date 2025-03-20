import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_model.dart';
import 'package:ggtdd_frontend/data/services/user_context_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_context_model.dart';

class UserContextController extends ChangeNotifier {
  final UserContextService _service;
  List<UserContext> _contexts = [];
  UserContext? _context;
  bool _isLoading = false;

  List<UserContext> get contexts => _contexts;
  UserContext? get context => _context;
  bool get isLoading => _isLoading;

  UserContextController({required UserContextService service})
      : _service = service;

  Future<void> fetchUserContexts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserContexts();
      if (response.code == 200 && response.data != null) {
        _contexts = response.data!.contexts;
        print('유저 맥락 리스트 조회 성공: ${response.message}');
      } else {
        print('유저 맥락 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 맥락 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserContext(String contextId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserContext(contextId);
      if (response.code == 200 && response.data != null) {
        _context = response.data!.context;
        print('유저 맥락 조회 성공: ${response.message}');
      } else {
        print('유저 맥락 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 맥락 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserContext(
      String contextId, UserContextUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.updateUserContext(contextId, request);
      if (response.code == 200 && response.data != null) {
        _context = response.data!.context;
        print('유저 맥락 수정 성공: ${response.message}');
      } else {
        print('유저 맥락 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 맥락 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
