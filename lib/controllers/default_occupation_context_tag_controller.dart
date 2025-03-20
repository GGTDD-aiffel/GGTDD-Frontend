import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_default_occupation_context_tag_model.dart';
import 'package:ggtdd_frontend/data/services/default_occupation_context_tag_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_occupation_context_tag_model.dart';

class DefaultOccupationContextTagController extends ChangeNotifier {
  final DefaultOccupationContextTagService _service;
  List<DefaultOccupationContextTag> _tags = [];
  DefaultOccupationContextTag? _tag;
  bool _isLoading = false;

  List<DefaultOccupationContextTag> get tags => _tags;
  DefaultOccupationContextTag? get tag => _tag;
  bool get isLoading => _isLoading;

  DefaultOccupationContextTagController(
      {required DefaultOccupationContextTagService service})
      : _service = service;

  Future<void> fetchDefaultOccupationContextTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultOccupationContextTags();
      if (response.code == 200 && response.data != null) {
        _tags = response.data!.tags;
        print('기본 직업 맥락 태그 리스트 조회 성공: ${response.message}');
      } else {
        print(
            '기본 직업 맥락 태그 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 직업 맥락 태그 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDefaultOccupationContextTag(String tagId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultOccupationContextTag(tagId);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('기본 직업 맥락 태그 조회 성공: ${response.message}');
      } else {
        print(
            '기본 직업 맥락 태그 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 직업 맥락 태그 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDefaultOccupationContextTag(
      String tagId, DefaultOccupationContextTagUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await _service.updateDefaultOccupationContextTag(tagId, request);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('기본 직업 맥락 태그 수정 성공: ${response.message}');
      } else {
        print(
            '기본 직업 맥락 태그 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 직업 맥락 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
