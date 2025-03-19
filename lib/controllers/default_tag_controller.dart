import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_default_tag_model.dart';
import 'package:ggtdd_frontend/data/services/default_tag_service.dart';

class DefaultTagController extends ChangeNotifier {
  final DefaultTagService _service;
  List<DefaultTagResponse> _tags = [];
  DefaultTagResponse? _tag;
  bool _isLoading = false;

  List<DefaultTagResponse> get tags => _tags;
  DefaultTagResponse? get tag => _tag;
  bool get isLoading => _isLoading;

  DefaultTagController({required DefaultTagService service})
      : _service = service;

  Future<void> fetchDefaultTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getDefaultTags();
      _tags = response.data;
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
      _tag = await _service.getDefaultTag(tagId);
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
      _tag = await _service.updateDefaultTag(tagId, request);
    } catch (e) {
      print('기본 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
