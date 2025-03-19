import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_tag_model.dart';
import 'package:ggtdd_frontend/data/services/user_tag_service.dart';

class UserTagController extends ChangeNotifier {
  final UserTagService _service;
  List<UserTagResponse> _tags = [];
  UserTagResponse? _tag;
  bool _isLoading = false;

  List<UserTagResponse> get tags => _tags;
  UserTagResponse? get tag => _tag;
  bool get isLoading => _isLoading;

  UserTagController({required UserTagService service}) : _service = service;

  Future<void> fetchUserTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserTags();
      _tags = response.data;
    } catch (e) {
      print('유저 태그 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserTag(String tagId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag = await _service.getUserTag(tagId);
    } catch (e) {
      print('유저 태그 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserTag(String tagId, UserTagUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag = await _service.updateUserTag(tagId, request);
    } catch (e) {
      print('유저 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
