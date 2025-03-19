import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_model.dart';
import 'package:ggtdd_frontend/data/services/user_context_service.dart';

class UserContextController extends ChangeNotifier {
  final UserContextService _service;
  List<UserContextResponse> _contexts = [];
  UserContextResponse? _context;
  bool _isLoading = false;

  List<UserContextResponse> get contexts => _contexts;
  UserContextResponse? get context => _context;
  bool get isLoading => _isLoading;

  UserContextController({required UserContextService service})
      : _service = service;

  Future<void> fetchUserContexts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserContexts();
      _contexts = response.data;
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
      _context = await _service.getUserContext(contextId);
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
      _context = await _service.updateUserContext(contextId, request);
    } catch (e) {
      print('유저 맥락 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
