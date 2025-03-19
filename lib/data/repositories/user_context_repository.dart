import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserContextRepository {
  // 유저 맥락 생성
  Future<UserContextResponse> createUserContext(
      UserContextCreateRequest request) async {
    try {
      final contextId =
          FirebaseFirestore.instance.collection('user_contexts').doc().id;
      final contextData = request.toJson()..['user_context_id'] = contextId;
      await FirebaseUtils.writeDocument(
          'user_contexts', contextId, contextData);
      final data =
          await FirebaseUtils.fetchDocument('user_contexts', contextId);
      if (data != null) {
        return UserContextResponse.fromJson(data);
      }
      throw Exception('생성된 유저 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 생성 오류: $e');
      rethrow;
    }
  }

  // 유저 맥락 조회
  Future<UserContextResponse?> fetchUserContext(String contextId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('user_contexts', contextId);
      if (data != null) {
        return UserContextResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('유저 맥락 조회 오류: $e');
      return null;
    }
  }

  // 유저 맥락 리스트 조회
  Future<UserContextListResponse> fetchUserContexts() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'user_contexts');
      final contexts =
          data.map((item) => UserContextResponse.fromJson(item)).toList();
      return UserContextListResponse(data: contexts);
    } catch (e) {
      print('유저 맥락 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 유저 맥락 수정
  Future<UserContextResponse> updateUserContext(
      String contextId, UserContextUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_contexts', contextId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('user_contexts', contextId);
      if (data != null) {
        return UserContextResponse.fromJson(data);
      }
      throw Exception('수정된 유저 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 수정 오류: $e');
      rethrow;
    }
  }

  // 유저 맥락 삭제
  Future<void> deleteUserContext(String contextId) async {
    try {
      await FirebaseUtils.deleteDocument('user_contexts', contextId);
    } catch (e) {
      print('유저 맥락 삭제 오류: $e');
      rethrow;
    }
  }
}
