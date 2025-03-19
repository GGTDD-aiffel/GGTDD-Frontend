import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_default_context_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class DefaultContextRepository {
  // 기본 맥락 생성
  Future<DefaultContextResponse> createDefaultContext(
      DefaultContextCreateRequest request) async {
    try {
      final contextId =
          FirebaseFirestore.instance.collection('default_contexts').doc().id;
      final contextData = request.toJson()..['default_context_id'] = contextId;
      await FirebaseUtils.writeDocument(
          'default_contexts', contextId, contextData);
      final data =
          await FirebaseUtils.fetchDocument('default_contexts', contextId);
      if (data != null) {
        return DefaultContextResponse.fromJson(data);
      }
      throw Exception('생성된 기본 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('기본 맥락 생성 오류: $e');
      rethrow;
    }
  }

  // 기본 맥락 조회
  Future<DefaultContextResponse?> fetchDefaultContext(String contextId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('default_contexts', contextId);
      if (data != null) {
        return DefaultContextResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('기본 맥락 조회 오류: $e');
      return null;
    }
  }

  // 기본 맥락 리스트 조회
  Future<DefaultContextListResponse> fetchDefaultContexts() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'default_contexts');
      final contexts =
          data.map((item) => DefaultContextResponse.fromJson(item)).toList();
      return DefaultContextListResponse(data: contexts);
    } catch (e) {
      print('기본 맥락 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 기본 맥락 수정
  Future<DefaultContextResponse> updateDefaultContext(
      String contextId, DefaultContextUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'default_contexts', contextId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('default_contexts', contextId);
      if (data != null) {
        return DefaultContextResponse.fromJson(data);
      }
      throw Exception('수정된 기본 맥락을 조회하지 못했습니다.');
    } catch (e) {
      print('기본 맥락 수정 오류: $e');
      rethrow;
    }
  }

  // 기본 맥락 삭제
  Future<void> deleteDefaultContext(String contextId) async {
    try {
      await FirebaseUtils.deleteDocument('default_contexts', contextId);
    } catch (e) {
      print('기본 맥락 삭제 오류: $e');
      rethrow;
    }
  }
}
