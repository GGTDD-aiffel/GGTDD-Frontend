import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_default_occupation_context_tag_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_occupation_context_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class DefaultOccupationContextTagRepository {
  Future<DefaultOccupationContextTagCreateResponse>
      createDefaultOccupationContextTag(
          DefaultOccupationContextTagCreateRequest request) async {
    try {
      final tagId = FirebaseFirestore.instance
          .collection('default_occupation_context_tags')
          .doc()
          .id;
      final tagData = request.toJson();
      await FirebaseUtils.writeDocument(
          'default_occupation_context_tags', tagId, tagData);
      final data = await FirebaseUtils.fetchDocument(
          'default_occupation_context_tags', tagId);
      if (data != null) {
        return DefaultOccupationContextTagCreateResponse(
          code: 200,
          status: 'success',
          message: '기본 직업 맥락 태그 생성 성공',
          data:
              DefaultOccupationContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('생성된 기본 직업 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 직업 맥락 태그 생성 오류: $e');
      return DefaultOccupationContextTagCreateResponse(
        code: 500,
        status: 'error',
        message: '기본 직업 맥락 태그 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultOccupationContextTagGetResponse>
      fetchDefaultOccupationContextTag(String tagId) async {
    try {
      final data = await FirebaseUtils.fetchDocument(
          'default_occupation_context_tags', tagId);
      if (data != null) {
        return DefaultOccupationContextTagGetResponse(
          code: 200,
          status: 'success',
          message: '기본 직업 맥락 태그 조회 성공',
          data:
              DefaultOccupationContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      return DefaultOccupationContextTagGetResponse(
        code: 404,
        status: 'not_found',
        message: '기본 직업 맥락 태그를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('기본 직업 맥락 태그 조회 오류: $e');
      return DefaultOccupationContextTagGetResponse(
        code: 500,
        status: 'error',
        message: '기본 직업 맥락 태그 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultOccupationContextTagListResponseDto>
      fetchDefaultOccupationContextTags() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('default_occupation_context_tags')
          .get();
      final tags = snapshot.docs.map((doc) {
        return DefaultOccupationContextTag.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return DefaultOccupationContextTagListResponseDto(
        code: 200,
        status: 'success',
        message: '기본 직업 맥락 태그 리스트 조회 성공',
        data: DefaultOccupationContextTagListResponse(tags: tags),
      );
    } catch (e) {
      print('기본 직업 맥락 태그 리스트 조회 오류: $e');
      return DefaultOccupationContextTagListResponseDto(
        code: 500,
        status: 'error',
        message: '기본 직업 맥락 태그 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultOccupationContextTagUpdateResponse>
      updateDefaultOccupationContextTag(String tagId,
          DefaultOccupationContextTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'default_occupation_context_tags', tagId, request.toJson());
      final data = await FirebaseUtils.fetchDocument(
          'default_occupation_context_tags', tagId);
      if (data != null) {
        return DefaultOccupationContextTagUpdateResponse(
          code: 200,
          status: 'success',
          message: '기본 직업 맥락 태그 수정 성공',
          data:
              DefaultOccupationContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('수정된 기본 직업 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 직업 맥락 태그 수정 오류: $e');
      return DefaultOccupationContextTagUpdateResponse(
        code: 500,
        status: 'error',
        message: '기본 직업 맥락 태그 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultOccupationContextTagDeleteResponse>
      deleteDefaultOccupationContextTag(String tagId) async {
    try {
      await FirebaseUtils.deleteDocument(
          'default_occupation_context_tags', tagId);
      return DefaultOccupationContextTagDeleteResponse(
        code: 200,
        status: 'success',
        message: '기본 직업 맥락 태그 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('기본 직업 맥락 태그 삭제 오류: $e');
      return DefaultOccupationContextTagDeleteResponse(
        code: 500,
        status: 'error',
        message: '기본 직업 맥락 태그 삭제 실패: $e',
        data: null,
      );
    }
  }
}
