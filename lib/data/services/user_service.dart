import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_repository.dart';

class UserService {
  final UserRepository _repository;

  UserService({required UserRepository repository}) : _repository = repository;

  // 유저 생성
  Future<UserGetResponse> createUser(UserCreateRequest request) async {
    return await _repository.createUser(request);
  }

  // 유저 조회
  Future<UserGetResponse?> getUser(String userId) async {
    return await _repository.fetchUser(userId);
  }

  // 유저 수정
  Future<UserGetResponse> updateUser(
      String userId, UserUpdateRequest request) async {
    return await _repository.updateUser(userId, request);
  }

  // 유저 탈퇴
  Future<void> deleteUser(String userId) async {
    await _repository.deleteUser(userId);
  }

  // 유저 로그아웃
  Future<void> logoutUser(String userId) async {
    await _repository.logoutUser(userId);
  }

  // 유저 로그인 (상태 업데이트)
  Future<UserGetResponse> loginUser(String userId) async {
    return await _repository.loginUser(userId);
  }
}
