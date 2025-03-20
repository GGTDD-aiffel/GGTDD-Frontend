import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_paraphrase_model.dart';
import 'package:ggtdd_frontend/data/services/paraphrase_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/paraphrase_model.dart';

class ParaphraseController extends ChangeNotifier {
  final ParaphraseService _service;
  List<Paraphrase> _paraphrases = [];
  Paraphrase? _paraphrase;
  bool _isLoading = false;

  List<Paraphrase> get paraphrases => _paraphrases;
  Paraphrase? get paraphrase => _paraphrase;
  bool get isLoading => _isLoading;

  ParaphraseController({required ParaphraseService service})
      : _service = service;

  Future<void> fetchParaphrases() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getParaphrases();
      if (response.code == 200 && response.data != null) {
        _paraphrases = response.data!.paraphrases;
        print('재구성 리스트 조회 성공: ${response.message}');
      } else {
        print('재구성 리스트 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.getParaphrase(paraphraseId);
      if (response.code == 200 && response.data != null) {
        _paraphrase = response.data!.paraphrase;
        print('재구성 조회 성공: ${response.message}');
      } else {
        print('재구성 조회 실패: ${response.message} (code: ${response.code})');
      }
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
      final response = await _service.updateParaphrase(paraphraseId, request);
      if (response.code == 200 && response.data != null) {
        _paraphrase = response.data!.paraphrase;
        print('재구성 수정 성공: ${response.message}');
      } else {
        print('재구성 수정 실패: ${response.message} (code: ${response.code})');
      }
    } catch (e) {
      print('재구성 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
