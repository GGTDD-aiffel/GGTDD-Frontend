import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserRepository {
  // 유저 생성
  Future<UserCreateResponse> createUser(UserCreateRequest request) async {
    try {
      final existingUsers = await FirebaseUtils.fetchCollection(
        collection: 'users',
        whereConditions: {'uid': request.uid},
      );
      if (existingUsers.isNotEmpty) {
        return UserCreateResponse(
          code: 409,
          status: 'conflict',
          message: 'UID ${request.uid}로 이미 등록된 사용자가 있습니다.',
          data: null,
        );
      }

      final userId = FirebaseFirestore.instance.collection('users').doc().id;
      final userData = request.toJson();
      await FirebaseUtils.writeDocument('users', userId, userData);

      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserCreateResponse(
          code: 200,
          status: 'success',
          message: '유저 생성 성공',
          data: UserGetResponse.fromJson(data),
        );
      }
      throw Exception('생성된 사용자를 조회하지 못했습니다.');
    } catch (e) {
      print('사용자 생성 오류: $e');
      return UserCreateResponse(
        code: 500,
        status: 'error',
        message: '유저 생성 실패: $e',
        data: null,
      );
    }
  }

  // 유저 조회
  Future<UserResponse> fetchUser(String userId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserResponse(
          code: 200,
          status: 'success',
          message: '유저 조회 성공',
          data: UserGetResponse.fromJson(data),
        );
      }
      return UserResponse(
        code: 404,
        status: 'not_found',
        message: '유저를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('사용자 조회 오류: $e');
      return UserResponse(
        code: 500,
        status: 'error',
        message: '유저 조회 실패: $e',
        data: null,
      );
    }
  }

  // 유저 수정
  Future<UserUpdateResponse> updateUser(
      String userId, UserUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument('users', userId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserUpdateResponse(
          code: 200,
          status: 'success',
          message: '유저 수정 성공',
          data: UserGetResponse.fromJson(data),
        );
      }
      throw Exception('수정된 사용자를 조회하지 못했습니다.');
    } catch (e) {
      print('사용자 수정 오류: $e');
      return UserUpdateResponse(
        code: 500,
        status: 'error',
        message: '유저 수정 실패: $e',
        data: null,
      );
    }
  }

  // 유저 탈퇴
  Future<UserDeleteResponse> deleteUser(String userId) async {
    try {
      await FirebaseUtils.deleteDocument('users', userId);
      return UserDeleteResponse(
        code: 200,
        status: 'success',
        message: '유저 탈퇴 성공',
        data: null,
      );
    } catch (e) {
      print('사용자 탈퇴 오류: $e');
      return UserDeleteResponse(
        code: 500,
        status: 'error',
        message: '유저 탈퇴 실패: $e',
        data: null,
      );
    }
  }

  // 유저 로그아웃
  Future<UserLogoutResponse> logoutUser(String userId) async {
    try {
      final request = UserUpdateRequest(status: 'inactive');
      await FirebaseUtils.updateDocument('users', userId, request.toJson());
      return UserLogoutResponse(
        code: 200,
        status: 'success',
        message: '유저 로그아웃 성공',
        data: null,
      );
    } catch (e) {
      print('사용자 로그아웃 오류: $e');
      return UserLogoutResponse(
        code: 500,
        status: 'error',
        message: '유저 로그아웃 실패: $e',
        data: null,
      );
    }
  }

  // 유저 로그인
  Future<UserLoginResponse> loginUser(String userId) async {
    try {
      final request = UserUpdateRequest(status: 'active');
      await FirebaseUtils.updateDocument('users', userId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserLoginResponse(
          code: 200,
          status: 'success',
          message: '유저 로그인 성공',
          data: UserLoginData.fromJson(data), // UserLoginData 가정
        );
      }
      throw Exception('로그인된 사용자를 조회하지 못했습니다.');
    } catch (e) {
      print('사용자 로그인 오류: $e');
      return UserLoginResponse(
        code: 500,
        status: 'error',
        message: '유저 로그인 실패: $e',
        data: null,
      );
    }
  }
}
