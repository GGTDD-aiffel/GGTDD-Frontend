import 'package:ggtdd_frontend/data/model/api_inbox_model.dart';
import 'package:ggtdd_frontend/data/repositories/inbox_repository.dart';

class InboxService {
  final InboxRepository _repository;

  InboxService({required InboxRepository repository})
      : _repository = repository;

  Future<InboxCreateResponse> createInbox(InboxCreateRequest request) async {
    return await _repository.createInbox(request);
  }

  Future<InboxGetResponse> getInbox(String contentId) async {
    return await _repository.fetchInbox(contentId);
  }

  Future<InboxListResponseDto> getInboxes(
      {int page = 1, int limit = 10}) async {
    return await _repository.fetchInboxes(page: page, limit: limit);
  }

  Future<InboxUpdateResponse> updateInbox(
      String contentId, InboxUpdateRequest request) async {
    return await _repository.updateInbox(contentId, request);
  }

  Future<InboxDeleteResponse> deleteInbox(String contentId) async {
    return await _repository.deleteInbox(contentId);
  }
}
