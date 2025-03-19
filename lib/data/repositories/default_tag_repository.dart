import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_default_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class DefaultTagRepository {
  // 기본 태그 생성
  Future<DefaultTagResponse> createDefaultTag(
      DefaultTagCreateRequest request) async {
    try {
      final tagId =
          FirebaseFirestore.instance.collection('default_tags').doc().id;
      final tagData = request.toJson()..['default_tag_id'] = tagId;
      await FirebaseUtils.writeDocument('default_tags', tagId, tagData);
      final data = await FirebaseUtils.fetchDocument('default_tags', tagId);
      if (data != null) {
        return DefaultTagResponse.fromJson(data);
      }
      throw Exception('생성된 기본 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 태그 생성 오류: $e');
      rethrow;
    }
  }

  // 기본 태그 조회
  Future<DefaultTagResponse?> fetchDefaultTag(String tagId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('default_tags', tagId);
      if (data != null) {
        return DefaultTagResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('기본 태그 조회 오류: $e');
      return null;
    }
  }

  // 기본 태그 리스트 조회
  Future<DefaultTagListResponse> fetchDefaultTags() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'default_tags');
      final tags =
          data.map((item) => DefaultTagResponse.fromJson(item)).toList();
      return DefaultTagListResponse(data: tags);
    } catch (e) {
      print('기본 태그 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 기본 태그 수정
  Future<DefaultTagResponse> updateDefaultTag(
      String tagId, DefaultTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'default_tags', tagId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('default_tags', tagId);
      if (data != null) {
        return DefaultTagResponse.fromJson(data);
      }
      throw Exception('수정된 기본 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 태그 수정 오류: $e');
      rethrow;
    }
  }

  // 기본 태그 삭제
  Future<void> deleteDefaultTag(String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('default_tags', tagId);
    } catch (e) {
      print('기본 태그 삭제 오류: $e');
      rethrow;
    }
  }
}
