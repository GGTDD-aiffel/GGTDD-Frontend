import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_recommended_context_tag_model.dart';
import 'package:ggtdd_frontend/data/services/recommended_context_tag_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/recommended_context_tag_model.dart';

class RecommendedContextTagController extends ChangeNotifier {
  final RecommendedContextTagService _service;
  List<RecommendedContextTag> _tags = [];
  RecommendedContextTag? _tag;
  bool _isLoading = false;

  List<RecommendedContextTag> get tags => _tags;
  RecommendedContextTag? get tag => _tag;
  bool get isLoading => _isLoading;

  RecommendedContextTagController(
      {required RecommendedContextTagService service})
      : _service = service;

  Future<void> fetchRecommendedContextTags() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getRecommendedContextTags();
      if (response.code == 200 && response.data != null) {
        _tags = response.data!.tags;
        print('추천 맥락 태그 리스트 조회 성공: ${response.message}');
      } else {
        print(
            '추천 맥락 태그 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response =
          await _service.getRecommendedContextTag(recommendationId);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('추천 맥락 태그 조회 성공: ${response.message}');
      } else {
        print('추천 맥락 태그 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response =
          await _service.updateRecommendedContextTag(recommendationId, request);
      if (response.code == 200 && response.data != null) {
        _tag = response.data!.tag;
        print('추천 맥락 태그 수정 성공: ${response.message}');
      } else {
        print('추천 맥락 태그 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('추천 맥락 태그 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
