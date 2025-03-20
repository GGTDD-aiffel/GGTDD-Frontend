import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_default_tag_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class DefaultTagRepository {
  Future<DefaultTagCreateResponse> createDefaultTag(
      DefaultTagCreateRequest request) async {
    try {
      final tagId =
          FirebaseFirestore.instance.collection('default_tags').doc().id;
      final tagData = request.toJson();
      await FirebaseUtils.writeDocument('default_tags', tagId, tagData);
      final data = await FirebaseUtils.fetchDocument('default_tags', tagId);
      if (data != null) {
        return DefaultTagCreateResponse(
          code: 200,
          status: 'success',
          message: '기본 태그 생성 성공',
          data: DefaultTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('생성된 기본 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 태그 생성 오류: $e');
      return DefaultTagCreateResponse(
        code: 500,
        status: 'error',
        message: '기본 태그 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTagGetResponse> fetchDefaultTag(String tagId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('default_tags', tagId);
      if (data != null) {
        return DefaultTagGetResponse(
          code: 200,
          status: 'success',
          message: '기본 태그 조회 성공',
          data: DefaultTagResponse.fromJson(data, docId: tagId),
        );
      }
      return DefaultTagGetResponse(
        code: 404,
        status: 'not_found',
        message: '기본 태그를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('기본 태그 조회 오류: $e');
      return DefaultTagGetResponse(
        code: 500,
        status: 'error',
        message: '기본 태그 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTagListResponseDto> fetchDefaultTags() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('default_tags').get();
      final tags = snapshot.docs.map((doc) {
        return DefaultTag.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return DefaultTagListResponseDto(
        code: 200,
        status: 'success',
        message: '기본 태그 리스트 조회 성공',
        data: DefaultTagListResponse(tags: tags),
      );
    } catch (e) {
      print('기본 태그 리스트 조회 오류: $e');
      return DefaultTagListResponseDto(
        code: 500,
        status: 'error',
        message: '기본 태그 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTagUpdateResponse> updateDefaultTag(
      String tagId, DefaultTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'default_tags', tagId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('default_tags', tagId);
      if (data != null) {
        return DefaultTagUpdateResponse(
          code: 200,
          status: 'success',
          message: '기본 태그 수정 성공',
          data: DefaultTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('수정된 기본 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 태그 수정 오류: $e');
      return DefaultTagUpdateResponse(
        code: 500,
        status: 'error',
        message: '기본 태그 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTagDeleteResponse> deleteDefaultTag(String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('default_tags', tagId);
      return DefaultTagDeleteResponse(
        code: 200,
        status: 'success',
        message: '기본 태그 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('기본 태그 삭제 오류: $e');
      return DefaultTagDeleteResponse(
        code: 500,
        status: 'error',
        message: '기본 태그 삭제 실패: $e',
        data: null,
      );
    }
  }
}
