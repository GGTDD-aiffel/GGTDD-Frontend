import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_recognition_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class RecognitionRepository {
  // 인식 생성
  Future<RecognitionResponse> createRecognition(
      RecognitionCreateRequest request) async {
    try {
      final recognitionId =
          FirebaseFirestore.instance.collection('recognitions').doc().id;
      final recognitionData = request.toJson()
        ..['recognition_id'] = recognitionId;
      await FirebaseUtils.writeDocument(
          'recognitions', recognitionId, recognitionData);
      final data =
          await FirebaseUtils.fetchDocument('recognitions', recognitionId);
      if (data != null) {
        return RecognitionResponse.fromJson(data);
      }
      throw Exception('생성된 인식을 조회하지 못했습니다.');
    } catch (e) {
      print('인식 생성 오류: $e');
      rethrow;
    }
  }

  // 인식 조회
  Future<RecognitionResponse?> fetchRecognition(String recognitionId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('recognitions', recognitionId);
      if (data != null) {
        return RecognitionResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('인식 조회 오류: $e');
      return null;
    }
  }

  // 인식 리스트 조회
  Future<RecognitionListResponse> fetchRecognitions() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'recognitions');
      final recognitions =
          data.map((item) => RecognitionResponse.fromJson(item)).toList();
      return RecognitionListResponse(data: recognitions);
    } catch (e) {
      print('인식 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 인식 수정
  Future<RecognitionResponse> updateRecognition(
      String recognitionId, RecognitionUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'recognitions', recognitionId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('recognitions', recognitionId);
      if (data != null) {
        return RecognitionResponse.fromJson(data);
      }
      throw Exception('수정된 인식을 조회하지 못했습니다.');
    } catch (e) {
      print('인식 수정 오류: $e');
      rethrow;
    }
  }

  // 인식 삭제
  Future<void> deleteRecognition(String recognitionId) async {
    try {
      await FirebaseUtils.deleteDocument('recognitions', recognitionId);
    } catch (e) {
      print('인식 삭제 오류: $e');
      rethrow;
    }
  }
}
