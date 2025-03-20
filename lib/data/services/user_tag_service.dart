import 'package:ggtdd_frontend/data/model/api_user_tag_model.dart';
import 'package:ggtdd_frontend/data/repositories/user_tag_repository.dart';

class UserTagService {
  final UserTagRepository _repository;

  UserTagService({required UserTagRepository repository})
      : _repository = repository;

  Future<UserTagCreateResponse> createUserTag(
      UserTagCreateRequest request) async {
    return await _repository.createUserTag(request);
  }

  Future<UserTagGetResponse> getUserTag(String tagId) async {
    return await _repository.fetchUserTag(tagId);
  }

  Future<UserTagListResponseDto> getUserTags() async {
    return await _repository.fetchUserTags();
  }

  Future<UserTagUpdateResponse> updateUserTag(
      String tagId, UserTagUpdateRequest request) async {
    return await _repository.updateUserTag(tagId, request);
  }

  Future<UserTagDeleteResponse> deleteUserTag(String tagId) async {
    return await _repository.deleteUserTag(tagId);
  }
}
