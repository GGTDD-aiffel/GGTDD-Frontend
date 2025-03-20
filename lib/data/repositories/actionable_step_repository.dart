import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_actionable_step_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/actionable_step_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class ActionableStepRepository {
  Future<ActionableStepCreateResponse> createActionableStep(
      ActionableStepCreateRequest request) async {
    try {
      final stepId =
          FirebaseFirestore.instance.collection('actionable_steps').doc().id;
      final stepData = request.toJson();
      await FirebaseUtils.writeDocument('actionable_steps', stepId, stepData);
      final data =
          await FirebaseUtils.fetchDocument('actionable_steps', stepId);
      if (data != null) {
        return ActionableStepCreateResponse(
          code: 200,
          status: 'success',
          message: '실행 단계 생성 성공',
          data: ActionableStepResponse.fromJson(data, docId: stepId),
        );
      }
      throw Exception('생성된 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 생성 오류: $e');
      return ActionableStepCreateResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepGetResponse> fetchActionableStep(String stepId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('actionable_steps', stepId);
      if (data != null) {
        return ActionableStepGetResponse(
          code: 200,
          status: 'success',
          message: '실행 단계 조회 성공',
          data: ActionableStepResponse.fromJson(data, docId: stepId),
        );
      }
      return ActionableStepGetResponse(
        code: 404,
        status: 'not_found',
        message: '실행 단계를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('실행 단계 조회 오류: $e');
      return ActionableStepGetResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepListResponseDto> fetchActionableSteps(
      {int page = 1, int limit = 10}) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('actionable_steps')
          .orderBy('created_at', descending: true)
          .limit(limit)
          .get();
      final steps = snapshot.docs.map((doc) {
        return ActionableStep.fromJson(doc.data(), docId: doc.id);
      }).toList();
      // 페이지네이션 메타데이터 (Firestore에서 전체 카운트는 별도 쿼리 필요)
      final totalItems = snapshot.docs.length; // 실제로는 전체 문서 수 조회 필요
      final totalPages = (totalItems / limit).ceil();
      return ActionableStepListResponseDto(
        code: 200,
        status: 'success',
        message: '실행 단계 리스트 조회 성공',
        data: ActionableStepListResponse(
          steps: steps,
          meta: PaginationMeta(
            currentPage: page,
            totalPages: totalPages,
            totalItems: totalItems,
            limit: limit,
          ),
        ),
      );
    } catch (e) {
      print('실행 단계 리스트 조회 오류: $e');
      return ActionableStepListResponseDto(
        code: 500,
        status: 'error',
        message: '실행 단계 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepUpdateResponse> updateActionableStep(
      String stepId, ActionableStepUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'actionable_steps', stepId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('actionable_steps', stepId);
      if (data != null) {
        return ActionableStepUpdateResponse(
          code: 200,
          status: 'success',
          message: '실행 단계 수정 성공',
          data: ActionableStepResponse.fromJson(data, docId: stepId),
        );
      }
      throw Exception('수정된 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('실행 단계 수정 오류: $e');
      return ActionableStepUpdateResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<ActionableStepDeleteResponse> deleteActionableStep(
      String stepId) async {
    try {
      await FirebaseUtils.deleteDocument('actionable_steps', stepId);
      return ActionableStepDeleteResponse(
        code: 200,
        status: 'success',
        message: '실행 단계 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('실행 단계 삭제 오류: $e');
      return ActionableStepDeleteResponse(
        code: 500,
        status: 'error',
        message: '실행 단계 삭제 실패: $e',
        data: null,
      );
    }
  }
}
