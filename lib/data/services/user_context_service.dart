import 'package:ggtdd_frontend/data/model/api_user_context_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_context_repository.dart';

class UserContextService {
  final UserContextRepository _repository;

  UserContextService({required UserContextRepository repository})
      : _repository = repository;

  Future<UserContextCreateResponse> createUserContext(
      UserContextCreateRequest request) async {
    return await _repository.createUserContext(request);
  }

  Future<UserContextGetResponse> getUserContext(String contextId) async {
    return await _repository.fetchUserContext(contextId);
  }

  Future<UserContextListResponseDto> getUserContexts() async {
    return await _repository.fetchUserContexts();
  }

  Future<UserContextUpdateResponse> updateUserContext(
      String contextId, UserContextUpdateRequest request) async {
    return await _repository.updateUserContext(contextId, request);
  }

  Future<UserContextDeleteResponse> deleteUserContext(String contextId) async {
    return await _repository.deleteUserContext(contextId);
  }
}
