import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserTagRepository {
  // 유저 태그 생성
  Future<UserTagResponse> createUserTag(UserTagCreateRequest request) async {
    try {
      final tagId = FirebaseFirestore.instance.collection('user_tags').doc().id;
      final tagData = request.toJson()..['user_tag_id'] = tagId;
      await FirebaseUtils.writeDocument('user_tags', tagId, tagData);
      final data = await FirebaseUtils.fetchDocument('user_tags', tagId);
      if (data != null) {
        return UserTagResponse.fromJson(data);
      }
      throw Exception('생성된 유저 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 태그 생성 오류: $e');
      rethrow;
    }
  }

  // 유저 태그 조회
  Future<UserTagResponse?> fetchUserTag(String tagId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('user_tags', tagId);
      if (data != null) {
        return UserTagResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('유저 태그 조회 오류: $e');
      return null;
    }
  }

  // 유저 태그 리스트 조회
  Future<UserTagListResponse> fetchUserTags() async {
    try {
      final data = await FirebaseUtils.fetchCollection(collection: 'user_tags');
      final tags = data.map((item) => UserTagResponse.fromJson(item)).toList();
      return UserTagListResponse(data: tags);
    } catch (e) {
      print('유저 태그 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 유저 태그 수정
  Future<UserTagResponse> updateUserTag(
      String tagId, UserTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument('user_tags', tagId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('user_tags', tagId);
      if (data != null) {
        return UserTagResponse.fromJson(data);
      }
      throw Exception('수정된 유저 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 태그 수정 오류: $e');
      rethrow;
    }
  }

  // 유저 태그 삭제
  Future<void> deleteUserTag(String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('user_tags', tagId);
    } catch (e) {
      print('유저 태그 삭제 오류: $e');
      rethrow;
    }
  }
}
