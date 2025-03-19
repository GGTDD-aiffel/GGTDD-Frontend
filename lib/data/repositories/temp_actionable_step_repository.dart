import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_temp_actionable_step_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class TempActionableStepRepository {
  // 임시 실행 단계 생성
  Future<TempActionableStepResponse> createTempActionableStep(
      TempActionableStepCreateRequest request) async {
    try {
      final stepId = FirebaseFirestore.instance
          .collection('temp_actionable_steps')
          .doc()
          .id;
      final stepData = request.toJson()..['temp_actionable_step_id'] = stepId;
      await FirebaseUtils.writeDocument(
          'temp_actionable_steps', stepId, stepData);
      final data =
          await FirebaseUtils.fetchDocument('temp_actionable_steps', stepId);
      if (data != null) {
        return TempActionableStepResponse.fromJson(data);
      }
      throw Exception('생성된 임시 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('임시 실행 단계 생성 오류: $e');
      rethrow;
    }
  }

  // 임시 실행 단계 조회
  Future<TempActionableStepResponse?> fetchTempActionableStep(
      String stepId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('temp_actionable_steps', stepId);
      if (data != null) {
        return TempActionableStepResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('임시 실행 단계 조회 오류: $e');
      return null;
    }
  }

  // 임시 실행 단계 리스트 조회
  Future<TempActionableStepListResponse> fetchTempActionableSteps() async {
    try {
      final data = await FirebaseUtils.fetchCollection(
          collection: 'temp_actionable_steps');
      final steps = data
          .map((item) => TempActionableStepResponse.fromJson(item))
          .toList();
      return TempActionableStepListResponse(data: steps);
    } catch (e) {
      print('임시 실행 단계 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 임시 실행 단계 수정
  Future<TempActionableStepResponse> updateTempActionableStep(
      String stepId, TempActionableStepUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'temp_actionable_steps', stepId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('temp_actionable_steps', stepId);
      if (data != null) {
        return TempActionableStepResponse.fromJson(data);
      }
      throw Exception('수정된 임시 실행 단계를 조회하지 못했습니다.');
    } catch (e) {
      print('임시 실행 단계 수정 오류: $e');
      rethrow;
    }
  }

  // 임시 실행 단계 삭제
  Future<void> deleteTempActionableStep(String stepId) async {
    try {
      await FirebaseUtils.deleteDocument('temp_actionable_steps', stepId);
    } catch (e) {
      print('임시 실행 단계 삭제 오류: $e');
      rethrow;
    }
  }
}
