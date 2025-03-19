import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_inbox_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/data/services/inbox_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/inbox_model.dart';

class InboxController extends ChangeNotifier {
  final InboxService _service;
  List<Inbox> _items = [];
  Inbox? _item;
  PaginationMeta? _meta;
  bool _isLoading = false;

  List<Inbox> get items => _items;
  Inbox? get item => _item;
  PaginationMeta? get meta => _meta;
  bool get isLoading => _isLoading;

  InboxController({required InboxService service}) : _service = service;

  Future<void> fetchInboxes({int page = 1, int limit = 10}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getInboxes(page: page, limit: limit);
      _items = response.data;
      _meta = response.meta;
    } catch (e) {
      print('인박스 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchInbox(String contentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _item = await _service.getInbox(contentId);
    } catch (e) {
      print('인박스 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateInbox(String contentId, InboxUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _item = await _service.updateInbox(contentId, request);
    } catch (e) {
      print('인박스 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
