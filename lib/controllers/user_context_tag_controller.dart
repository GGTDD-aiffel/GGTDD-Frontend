import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_tag_model.dart';
import 'package:ggtdd_frontend/data/services/user_context_tag_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_context_tag_model.dart';

class UserContextTagController extends ChangeNotifier {
  final UserContextTagService _service;
  List<UserContextTag> _tags = [];
  UserContextTag? _tag;
  bool _isLoading = false;

  List<UserContextTag> get tags => _tags;
  UserContextTag? get tag => _tag;
  bool get isLoading => _isLoading;

  UserContextTagController({required UserContextTagService service})
      : _service = service;

  Future<void> fetchUserContextTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUserContextTags();
      if (response.code == 200 && response.data != null) {
        _tags = response.data!.tags;
        print('유저 맥락 태그 리스트 조회 성공: ${response.message}');
      } else {
        print(
            '유저 맥락 태그 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.getUserContextTag(tagId);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('유저 맥락 태그 조회 성공: ${response.message}');
      } else {
        print('유저 맥락 태그 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.updateUserContextTag(tagId, request);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('유저 맥락 태그 수정 성공: ${response.message}');
      } else {
        print('유저 맥락 태그 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('유저 맥락 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
