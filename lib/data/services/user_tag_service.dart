import 'package:ggtdd_frontend/data/model/api_user_tag_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_tag_repository.dart';

class UserTagService {
  final UserTagRepository _repository;

  UserTagService({required UserTagRepository repository})
      : _repository = repository;

  Future<UserTagResponse> createUserTag(UserTagCreateRequest request) async {
    return await _repository.createUserTag(request);
  }

  Future<UserTagResponse?> getUserTag(String tagId) async {
    return await _repository.fetchUserTag(tagId);
  }

  Future<UserTagListResponse> getUserTags() async {
    return await _repository.fetchUserTags();
  }

  Future<UserTagResponse> updateUserTag(
      String tagId, UserTagUpdateRequest request) async {
    return await _repository.updateUserTag(tagId, request);
  }

  Future<void> deleteUserTag(String tagId) async {
    await _repository.deleteUserTag(tagId);
  }
}
