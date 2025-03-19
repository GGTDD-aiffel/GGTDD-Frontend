import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserRepository {
  // 유저 생성 (Firebase Auth 인증 후 호출)
  Future<UserGetResponse> createUser(UserCreateRequest request) async {
    try {
      // UID로 기존 사용자 확인
      final existingUsers = await FirebaseUtils.fetchCollection(
        collection: 'users',
        whereConditions: {'uid': request.uid},
      );
      if (existingUsers.isNotEmpty) {
        throw Exception('UID ${request.uid}로 이미 등록된 사용자가 있습니다.');
      }

      // Firestore 문서 ID로 userId 자동 생성
      final userId = FirebaseFirestore.instance.collection('users').doc().id;
      final userData = request.toJson();
      await FirebaseUtils.writeDocument('users', userId, userData);

      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserGetResponse.fromJson(data);
      }
      throw Exception('생성된 사용자를 조회하지 못했습니다.');
    } catch (e) {
      print('사용자 생성 오류: $e');
      rethrow;
    }
  }

  // 유저 조회 (문서 ID로 조회)
  Future<UserGetResponse?> fetchUser(String userId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserGetResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('사용자 조회 오류: $e');
      return null;
    }
  }

  // 유저 수정
  Future<UserGetResponse> updateUser(
      String userId, UserUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument('users', userId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserGetResponse.fromJson(data);
      }
      throw Exception('수정된 사용자를 조회하지 못했습니다.');
    } catch (e) {
      print('사용자 수정 오류: $e');
      rethrow;
    }
  }

  // 유저 탈퇴
  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseUtils.deleteDocument('users', userId);
    } catch (e) {
      print('사용자 탈퇴 오류: $e');
      rethrow;
    }
  }

  // 유저 로그아웃 (상태만 업데이트)
  Future<void> logoutUser(String userId) async {
    try {
      final request = UserUpdateRequest(status: 'inactive');
      await FirebaseUtils.updateDocument('users', userId, request.toJson());
    } catch (e) {
      print('사용자 로그아웃 오류: $e');
      rethrow;
    }
  }

  // 유저 로그인 (상태만 active로 업데이트)
  Future<UserGetResponse> loginUser(String userId) async {
    try {
      final request = UserUpdateRequest(status: 'active');
      await FirebaseUtils.updateDocument('users', userId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('users', userId);
      if (data != null) {
        return UserGetResponse.fromJson(data);
      }
      throw Exception('로그인된 사용자를 조회하지 못했습니다.');
    } catch (e) {
      print('사용자 로그인 오류: $e');
      rethrow;
    }
  }
}
