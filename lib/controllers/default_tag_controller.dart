import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_default_tag_model.dart';
import 'package:ggtdd_frontend/data/services/default_tag_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_tag_model.dart';

class DefaultTagController extends ChangeNotifier {
  final DefaultTagService _service;
  List<DefaultTag> _tags = [];
  DefaultTag? _tag;
  bool _isLoading = false;

  List<DefaultTag> get tags => _tags;
  DefaultTag? get tag => _tag;
  bool get isLoading => _isLoading;

  DefaultTagController({required DefaultTagService service})
      : _service = service;

  Future<void> fetchDefaultTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultTags();
      if (response.code == 200 && response.data != null) {
        _tags = response.data!.tags;
        print('기본 태그 리스트 조회 성공: ${response.message}');
      } else {
        print('기본 태그 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 태그 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDefaultTag(String tagId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultTag(tagId);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('기본 태그 조회 성공: ${response.message}');
      } else {
        print('기본 태그 조회 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 태그 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDefaultTag(
      String tagId, DefaultTagUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.updateDefaultTag(tagId, request);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('기본 태그 수정 성공: ${response.message}');
      } else {
        print('기본 태그 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('기본 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
