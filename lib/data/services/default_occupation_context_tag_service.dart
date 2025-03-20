import 'package:ggtdd_frontend/data/model/api_default_occupation_context_tag_model.dart';
import 'package:ggtdd_frontend/data/repositories/default_occupation_context_tag_repository.dart';

class DefaultOccupationContextTagService {
  final DefaultOccupationContextTagRepository _repository;

  DefaultOccupationContextTagService(
      {required DefaultOccupationContextTagRepository repository})
      : _repository = repository;

  Future<DefaultOccupationContextTagCreateResponse>
      createDefaultOccupationContextTag(
          DefaultOccupationContextTagCreateRequest request) async {
    return await _repository.createDefaultOccupationContextTag(request);
  }

  Future<DefaultOccupationContextTagGetResponse> getDefaultOccupationContextTag(
      String tagId) async {
    return await _repository.fetchDefaultOccupationContextTag(tagId);
  }

  Future<DefaultOccupationContextTagListResponseDto>
      getDefaultOccupationContextTags() async {
    return await _repository.fetchDefaultOccupationContextTags();
  }

  Future<DefaultOccupationContextTagUpdateResponse>
      updateDefaultOccupationContextTag(String tagId,
          DefaultOccupationContextTagUpdateRequest request) async {
    return await _repository.updateDefaultOccupationContextTag(tagId, request);
  }

  Future<DefaultOccupationContextTagDeleteResponse>
      deleteDefaultOccupationContextTag(String tagId) async {
    return await _repository.deleteDefaultOccupationContextTag(tagId);
  }
}
