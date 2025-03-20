import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_context_tag_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/actionable_step_context_tag_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class ActionableStepContextTagRepository {
  Future<ActionableStepContextTagCreateResponse> createActionableStepContextTag(
      ActionableStepContextTagCreateRequest request) async {
    try {
      final tagId = FirebaseFirestore.instance
          .collection('actionable_step_context_tags')
          .doc()
          .id;
      final tagData = request.toJson();
      await FirebaseUtils.writeDocument(
          'actionable_step_context_tags', tagId, tagData);
      final data = await FirebaseUtils.fetchDocument(
          'actionable_step_context_tags', tagId);
      if (data != null) {
        return ActionableStepContextTagCreateResponse(
          code: 200,
          status: 'success',
          message: '실행 단계 맥락 태그 생성 성공',
          data: ActionableStepContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('생성된 실행 단계 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 맥락 태그 생성 오류: $e');
      return ActionableStepContextTagCreateResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 맥락 태그 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepContextTagGetResponse> fetchActionableStepContextTag(
      String tagId) async {
    try {
      final data = await FirebaseUtils.fetchDocument(
          'actionable_step_context_tags', tagId);
      if (data != null) {
        return ActionableStepContextTagGetResponse(
          code: 200,
          status: 'success',
          message: '실행 단계 맥락 태그 조회 성공',
          data: ActionableStepContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      return ActionableStepContextTagGetResponse(
        code: 404,
        status: 'not_found',
        message: '실행 단계 맥락 태그를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('실행 단계 맥락 태그 조회 오류: $e');
      return ActionableStepContextTagGetResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 맥락 태그 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepContextTagListResponseDto>
      fetchActionableStepContextTags() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('actionable_step_context_tags')
          .get();
      final tags = snapshot.docs.map((doc) {
        return ActionableStepContextTag.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return ActionableStepContextTagListResponseDto(
        code: 200,
        status: 'success',
        message: '실행 단계 맥락 태그 리스트 조회 성공',
        data: ActionableStepContextTagListResponse(tags: tags),
      );
    } catch (e) {
      print('실행 단계 맥락 태그 리스트 조회 오류: $e');
      return ActionableStepContextTagListResponseDto(
        code: 500,
        status: 'error',
        message: '실행 단계 맥락 태그 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepContextTagUpdateResponse> updateActionableStepContextTag(
      String tagId, ActionableStepContextTagUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'actionable_step_context_tags', tagId, request.toJson());
      final data = await FirebaseUtils.fetchDocument(
          'actionable_step_context_tags', tagId);
      if (data != null) {
        return ActionableStepContextTagUpdateResponse(
          code: 200,
          status: 'success',
          message: '실행 단계 맥락 태그 수정 성공',
          data: ActionableStepContextTagResponse.fromJson(data, docId: tagId),
        );
      }
      throw Exception('수정된 실행 단계 맥락 태그를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 맥락 태그 수정 오류: $e');
      return ActionableStepContextTagUpdateResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 맥락 태그 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepContextTagDeleteResponse> deleteActionableStepContextTag(
      String tagId) async {
    try {
      await FirebaseUtils.deleteDocument('actionable_step_context_tags', tagId);
      return ActionableStepContextTagDeleteResponse(
        code: 200,
        status: 'success',
        message: '실행 단계 맥락 태그 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('실행 단계 맥락 태그 삭제 오류: $e');
      return ActionableStepContextTagDeleteResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 맥락 태그 삭제 실패: $e',
        data: null,
      );
    }
  }
}
