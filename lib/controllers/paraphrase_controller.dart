import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_paraphrase_model.dart';
import 'package:ggtdd_frontend/data/services/paraphrase_service.dart';

class ParaphraseController extends ChangeNotifier {
  final ParaphraseService _service;
  List<ParaphraseResponse> _paraphrases = [];
  ParaphraseResponse? _paraphrase;
  bool _isLoading = false;

  List<ParaphraseResponse> get paraphrases => _paraphrases;
  ParaphraseResponse? get paraphrase => _paraphrase;
  bool get isLoading => _isLoading;

  ParaphraseController({required ParaphraseService service})
      : _service = service;

  Future<void> fetchParaphrases() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getParaphrases();
      _paraphrases = response.data;
    } catch (e) {
      print('재구성 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchParaphrase(String paraphraseId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _paraphrase = await _service.getParaphrase(paraphraseId);
    } catch (e) {
      print('재구성 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateParaphrase(
      String paraphraseId, ParaphraseUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _paraphrase = await _service.updateParaphrase(paraphraseId, request);
    } catch (e) {
      print('재구성 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
