import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_context_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class ActionableStepContextTagRepository {
  // 실행 단계 맥락 태그 생성
  Future<ActionableStepContextTagResponse> createActionableStepContextTag(
      ActionableStepContextTagCreateRequest request) async {
    try {
      final tagId = FirebaseFirestore.instance
          .collection('actionable_step_context_tags')
          .doc()
          .id;
      final tagData = request.toJson()
        ..['actionable_step_context_tag_id'] = tagId;
      await FirebaseUtils.writeDocument(
          'actionable_step_context_tags', tagId, tagData);
      final data = await FirebaseUtils.fetchDocument(
          'actionable_step_context_tags', tagId);
      if (data != null) {
        return ActionableStepContextTagResponse.fromJson(data);
      }
      throw Exception('생성된 실행 단계 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 맥락 태그 생성 오류: $e');
      rethrow;
    }
  }

  // 실행 단계 맥락 태그 조회
  Future<ActionableStepContextTagResponse?> fetchActionableStepContextTag(
      String tagId) async {
    try {
      final data = await FirebaseUtils.fetchDocument(
          'actionable_step_context_tags', tagId);
      if (data != null) {
        return ActionableStepContextTagResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('실행 단계 맥락 태그 조회 오류: $e');
      return null;
    }
  }

  // 실행 단계 맥락 태그 리스트 조회
  Future<ActionableStepContextTagListResponse>
      fetchActionableStepContextTags() async {
    try {
      final data = await FirebaseUtils.fetchCollection(
          collection: 'actionable_step_context_tags');
      final tags = data
          .map((item) => ActionableStepContextTagResponse.fromJson(item))
          .toList();
      return ActionableStepContextTagListResponse(data: tags);
    } catch (e) {
      print('실행 단계 맥락 태그 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 실행 단계 맥락 태그 수정
  Future<ActionableStepContextTagResponse> updateActionableStepContextTag(
      String tagId, ActionableStepContextTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'actionable_step_context_tags', tagId, request.toJson());
      final data = await FirebaseUtils.fetchDocument(
          'actionable_step_context_tags', tagId);
      if (data != null) {
        return ActionableStepContextTagResponse.fromJson(data);
      }
      throw Exception('수정된 실행 단계 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 맥락 태그 수정 오류: $e');
      rethrow;
    }
  }

  // 실행 단계 맥락 태그 삭제
  Future<void> deleteActionableStepContextTag(String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('actionable_step_context_tags', tagId);
    } catch (e) {
      print('실행 단계 맥락 태그 삭제 오류: $e');
      rethrow;
    }
  }
}
