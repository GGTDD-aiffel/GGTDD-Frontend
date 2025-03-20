import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_recognition_model.dart';
import 'package:ggtdd_frontend/data/services/recognition_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/recognition_model.dart';

class RecognitionController extends ChangeNotifier {
  final RecognitionService _service;
  List<Recognition> _recognitions = [];
  Recognition? _recognition;
  bool _isLoading = false;

  List<Recognition> get recognitions => _recognitions;
  Recognition? get recognition => _recognition;
  bool get isLoading => _isLoading;

  RecognitionController({required RecognitionService service})
      : _service = service;

  Future<void> fetchRecognitions() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getRecognitions();
      if (response.code == 200 && response.data != null) {
        _recognitions = response.data!.recognitions;
        print('인식 리스트 조회 성공: ${response.message}');
      } else {
        print('인식 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.getRecognition(recognitionId);
      if (response.code == 200 && response.data != null) {
        _recognition = response.data!.recognition;
        print('인식 조회 성공: ${response.message}');
      } else {
        print('인식 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.updateRecognition(recognitionId, request);
      if (response.code == 200 && response.data != null) {
        _recognition = response.data!.recognition;
        print('인식 수정 성공: ${response.message}');
      } else {
        print('인식 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('인식 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
