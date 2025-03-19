import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_tag_model.dart';
import 'package:ggtdd_frontend/data/services/user_context_tag_service.dart';

class UserContextTagController extends ChangeNotifier {
  final UserContextTagService _service;
  List<UserContextTagResponse> _tags = [];
  UserContextTagResponse? _tag;
  bool _isLoading = false;

  List<UserContextTagResponse> get tags => _tags;
  UserContextTagResponse? get tag => _tag;
  bool get isLoading => _isLoading;

  UserContextTagController({required UserContextTagService service})
      : _service = service;

  Future<void> fetchUserContextTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserContextTags();
      _tags = response.data;
    } catch (e) {
      print('유저 맥락 태그 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserContextTag(String tagId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag = await _service.getUserContextTag(tagId);
    } catch (e) {
      print('유저 맥락 태그 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserContextTag(
      String tagId, UserContextTagUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag = await _service.updateUserContextTag(tagId, request);
    } catch (e) {
      print('유저 맥락 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
