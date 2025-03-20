import 'package:ggtdd_frontend/data/model/api_recognition_model.dart';
import 'package:ggtdd_frontend/data/repositories/recognition_repository.dart';

class RecognitionService {
  final RecognitionRepository _repository;

  RecognitionService({required RecognitionRepository repository})
      : _repository = repository;

  Future<RecognitionCreateResponse> createRecognition(
      RecognitionCreateRequest request) async {
    return await _repository.createRecognition(request);
  }

  Future<RecognitionGetResponse> getRecognition(String recognitionId) async {
    return await _repository.fetchRecognition(recognitionId);
  }

  Future<RecognitionListResponseDto> getRecognitions() async {
    return await _repository.fetchRecognitions();
  }

  Future<RecognitionUpdateResponse> updateRecognition(
      String recognitionId, RecognitionUpdateRequest request) async {
    return await _repository.updateRecognition(recognitionId, request);
  }

  Future<RecognitionDeleteResponse> deleteRecognition(
      String recognitionId) async {
    return await _repository.deleteRecognition(recognitionId);
  }
}
