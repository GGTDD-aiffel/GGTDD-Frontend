import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class ActionableStepRepository {
  // 실행 단계 생성
  Future<ActionableStepResponse> createActionableStep(
      ActionableStepCreateRequest request) async {
    try {
      final stepId =
          FirebaseFirestore.instance.collection('actionable_steps').doc().id;
      final stepData = request.toJson()..['actionable_step_id'] = stepId;
      await FirebaseUtils.writeDocument('actionable_steps', stepId, stepData);
      final data =
          await FirebaseUtils.fetchDocument('actionable_steps', stepId);
      if (data != null) {
        return ActionableStepResponse.fromJson(data);
      }
      throw Exception('생성된 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 생성 오류: $e');
      rethrow;
    }
  }

  // 실행 단계 조회
  Future<ActionableStepResponse?> fetchActionableStep(String stepId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('actionable_steps', stepId);
      if (data != null) {
        return ActionableStepResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('실행 단계 조회 오류: $e');
      return null;
    }
  }

  // 실행 단계 리스트 조회 (페이지네이션 포함)
  Future<ActionableStepListResponse> fetchActionableSteps(
      {int page = 1, int limit = 10}) async {
    try {
      final data = await FirebaseUtils.fetchCollection(
        collection: 'actionable_steps',
        limit: limit,
        orderBy: 'created_at',
        descending: true,
      );
      final items =
          data.map((item) => ActionableStepResponse.fromJson(item)).toList();
      // 페이지네이션 메타데이터는 임시 처리 (Firestore에서 전체 카운트 별도 조회 필요)
      final totalItems = data.length; // 실제로는 전체 문서 수 필요
      final totalPages = (totalItems / limit).ceil();
      return ActionableStepListResponse(
        data: items,
        meta: PaginationMeta(
          currentPage: page,
          totalPages: totalPages,
          totalItems: totalItems,
          limit: limit,
        ),
      );
    } catch (e) {
      print('실행 단계 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 실행 단계 수정
  Future<ActionableStepResponse> updateActionableStep(
      String stepId, ActionableStepUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'actionable_steps', stepId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('actionable_steps', stepId);
      if (data != null) {
        return ActionableStepResponse.fromJson(data);
      }
      throw Exception('수정된 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 수정 오류: $e');
      rethrow;
    }
  }

  // 실행 단계 삭제
  Future<void> deleteActionableStep(String stepId) async {
    try {
      await FirebaseUtils.deleteDocument('actionable_steps', stepId);
    } catch (e) {
      print('실행 단계 삭제 오류: $e');
      rethrow;
    }
  }
}
