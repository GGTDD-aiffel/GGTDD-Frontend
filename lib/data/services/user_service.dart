import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_repository.dart';

class UserService {
  final UserRepository _repository;

  UserService({required UserRepository repository}) : _repository = repository;

  Future<UserCreateResponse> createUser(UserCreateRequest request) async {
    return await _repository.createUser(request);
  }

  Future<UserResponse> getUser(String userId) async {
    return await _repository.fetchUser(userId);
  }

  Future<UserUpdateResponse> updateUser(
      String userId, UserUpdateRequest request) async {
    return await _repository.updateUser(userId, request);
  }

  Future<UserDeleteResponse> deleteUser(String userId) async {
    return await _repository.deleteUser(userId);
  }

  Future<UserLogoutResponse> logoutUser(String userId) async {
    return await _repository.logoutUser(userId);
  }

  Future<UserLoginResponse> loginUser(String userId) async {
    return await _repository.loginUser(userId);
  }
}
