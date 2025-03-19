import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_occupation_model.dart';
import 'package:ggtdd_frontend/data/services/occupation_service.dart';
import 'package:ggtdd_frontend/ui/domain/models/occupation_model.dart';

class OccupationController extends ChangeNotifier {
  final OccupationService _service;
  List<Occupation> _occupations = [];
  Occupation? _occupation;
  bool _isLoading = false;

  List<Occupation> get occupations => _occupations;
  Occupation? get occupation => _occupation;
  bool get isLoading => _isLoading;

  OccupationController({required OccupationService service})
      : _service = service;

  Future<void> fetchOccupations() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getOccupations();
      _occupations = response.occupations;
    } catch (e) {
      print('직업 리스트 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOccupation(String occupationId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _occupation = await _service.getOccupation(occupationId);
    } catch (e) {
      print('직업 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateOccupation(
      String occupationId, OccupationUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      _occupation = await _service.updateOccupation(occupationId, request);
    } catch (e) {
      print('직업 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
