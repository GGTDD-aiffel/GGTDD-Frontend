import 'package:ggtdd_frontend/data/model/api_default_context_model.dart';
import 'package:ggtdd_frontend/data/repositories/default_context_repository.dart';

class DefaultContextService {
  final DefaultContextRepository _repository;

  DefaultContextService({required DefaultContextRepository repository})
      : _repository = repository;

  Future<DefaultContextCreateResponse> createDefaultContext(
      DefaultContextCreateRequest request) async {
    return await _repository.createDefaultContext(request);
  }

  Future<DefaultContextGetResponse> getDefaultContext(String contextId) async {
    return await _repository.fetchDefaultContext(contextId);
  }

  Future<DefaultContextListResponseDto> getDefaultContexts() async {
    return await _repository.fetchDefaultContexts();
  }

  Future<DefaultContextUpdateResponse> updateDefaultContext(
      String contextId, DefaultContextUpdateRequest request) async {
    return await _repository.updateDefaultContext(contextId, request);
  }

  Future<DefaultContextDeleteResponse> deleteDefaultContext(
      String contextId) async {
    return await _repository.deleteDefaultContext(contextId);
  }
}
