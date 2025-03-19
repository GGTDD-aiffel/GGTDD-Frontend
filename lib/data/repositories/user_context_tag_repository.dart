import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserContextTagRepository {
  // 유저 맥락 태그 생성
  Future<UserContextTagResponse> createUserContextTag(
      UserContextTagCreateRequest request) async {
    try {
      final tagId =
          FirebaseFirestore.instance.collection('user_context_tags').doc().id;
      final tagData = request.toJson()..['user_context_tag_id'] = tagId;
      await FirebaseUtils.writeDocument('user_context_tags', tagId, tagData);
      final data =
          await FirebaseUtils.fetchDocument('user_context_tags', tagId);
      if (data != null) {
        return UserContextTagResponse.fromJson(data);
      }
      throw Exception('생성된 유저 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 태그 생성 오류: $e');
      rethrow;
    }
  }

  // 유저 맥락 태그 조회
  Future<UserContextTagResponse?> fetchUserContextTag(String tagId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('user_context_tags', tagId);
      if (data != null) {
        return UserContextTagResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('유저 맥락 태그 조회 오류: $e');
      return null;
    }
  }

  // 유저 맥락 태그 리스트 조회
  Future<UserContextTagListResponse> fetchUserContextTags() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'user_context_tags');
      final tags =
          data.map((item) => UserContextTagResponse.fromJson(item)).toList();
      return UserContextTagListResponse(data: tags);
    } catch (e) {
      print('유저 맥락 태그 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 유저 맥락 태그 수정
  Future<UserContextTagResponse> updateUserContextTag(
      String tagId, UserContextTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_context_tags', tagId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('user_context_tags', tagId);
      if (data != null) {
        return UserContextTagResponse.fromJson(data);
      }
      throw Exception('수정된 유저 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 태그 수정 오류: $e');
      rethrow;
    }
  }

  // 유저 맥락 태그 삭제
  Future<void> deleteUserContextTag(String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('user_context_tags', tagId);
    } catch (e) {
      print('유저 맥락 태그 삭제 오류: $e');
      rethrow;
    }
  }
}
