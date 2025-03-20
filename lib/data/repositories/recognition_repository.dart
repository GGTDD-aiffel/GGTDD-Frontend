import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_recognition_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/recognition_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class RecognitionRepository {
  Future<RecognitionCreateResponse> createRecognition(
      RecognitionCreateRequest request) async {
    try {
      final recognitionId =
          FirebaseFirestore.instance.collection('recognitions').doc().id;
      final recognitionData = request.toJson();
      await FirebaseUtils.writeDocument(
          'recognitions', recognitionId, recognitionData);
      final data =
          await FirebaseUtils.fetchDocument('recognitions', recognitionId);
      if (data != null) {
        return RecognitionCreateResponse(
          code: 200,
          status: 'success',
          message: '인식 생성 성공',
          data: RecognitionResponse.fromJson(data, docId: recognitionId),
        );
      }
      throw Exception('생성된 인식을 조회하지 못했습니다.');
    } catch (e) {
      print('인식 생성 오류: $e');
      return RecognitionCreateResponse(
        code: 500,
        status: 'error',
        message: '인식 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<RecognitionGetResponse> fetchRecognition(String recognitionId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('recognitions', recognitionId);
      if (data != null) {
        return RecognitionGetResponse(
          code: 200,
          status: 'success',
          message: '인식 조회 성공',
          data: RecognitionResponse.fromJson(data, docId: recognitionId),
        );
      }
      return RecognitionGetResponse(
        code: 404,
        status: 'not_found',
        message: '인식을 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('인식 조회 오류: $e');
      return RecognitionGetResponse(
        code: 500,
        status: 'error',
        message: '인식 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<RecognitionListResponseDto> fetchRecognitions() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('recognitions').get();
      final recognitions = snapshot.docs.map((doc) {
        return Recognition.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return RecognitionListResponseDto(
        code: 200,
        status: 'success',
        message: '인식 리스트 조회 성공',
        data: RecognitionListResponse(recognitions: recognitions),
      );
    } catch (e) {
      print('인식 리스트 조회 오류: $e');
      return RecognitionListResponseDto(
        code: 500,
        status: 'error',
        message: '인식 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<RecognitionUpdateResponse> updateRecognition(
      String recognitionId, RecognitionUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'recognitions', recognitionId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('recognitions', recognitionId);
      if (data != null) {
        return RecognitionUpdateResponse(
          code: 200,
          status: 'success',
          message: '인식 수정 성공',
          data: RecognitionResponse.fromJson(data, docId: recognitionId),
        );
      }
      throw Exception('수정된 인식을 조회하지 못했습니다.');
    } catch (e) {
      print('인식 수정 오류: $e');
      return RecognitionUpdateResponse(
        code: 500,
        status: 'error',
        message: '인식 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<RecognitionDeleteResponse> deleteRecognition(
      String recognitionId) async {
    try {
      await FirebaseUtils.deleteDocument('recognitions', recognitionId);
      return RecognitionDeleteResponse(
        code: 200,
        status: 'success',
        message: '인식 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('인식 삭제 오류: $e');
      return RecognitionDeleteResponse(
        code: 500,
        status: 'error',
        message: '인식 삭제 실패: $e',
        data: null,
      );
    }
  }
}
