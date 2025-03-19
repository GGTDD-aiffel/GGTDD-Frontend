import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_recognition_model.dart';
import 'package:ggtdd_frontend/data/services/recognition_service.dart';

class RecognitionController extends ChangeNotifier {
  final RecognitionService _service;
  List<RecognitionResponse> _recognitions = [];
  RecognitionResponse? _recognition;
  bool _isLoading = false;

  List<RecognitionResponse> get recognitions => _recognitions;
  RecognitionResponse? get recognition => _recognition;
  bool get isLoading => _isLoading;

  RecognitionController({required RecognitionService service})
      : _service = service;

  Future<void> fetchRecognitions() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getRecognitions();
      _recognitions = response.data;
    } catch (e) {
      print('인식 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecognition(String recognitionId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _recognition = await _service.getRecognition(recognitionId);
    } catch (e) {
      print('인식 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateRecognition(
      String recognitionId, RecognitionUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _recognition = await _service.updateRecognition(recognitionId, request);
    } catch (e) {
      print('인식 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
