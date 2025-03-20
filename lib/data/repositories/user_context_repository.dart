import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_context_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserContextRepository {
  Future<UserContextCreateResponse> createUserContext(
      UserContextCreateRequest request) async {
    try {
      final contextId =
          FirebaseFirestore.instance.collection('user_contexts').doc().id;
      final contextData = request.toJson();
      await FirebaseUtils.writeDocument(
          'user_contexts', contextId, contextData);
      final data =
          await FirebaseUtils.fetchDocument('user_contexts', contextId);
      if (data != null) {
        return UserContextCreateResponse(
          code: 200,
          status: 'success',
          message: '유저 맥락 생성 성공',
          data: UserContextResponse.fromJson(data, docId: contextId),
        );
      }
      throw Exception('생성된 유저 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 생성 오류: $e');
      return UserContextCreateResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextGetResponse> fetchUserContext(String contextId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('user_contexts', contextId);
      if (data != null) {
        return UserContextGetResponse(
          code: 200,
          status: 'success',
          message: '유저 맥락 조회 성공',
          data: UserContextResponse.fromJson(data, docId: contextId),
        );
      }
      return UserContextGetResponse(
        code: 404,
        status: 'not_found',
        message: '유저 맥락을 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('유저 맥락 조회 오류: $e');
      return UserContextGetResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextListResponseDto> fetchUserContexts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('user_contexts').get();
      final contexts = snapshot.docs.map((doc) {
        return UserContext.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return UserContextListResponseDto(
        code: 200,
        status: 'success',
        message: '유저 맥락 리스트 조회 성공',
        data: UserContextListResponse(contexts: contexts),
      );
    } catch (e) {
      print('유저 맥락 리스트 조회 오류: $e');
      return UserContextListResponseDto(
        code: 500,
        status: 'error',
        message: '유저 맥락 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextUpdateResponse> updateUserContext(
      String contextId, UserContextUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_contexts', contextId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('user_contexts', contextId);
      if (data != null) {
        return UserContextUpdateResponse(
          code: 200,
          status: 'success',
          message: '유저 맥락 수정 성공',
          data: UserContextResponse.fromJson(data, docId: contextId),
        );
      }
      throw Exception('수정된 유저 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 수정 오류: $e');
      return UserContextUpdateResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextDeleteResponse> deleteUserContext(String contextId) async {
    try {
      await FirebaseUtils.deleteDocument('user_contexts', contextId);
      return UserContextDeleteResponse(
        code: 200,
        status: 'success',
        message: '유저 맥락 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('유저 맥락 삭제 오류: $e');
      return UserContextDeleteResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 삭제 실패: $e',
        data: null,
      );
    }
  }
}
