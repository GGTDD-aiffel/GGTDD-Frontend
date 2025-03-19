import 'package:ggtdd_frontend/data/model/api_default_context_model.dart';
import 'package:ggtdd_frontend/data/repositories/default_context_repository.dart';

class DefaultContextService {
  final DefaultContextRepository _repository;

  DefaultContextService({required DefaultContextRepository repository})
      : _repository = repository;

  Future<DefaultContextResponse> createDefaultContext(
      DefaultContextCreateRequest request) async {
    return await _repository.createDefaultContext(request);
  }

  Future<DefaultContextResponse?> getDefaultContext(String contextId) async {
    return await _repository.fetchDefaultContext(contextId);
  }

  Future<DefaultContextListResponse> getDefaultContexts() async {
    return await _repository.fetchDefaultContexts();
  }

  Future<DefaultContextResponse> updateDefaultContext(
      String contextId, DefaultContextUpdateRequest request) async {
    return await _repository.updateDefaultContext(contextId, request);
  }

  Future<void> deleteDefaultContext(String contextId) async {
    await _repository.deleteDefaultContext(contextId);
  }
}
