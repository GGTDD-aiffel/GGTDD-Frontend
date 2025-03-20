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
      if (response.code == 200 && response.data != null) {
        _items = response.data!.data;
        _meta = response.data!.meta;
        print('인박스 리스트 조회 성공: ${response.message}');
      } else {
        print('인박스 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.getInbox(contentId);
      if (response.code == 200 && response.data != null) {
        _item = response.data!.inbox;
        print('인박스 조회 성공: ${response.message}');
      } else {
        print('인박스 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.updateInbox(contentId, request);
      if (response.code == 200 && response.data != null) {
        _item = response.data!.inbox;
        print('인박스 수정 성공: ${response.message}');
      } else {
        print('인박스 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('인박스 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
