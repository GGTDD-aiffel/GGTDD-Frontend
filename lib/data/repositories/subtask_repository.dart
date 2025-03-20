import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_subtask_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/sub_task_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class SubtaskRepository {
  Future<SubtaskCreateResponse> createSubtask(
      SubtaskCreateRequest request) async {
    try {
      final subtaskId =
          FirebaseFirestore.instance.collection('subtasks').doc().id;
      final subtaskData = request.toJson();
      await FirebaseUtils.writeDocument('subtasks', subtaskId, subtaskData);
      final data = await FirebaseUtils.fetchDocument('subtasks', subtaskId);
      if (data != null) {
        return SubtaskCreateResponse(
          code: 200,
          status: 'success',
          message: '서브태스크 생성 성공',
          data: SubtaskResponse.fromJson(data, docId: subtaskId),
        );
      }
      throw Exception('생성된 서브태스크를 조회하지 못했습니다.');
    } catch (e) {
      print('서브태스크 생성 오류: $e');
      return SubtaskCreateResponse(
        code: 500,
        status: 'error',
        message: '서브태스크 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<SubtaskGetResponse> fetchSubtask(String subtaskId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('subtasks', subtaskId);
      if (data != null) {
        return SubtaskGetResponse(
          code: 200,
          status: 'success',
          message: '서브태스크 조회 성공',
          data: SubtaskResponse.fromJson(data, docId: subtaskId),
        );
      }
      return SubtaskGetResponse(
        code: 404,
        status: 'not_found',
        message: '서브태스크를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('서브태스크 조회 오류: $e');
      return SubtaskGetResponse(
        code: 500,
        status: 'error',
        message: '서브태스크 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<SubtaskListResponseDto> fetchSubtasks() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('subtasks').get();
      final subtasks = snapshot.docs.map((doc) {
        return Subtask.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return SubtaskListResponseDto(
        code: 200,
        status: 'success',
        message: '서브태스크 리스트 조회 성공',
        data: SubtaskListResponse(subtasks: subtasks),
      );
    } catch (e) {
      print('서브태스크 리스트 조회 오류: $e');
      return SubtaskListResponseDto(
        code: 500,
        status: 'error',
        message: '서브태스크 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<SubtaskUpdateResponse> updateSubtask(
      String subtaskId, SubtaskUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'subtasks', subtaskId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('subtasks', subtaskId);
      if (data != null) {
        return SubtaskUpdateResponse(
          code: 200,
          status: 'success',
          message: '서브태스크 수정 성공',
          data: SubtaskResponse.fromJson(data, docId: subtaskId),
        );
      }
      throw Exception('수정된 서브태스크를 조회하지 못했습니다.');
    } catch (e) {
      print('서브태스크 수정 오류: $e');
      return SubtaskUpdateResponse(
        code: 500,
        status: 'error',
        message: '서브태스크 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<SubtaskDeleteResponse> deleteSubtask(String subtaskId) async {
    try {
      await FirebaseUtils.deleteDocument('subtasks', subtaskId);
      return SubtaskDeleteResponse(
        code: 200,
        status: 'success',
        message: '서브태스크 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('서브태스크 삭제 오류: $e');
      return SubtaskDeleteResponse(
        code: 500,
        status: 'error',
        message: '서브태스크 삭제 실패: $e',
        data: null,
      );
    }
  }
}
