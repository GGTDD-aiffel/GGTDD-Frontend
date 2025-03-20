import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_inbox_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/inbox_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class InboxRepository {
  Future<InboxCreateResponse> createInbox(InboxCreateRequest request) async {
    try {
      final contentId = FirebaseFirestore.instance.collection('inbox').doc().id;
      final inboxData = request.toJson();
      await FirebaseUtils.writeDocument('inbox', contentId, inboxData);
      final data = await FirebaseUtils.fetchDocument('inbox', contentId);
      if (data != null) {
        return InboxCreateResponse(
          code: 200,
          status: 'success',
          message: '인박스 생성 성공',
          data: InboxResponse.fromJson(data, docId: contentId),
        );
      }
      throw Exception('생성된 인박스를 조회하지 못했습니다.');
    } catch (e) {
      print('인박스 생성 오류: $e');
      return InboxCreateResponse(
        code: 500,
        status: 'error',
        message: '인박스 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<InboxGetResponse> fetchInbox(String contentId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('inbox', contentId);
      if (data != null) {
        return InboxGetResponse(
          code: 200,
          status: 'success',
          message: '인박스 조회 성공',
          data: InboxResponse.fromJson(data, docId: contentId),
        );
      }
      return InboxGetResponse(
        code: 404,
        status: 'not_found',
        message: '인박스를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('인박스 조회 오류: $e');
      return InboxGetResponse(
        code: 500,
        status: 'error',
        message: '인박스 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<InboxListResponseDto> fetchInboxes(
      {int page = 1, int limit = 10}) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('inbox')
          .orderBy('created_at', descending: true)
          .limit(limit)
          .get();
      final items = snapshot.docs.map((doc) {
        return Inbox.fromJson(doc.data(), docId: doc.id);
      }).toList();
      // 페이지네이션 메타데이터 (Firestore에서 전체 카운트는 별도 쿼리 필요)
      final totalItems = snapshot.docs.length; // 실제로는 전체 문서 수 조회 필요
      final totalPages = (totalItems / limit).ceil();
      return InboxListResponseDto(
        code: 200,
        status: 'success',
        message: '인박스 리스트 조회 성공',
        data: InboxListResponse(
          data: items,
          meta: PaginationMeta(
            currentPage: page,
            totalPages: totalPages,
            totalItems: totalItems,
            limit: limit,
          ),
        ),
      );
    } catch (e) {
      print('인박스 리스트 조회 오류: $e');
      return InboxListResponseDto(
        code: 500,
        status: 'error',
        message: '인박스 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<InboxUpdateResponse> updateInbox(
      String contentId, InboxUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument('inbox', contentId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('inbox', contentId);
      if (data != null) {
        return InboxUpdateResponse(
          code: 200,
          status: 'success',
          message: '인박스 수정 성공',
          data: InboxResponse.fromJson(data, docId: contentId),
        );
      }
      throw Exception('수정된 인박스를 조회하지 못했습니다.');
    } catch (e) {
      print('인박스 수정 오류: $e');
      return InboxUpdateResponse(
        code: 500,
        status: 'error',
        message: '인박스 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<InboxDeleteResponse> deleteInbox(String contentId) async {
    try {
      await FirebaseUtils.deleteDocument('inbox', contentId);
      return InboxDeleteResponse(
        code: 200,
        status: 'success',
        message: '인박스 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('인박스 삭제 오류: $e');
      return InboxDeleteResponse(
        code: 500,
        status: 'error',
        message: '인박스 삭제 실패: $e',
        data: null,
      );
    }
  }
}
