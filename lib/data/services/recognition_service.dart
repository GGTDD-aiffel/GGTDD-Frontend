import 'package:ggtdd_frontend/data/model/api_recognition_model.dart';
import 'package:ggtdd_frontend/data/repositories/recognition_repository.dart';

class RecognitionService {
  final RecognitionRepository _repository;

  RecognitionService({required RecognitionRepository repository})
      : _repository = repository;

  Future<RecognitionResponse> createRecognition(
      RecognitionCreateRequest request) async {
    return await _repository.createRecognition(request);
  }

  Future<RecognitionResponse?> getRecognition(String recognitionId) async {
    return await _repository.fetchRecognition(recognitionId);
  }

  Future<RecognitionListResponse> getRecognitions() async {
    return await _repository.fetchRecognitions();
  }

  Future<RecognitionResponse> updateRecognition(
      String recognitionId, RecognitionUpdateRequest request) async {
    return await _repository.updateRecognition(recognitionId, request);
  }

  Future<void> deleteRecognition(String recognitionId) async {
    await _repository.deleteRecognition(recognitionId);
  }
}
