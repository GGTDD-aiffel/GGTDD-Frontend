import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_tag_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserTagRepository {
  Future<UserTagCreateResponse> createUserTag(
      UserTagCreateRequest request) async {
    try {
      final tagId = FirebaseFirestore.instance.collection('user_tags').doc().id;
      final tagData = request.toJson();
      await FirebaseUtils.writeDocument('user_tags', tagId, tagData);
      final data = await FirebaseUtils.fetchDocument('user_tags', tagId);
      if (data != null) {
        return UserTagCreateResponse(
          code: 200,
          status: 'success',
          message: '유저 태그 생성 성공',
          data: UserTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('생성된 유저 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 태그 생성 오류: $e');
      return UserTagCreateResponse(
        code: 500,
        status: 'error',
        message: '유저 태그 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTagGetResponse> fetchUserTag(String tagId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('user_tags', tagId);
      if (data != null) {
        return UserTagGetResponse(
          code: 200,
          status: 'success',
          message: '유저 태그 조회 성공',
          data: UserTagResponse.fromJson(data, docId: tagId),
        );
      }
      return UserTagGetResponse(
        code: 404,
        status: 'not_found',
        message: '유저 태그를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('유저 태그 조회 오류: $e');
      return UserTagGetResponse(
        code: 500,
        status: 'error',
        message: '유저 태그 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTagListResponseDto> fetchUserTags() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('user_tags').get();
      final tags = snapshot.docs.map((doc) {
        return UserTag.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return UserTagListResponseDto(
        code: 200,
        status: 'success',
        message: '유저 태그 리스트 조회 성공',
        data: UserTagListResponse(tags: tags),
      );
    } catch (e) {
      print('유저 태그 리스트 조회 오류: $e');
      return UserTagListResponseDto(
        code: 500,
        status: 'error',
        message: '유저 태그 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTagUpdateResponse> updateUserTag(
      String tagId, UserTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument('user_tags', tagId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('user_tags', tagId);
      if (data != null) {
        return UserTagUpdateResponse(
          code: 200,
          status: 'success',
          message: '유저 태그 수정 성공',
          data: UserTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('수정된 유저 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 태그 수정 오류: $e');
      return UserTagUpdateResponse(
        code: 500,
        status: 'error',
        message: '유저 태그 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTagDeleteResponse> deleteUserTag(String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('user_tags', tagId);
      return UserTagDeleteResponse(
        code: 200,
        status: 'success',
        message: '유저 태그 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('유저 태그 삭제 오류: $e');
      return UserTagDeleteResponse(
        code: 500,
        status: 'error',
        message: '유저 태그 삭제 실패: $e',
        data: null,
      );
    }
  }
}
