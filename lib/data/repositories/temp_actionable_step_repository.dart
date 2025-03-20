import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_temp_actionable_step_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/temp_actionable_step_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class TempActionableStepRepository {
  Future<TempActionableStepCreateResponse> createTempActionableStep(
      TempActionableStepCreateRequest request) async {
    try {
      final stepId = FirebaseFirestore.instance
          .collection('temp_actionable_steps')
          .doc()
          .id;
      final stepData = request.toJson();
      await FirebaseUtils.writeDocument(
          'temp_actionable_steps', stepId, stepData);
      final data =
          await FirebaseUtils.fetchDocument('temp_actionable_steps', stepId);
      if (data != null) {
        return TempActionableStepCreateResponse(
          code: 200,
          status: 'success',
          message: '임시 실행 단계 생성 성공',
          data: TempActionableStepResponse.fromJson(data, docId: stepId),
        );
      }
      throw Exception('생성된 임시 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('임시 실행 단계 생성 오류: $e');
      return TempActionableStepCreateResponse(
        code: 500,
        status: 'error',
        message: '임시 실행 단계 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<TempActionableStepGetResponse> fetchTempActionableStep(
      String stepId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('temp_actionable_steps', stepId);
      if (data != null) {
        return TempActionableStepGetResponse(
          code: 200,
          status: 'success',
          message: '임시 실행 단계 조회 성공',
          data: TempActionableStepResponse.fromJson(data, docId: stepId),
        );
      }
      return TempActionableStepGetResponse(
        code: 404,
        status: 'not_found',
        message: '임시 실행 단계를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('임시 실행 단계 조회 오류: $e');
      return TempActionableStepGetResponse(
        code: 500,
        status: 'error',
        message: '임시 실행 단계 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<TempActionableStepListResponseDto> fetchTempActionableSteps() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('temp_actionable_steps')
          .get();
      final steps = snapshot.docs.map((doc) {
        return TempActionableStep.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return TempActionableStepListResponseDto(
        code: 200,
        status: 'success',
        message: '임시 실행 단계 리스트 조회 성공',
        data: TempActionableStepListResponse(steps: steps),
      );
    } catch (e) {
      print('임시 실행 단계 리스트 조회 오류: $e');
      return TempActionableStepListResponseDto(
        code: 500,
        status: 'error',
        message: '임시 실행 단계 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<TempActionableStepUpdateResponse> updateTempActionableStep(
      String stepId, TempActionableStepUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'temp_actionable_steps', stepId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('temp_actionable_steps', stepId);
      if (data != null) {
        return TempActionableStepUpdateResponse(
          code: 200,
          status: 'success',
          message: '임시 실행 단계 수정 성공',
          data: TempActionableStepResponse.fromJson(data, docId: stepId),
        );
      }
      throw Exception('수정된 임시 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('임시 실행 단계 수정 오류: $e');
      return TempActionableStepUpdateResponse(
        code: 500,
        status: 'error',
        message: '임시 실행 단계 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<TempActionableStepDeleteResponse> deleteTempActionableStep(
      String stepId) async {
    try {
      await FirebaseUtils.deleteDocument('temp_actionable_steps', stepId);
      return TempActionableStepDeleteResponse(
        code: 200,
        status: 'success',
        message: '임시 실행 단계 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('임시 실행 단계 삭제 오류: $e');
      return TempActionableStepDeleteResponse(
        code: 500,
        status: 'error',
        message: '임시 실행 단계 삭제 실패: $e',
        data: null,
      );
    }
  }
}
