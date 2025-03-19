import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_default_context_model.dart';
import 'package:ggtdd_frontend/data/services/default_context_service.dart';

class DefaultContextController extends ChangeNotifier {
  final DefaultContextService _service;
  List<DefaultContextResponse> _contexts = [];
  DefaultContextResponse? _context;
  bool _isLoading = false;

  List<DefaultContextResponse> get contexts => _contexts;
  DefaultContextResponse? get context => _context;
  bool get isLoading => _isLoading;

  DefaultContextController({required DefaultContextService service})
      : _service = service;

  Future<void> fetchDefaultContexts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultContexts();
      _contexts = response.data;
    } catch (e) {
      print('기본 맥락 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDefaultContext(String contextId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _context = await _service.getDefaultContext(contextId);
    } catch (e) {
      print('기본 맥락 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDefaultContext(
      String contextId, DefaultContextUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _context = await _service.updateDefaultContext(contextId, request);
    } catch (e) {
      print('기본 맥락 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
