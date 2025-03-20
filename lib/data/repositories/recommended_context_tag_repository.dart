import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_recommended_context_tag_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/recommended_context_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class RecommendedContextTagRepository {
  Future<RecommendedContextTagCreateResponse> createRecommendedContextTag(
      RecommendedContextTagCreateRequest request) async {
    try {
      final recommendationId = FirebaseFirestore.instance
          .collection('recommended_context_tags')
          .doc()
          .id;
      final tagData = request.toJson();
      await FirebaseUtils.writeDocument(
          'recommended_context_tags', recommendationId, tagData);
      final data = await FirebaseUtils.fetchDocument(
          'recommended_context_tags', recommendationId);
      if (data != null) {
        return RecommendedContextTagCreateResponse(
          code: 200,
          status: 'success',
          message: '추천 맥락 태그 생성 성공',
          data: RecommendedContextTagResponse.fromJson(data,
              docId: recommendationId),
        );
      }
      throw Exception('생성된 추천 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('추천 맥락 태그 생성 오류: $e');
      return RecommendedContextTagCreateResponse(
        code: 500,
        status: 'error',
        message: '추천 맥락 태그 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<RecommendedContextTagGetResponse> fetchRecommendedContextTag(
      String recommendationId) async {
    try {
      final data = await FirebaseUtils.fetchDocument(
          'recommended_context_tags', recommendationId);
      if (data != null) {
        return RecommendedContextTagGetResponse(
          code: 200,
          status: 'success',
          message: '추천 맥락 태그 조회 성공',
          data: RecommendedContextTagResponse.fromJson(data,
              docId: recommendationId),
        );
      }
      return RecommendedContextTagGetResponse(
        code: 404,
        status: 'not_found',
        message: '추천 맥락 태그를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('추천 맥락 태그 조회 오류: $e');
      return RecommendedContextTagGetResponse(
        code: 500,
        status: 'error',
        message: '추천 맥락 태그 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<RecommendedContextTagListResponseDto>
      fetchRecommendedContextTags() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('recommended_context_tags')
          .get();
      final tags = snapshot.docs.map((doc) {
        return RecommendedContextTag.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return RecommendedContextTagListResponseDto(
        code: 200,
        status: 'success',
        message: '추천 맥락 태그 리스트 조회 성공',
        data: RecommendedContextTagListResponse(tags: tags),
      );
    } catch (e) {
      print('추천 맥락 태그 리스트 조회 오류: $e');
      return RecommendedContextTagListResponseDto(
        code: 500,
        status: 'error',
        message: '추천 맥락 태그 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<RecommendedContextTagUpdateResponse> updateRecommendedContextTag(
      String recommendationId,
      RecommendedContextTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'recommended_context_tags', recommendationId, request.toJson());
      final data = await FirebaseUtils.fetchDocument(
          'recommended_context_tags', recommendationId);
      if (data != null) {
        return RecommendedContextTagUpdateResponse(
          code: 200,
          status: 'success',
          message: '추천 맥락 태그 수정 성공',
          data: RecommendedContextTagResponse.fromJson(data,
              docId: recommendationId),
        );
      }
      throw Exception('수정된 추천 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('추천 맥락 태그 수정 오류: $e');
      return RecommendedContextTagUpdateResponse(
        code: 500,
        status: 'error',
        message: '추천 맥락 태그 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<RecommendedContextTagDeleteResponse> deleteRecommendedContextTag(
      String recommendationId) async {
    try {
      await FirebaseUtils.deleteDocument(
          'recommended_context_tags', recommendationId);
      return RecommendedContextTagDeleteResponse(
        code: 200,
        status: 'success',
        message: '추천 맥락 태그 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('추천 맥락 태그 삭제 오류: $e');
      return RecommendedContextTagDeleteResponse(
        code: 500,
        status: 'error',
        message: '추천 맥락 태그 삭제 실패: $e',
        data: null,
      );
    }
  }
}
