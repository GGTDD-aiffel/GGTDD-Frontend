import 'package:ggtdd_frontend/data/model/api_inbox_model.dart';
import 'package:ggtdd_frontend/data/repositories/inbox_repository.dart';
import 'package:ggtdd_frontend/ui/domain/models/inbox_model.dart';

class InboxService {
  final InboxRepository _repository;

  InboxService({required InboxRepository repository})
      : _repository = repository;

  Future<Inbox> createInbox(InboxCreateRequest request) async {
    return await _repository.createInbox(request);
  }

  Future<Inbox?> getInbox(String contentId) async {
    return await _repository.fetchInbox(contentId);
  }

  Future<InboxListResponse> getInboxes({int page = 1, int limit = 10}) async {
    return await _repository.fetchInboxes(page: page, limit: limit);
  }

  Future<Inbox> updateInbox(
      String contentId, InboxUpdateRequest request) async {
    return await _repository.updateInbox(contentId, request);
  }

  Future<void> deleteInbox(String contentId) async {
    await _repository.deleteInbox(contentId);
  }
}
