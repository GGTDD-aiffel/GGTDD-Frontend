import 'package:ggtdd_frontend/data/model/api_default_tag_model.dart';
import 'package:ggtdd_frontend/data/repositories/default_tag_repository.dart';

class DefaultTagService {
  final DefaultTagRepository _repository;

  DefaultTagService({required DefaultTagRepository repository})
      : _repository = repository;

  Future<DefaultTagCreateResponse> createDefaultTag(
      DefaultTagCreateRequest request) async {
    return await _repository.createDefaultTag(request);
  }

  Future<DefaultTagGetResponse> getDefaultTag(String tagId) async {
    return await _repository.fetchDefaultTag(tagId);
  }

  Future<DefaultTagListResponseDto> getDefaultTags() async {
    return await _repository.fetchDefaultTags();
  }

  Future<DefaultTagUpdateResponse> updateDefaultTag(
      String tagId, DefaultTagUpdateRequest request) async {
    return await _repository.updateDefaultTag(tagId, request);
  }

  Future<DefaultTagDeleteResponse> deleteDefaultTag(String tagId) async {
    return await _repository.deleteDefaultTag(tagId);
  }
}
