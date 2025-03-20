import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_default_context_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_context_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class DefaultContextRepository {
  Future<DefaultContextCreateResponse> createDefaultContext(
      DefaultContextCreateRequest request) async {
    try {
      final contextId =
          FirebaseFirestore.instance.collection('default_contexts').doc().id;
      final contextData = request.toJson();
      await FirebaseUtils.writeDocument(
          'default_contexts', contextId, contextData);
      final data =
          await FirebaseUtils.fetchDocument('default_contexts', contextId);
      if (data != null) {
        return DefaultContextCreateResponse(
          code: 200,
          status: 'success',
          message: '기본 맥락 생성 성공',
          data: DefaultContextResponse.fromJson(data, docId: contextId),
        );
      }
      throw Exception('생성된 기본 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('기본 맥락 생성 오류: $e');
      return DefaultContextCreateResponse(
        code: 500,
        status: 'error',
        message: '기본 맥락 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultContextGetResponse> fetchDefaultContext(
      String contextId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('default_contexts', contextId);
      if (data != null) {
        return DefaultContextGetResponse(
          code: 200,
          status: 'success',
          message: '기본 맥락 조회 성공',
          data: DefaultContextResponse.fromJson(data, docId: contextId),
        );
      }
      return DefaultContextGetResponse(
        code: 404,
        status: 'not_found',
        message: '기본 맥락을 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('기본 맥락 조회 오류: $e');
      return DefaultContextGetResponse(
        code: 500,
        status: 'error',
        message: '기본 맥락 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultContextListResponseDto> fetchDefaultContexts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('default_contexts').get();
      final contexts = snapshot.docs.map((doc) {
        return DefaultContext.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return DefaultContextListResponseDto(
        code: 200,
        status: 'success',
        message: '기본 맥락 리스트 조회 성공',
        data: DefaultContextListResponse(contexts: contexts),
      );
    } catch (e) {
      print('기본 맥락 리스트 조회 오류: $e');
      return DefaultContextListResponseDto(
        code: 500,
        status: 'error',
        message: '기본 맥락 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultContextUpdateResponse> updateDefaultContext(
      String contextId, DefaultContextUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'default_contexts', contextId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('default_contexts', contextId);
      if (data != null) {
        return DefaultContextUpdateResponse(
          code: 200,
          status: 'success',
          message: '기본 맥락 수정 성공',
          data: DefaultContextResponse.fromJson(data, docId: contextId),
        );
      }
      throw Exception('수정된 기본 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('기본 맥락 수정 오류: $e');
      return DefaultContextUpdateResponse(
        code: 500,
        status: 'error',
        message: '기본 맥락 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultContextDeleteResponse> deleteDefaultContext(
      String contextId) async {
    try {
      await FirebaseUtils.deleteDocument('default_contexts', contextId);
      return DefaultContextDeleteResponse(
        code: 200,
        status: 'success',
        message: '기본 맥락 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('기본 맥락 삭제 오류: $e');
      return DefaultContextDeleteResponse(
        code: 500,
        status: 'error',
        message: '기본 맥락 삭제 실패: $e',
        data: null,
      );
    }
  }
}
