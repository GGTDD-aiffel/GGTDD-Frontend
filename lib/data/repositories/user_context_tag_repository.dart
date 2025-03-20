import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_context_tag_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_context_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserContextTagRepository {
  Future<UserContextTagCreateResponse> createUserContextTag(
      UserContextTagCreateRequest request) async {
    try {
      final tagId =
          FirebaseFirestore.instance.collection('user_context_tags').doc().id;
      final tagData = request.toJson();
      await FirebaseUtils.writeDocument('user_context_tags', tagId, tagData);
      final data =
          await FirebaseUtils.fetchDocument('user_context_tags', tagId);
      if (data != null) {
        return UserContextTagCreateResponse(
          code: 200,
          status: 'success',
          message: '유저 맥락 태그 생성 성공',
          data: UserContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('생성된 유저 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 태그 생성 오류: $e');
      return UserContextTagCreateResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 태그 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextTagGetResponse> fetchUserContextTag(String tagId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('user_context_tags', tagId);
      if (data != null) {
        return UserContextTagGetResponse(
          code: 200,
          status: 'success',
          message: '유저 맥락 태그 조회 성공',
          data: UserContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      return UserContextTagGetResponse(
        code: 404,
        status: 'not_found',
        message: '유저 맥락 태그를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('유저 맥락 태그 조회 오류: $e');
      return UserContextTagGetResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 태그 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextTagListResponseDto> fetchUserContextTags() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('user_context_tags')
          .get();
      final tags = snapshot.docs.map((doc) {
        return UserContextTag.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return UserContextTagListResponseDto(
        code: 200,
        status: 'success',
        message: '유저 맥락 태그 리스트 조회 성공',
        data: UserContextTagListResponse(tags: tags),
      );
    } catch (e) {
      print('유저 맥락 태그 리스트 조회 오류: $e');
      return UserContextTagListResponseDto(
        code: 500,
        status: 'error',
        message: '유저 맥락 태그 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextTagUpdateResponse> updateUserContextTag(
      String tagId, UserContextTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_context_tags', tagId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('user_context_tags', tagId);
      if (data != null) {
        return UserContextTagUpdateResponse(
          code: 200,
          status: 'success',
          message: '유저 맥락 태그 수정 성공',
          data: UserContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('수정된 유저 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 맥락 태그 수정 오류: $e');
      return UserContextTagUpdateResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 태그 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<UserContextTagDeleteResponse> deleteUserContextTag(
      String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('user_context_tags', tagId);
      return UserContextTagDeleteResponse(
        code: 200,
        status: 'success',
        message: '유저 맥락 태그 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('유저 맥락 태그 삭제 오류: $e');
      return UserContextTagDeleteResponse(
        code: 500,
        status: 'error',
        message: '유저 맥락 태그 삭제 실패: $e',
        data: null,
      );
    }
  }
}
