import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_subtask_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class SubtaskRepository {
  // 서브태스크 생성
  Future<SubtaskResponse> createSubtask(SubtaskCreateRequest request) async {
    try {
      final subtaskId =
          FirebaseFirestore.instance.collection('subtasks').doc().id;
      final subtaskData = request.toJson()..['subtask_id'] = subtaskId;
      await FirebaseUtils.writeDocument('subtasks', subtaskId, subtaskData);
      final data = await FirebaseUtils.fetchDocument('subtasks', subtaskId);
      if (data != null) {
        return SubtaskResponse.fromJson(data);
      }
      throw Exception('생성된 서브태스크를 조회하지 못했습니다.');
    } catch (e) {
      print('서브태스크 생성 오류: $e');
      rethrow;
    }
  }

  // 서브태스크 조회
  Future<SubtaskResponse?> fetchSubtask(String subtaskId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('subtasks', subtaskId);
      if (data != null) {
        return SubtaskResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('서브태스크 조회 오류: $e');
      return null;
    }
  }

  // 서브태스크 리스트 조회
  Future<SubtaskListResponse> fetchSubtasks() async {
    try {
      final data = await FirebaseUtils.fetchCollection(collection: 'subtasks');
      final subtasks =
          data.map((item) => SubtaskResponse.fromJson(item)).toList();
      return SubtaskListResponse(data: subtasks);
    } catch (e) {
      print('서브태스크 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 서브태스크 수정
  Future<SubtaskResponse> updateSubtask(
      String subtaskId, SubtaskUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'subtasks', subtaskId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('subtasks', subtaskId);
      if (data != null) {
        return SubtaskResponse.fromJson(data);
      }
      throw Exception('수정된 서브태스크를 조회하지 못했습니다.');
    } catch (e) {
      print('서브태스크 수정 오류: $e');
      rethrow;
    }
  }

  // 서브태스크 삭제
  Future<void> deleteSubtask(String subtaskId) async {
    try {
      await FirebaseUtils.deleteDocument('subtasks', subtaskId);
    } catch (e) {
      print('서브태스크 삭제 오류: $e');
      rethrow;
    }
  }
}
