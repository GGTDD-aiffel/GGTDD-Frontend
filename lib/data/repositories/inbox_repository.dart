import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_inbox_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/inbox_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class InboxRepository {
  // 인박스 생성
  Future<Inbox> createInbox(InboxCreateRequest request) async {
    try {
      final contentId = FirebaseFirestore.instance.collection('inbox').doc().id;
      final inboxData = request.toJson()..['content_id'] = contentId;
      await FirebaseUtils.writeDocument('inbox', contentId, inboxData);
      final data = await FirebaseUtils.fetchDocument('inbox', contentId);
      if (data != null) {
        return Inbox.fromJson(data);
      }
      throw Exception('생성된 인박스를 조회하지 못했습니다.');
    } catch (e) {
      print('인박스 생성 오류: $e');
      rethrow;
    }
  }

  // 인박스 조회
  Future<Inbox?> fetchInbox(String contentId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('inbox', contentId);
      if (data != null) {
        return Inbox.fromJson(data);
      }
      return null;
    } catch (e) {
      print('인박스 조회 오류: $e');
      return null;
    }
  }

  // 인박스 리스트 조회 (페이지네이션 포함)
  Future<InboxListResponse> fetchInboxes({int page = 1, int limit = 10}) async {
    try {
      final data = await FirebaseUtils.fetchCollection(
        collection: 'inbox',
        limit: limit,
        orderBy: 'created_at',
        descending: true,
      );
      final items = data.map((item) => Inbox.fromJson(item)).toList();
      // 페이지네이션 메타데이터는 임시로 가정 (Firestore에서 전체 카운트 별도 처리 필요)
      final totalItems = data.length; // 실제로는 전체 문서 수 조회 필요
      final totalPages = (totalItems / limit).ceil();
      return InboxListResponse(
        data: items,
        meta: PaginationMeta(
          currentPage: page,
          totalPages: totalPages,
          totalItems: totalItems,
          limit: limit,
        ),
      );
    } catch (e) {
      print('인박스 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 인박스 수정
  Future<Inbox> updateInbox(
      String contentId, InboxUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument('inbox', contentId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('inbox', contentId);
      if (data != null) {
        return Inbox.fromJson(data);
      }
      throw Exception('수정된 인박스를 조회하지 못했습니다.');
    } catch (e) {
      print('인박스 수정 오류: $e');
      rethrow;
    }
  }

  // 인박스 삭제
  Future<void> deleteInbox(String contentId) async {
    try {
      await FirebaseUtils.deleteDocument('inbox', contentId);
    } catch (e) {
      print('인박스 삭제 오류: $e');
      rethrow;
    }
  }
}
