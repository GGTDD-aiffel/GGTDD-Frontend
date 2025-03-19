import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_recommended_context_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class RecommendedContextTagRepository {
  // 추천 맥락 태그 생성
  Future<RecommendedContextTagResponse> createRecommendedContextTag(
      RecommendedContextTagCreateRequest request) async {
    try {
      final recommendationId = FirebaseFirestore.instance
          .collection('recommended_context_tags')
          .doc()
          .id;
      final tagData = request.toJson()
        ..['recommendation_id'] = recommendationId;
      await FirebaseUtils.writeDocument(
          'recommended_context_tags', recommendationId, tagData);
      final data = await FirebaseUtils.fetchDocument(
          'recommended_context_tags', recommendationId);
      if (data != null) {
        return RecommendedContextTagResponse.fromJson(data);
      }
      throw Exception('생성된 추천 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('추천 맥락 태그 생성 오류: $e');
      rethrow;
    }
  }

  // 추천 맥락 태그 조회
  Future<RecommendedContextTagResponse?> fetchRecommendedContextTag(
      String recommendationId) async {
    try {
      final data = await FirebaseUtils.fetchDocument(
          'recommended_context_tags', recommendationId);
      if (data != null) {
        return RecommendedContextTagResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('추천 맥락 태그 조회 오류: $e');
      return null;
    }
  }

  // 추천 맥락 태그 리스트 조회
  Future<RecommendedContextTagListResponse>
      fetchRecommendedContextTags() async {
    try {
      final data = await FirebaseUtils.fetchCollection(
          collection: 'recommended_context_tags');
      final tags = data
          .map((item) => RecommendedContextTagResponse.fromJson(item))
          .toList();
      return RecommendedContextTagListResponse(data: tags);
    } catch (e) {
      print('추천 맥락 태그 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 추천 맥락 태그 수정
  Future<RecommendedContextTagResponse> updateRecommendedContextTag(
      String recommendationId,
      RecommendedContextTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'recommended_context_tags', recommendationId, request.toJson());
      final data = await FirebaseUtils.fetchDocument(
          'recommended_context_tags', recommendationId);
      if (data != null) {
        return RecommendedContextTagResponse.fromJson(data);
      }
      throw Exception('수정된 추천 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('추천 맥락 태그 수정 오류: $e');
      rethrow;
    }
  }

  // 추천 맥락 태그 삭제
  Future<void> deleteRecommendedContextTag(String recommendationId) async {
    try {
      await FirebaseUtils.deleteDocument(
          'recommended_context_tags', recommendationId);
    } catch (e) {
      print('추천 맥락 태그 삭제 오류: $e');
      rethrow;
    }
  }
}
