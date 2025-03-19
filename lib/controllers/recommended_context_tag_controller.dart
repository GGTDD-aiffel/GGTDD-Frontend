import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_recommended_context_tag_model.dart';
import 'package:ggtdd_frontend/data/services/recommended_context_tag_service.dart';

class RecommendedContextTagController extends ChangeNotifier {
  final RecommendedContextTagService _service;
  List<RecommendedContextTagResponse> _tags = [];
  RecommendedContextTagResponse? _tag;
  bool _isLoading = false;

  List<RecommendedContextTagResponse> get tags => _tags;
  RecommendedContextTagResponse? get tag => _tag;
  bool get isLoading => _isLoading;

  RecommendedContextTagController(
      {required RecommendedContextTagService service})
      : _service = service;

  Future<void> fetchRecommendedContextTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getRecommendedContextTags();
      _tags = response.data;
    } catch (e) {
      print('추천 맥락 태그 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecommendedContextTag(String recommendationId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag = await _service.getRecommendedContextTag(recommendationId);
    } catch (e) {
      print('추천 맥락 태그 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateRecommendedContextTag(String recommendationId,
      RecommendedContextTagUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tag =
          await _service.updateRecommendedContextTag(recommendationId, request);
    } catch (e) {
      print('추천 맥락 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
