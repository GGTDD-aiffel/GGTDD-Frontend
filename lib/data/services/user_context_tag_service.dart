import 'package:ggtdd_frontend/data/model/api_user_context_tag_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_context_tag_repository.dart';

class UserContextTagService {
  final UserContextTagRepository _repository;

  UserContextTagService({required UserContextTagRepository repository})
      : _repository = repository;

  Future<UserContextTagResponse> createUserContextTag(
      UserContextTagCreateRequest request) async {
    return await _repository.createUserContextTag(request);
  }

  Future<UserContextTagResponse?> getUserContextTag(String tagId) async {
    return await _repository.fetchUserContextTag(tagId);
  }

  Future<UserContextTagListResponse> getUserContextTags() async {
    return await _repository.fetchUserContextTags();
  }

  Future<UserContextTagResponse> updateUserContextTag(
      String tagId, UserContextTagUpdateRequest request) async {
    return await _repository.updateUserContextTag(tagId, request);
  }

  Future<void> deleteUserContextTag(String tagId) async {
    await _repository.deleteUserContextTag(tagId);
  }
}
