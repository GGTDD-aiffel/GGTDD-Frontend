import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/data/model/api_user_model.dart';
import 'package:ggtdd_frontend/data/services/user_service.dart';

class UserController extends ChangeNotifier {
  final UserService _service;
  UserGetResponse? _user;
  bool _isLoading = false;

  UserGetResponse? get user => _user;
  bool get isLoading => _isLoading;

  UserController({required UserService service}) : _service = service;

  Future<void> fetchUser(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getUser(userId);
      if (response.code == 200 && response.data != null) {
        _user = response.data;
      } else {
        print('유저 조회 실패: ${response.message}');
      }
    } catch (e) {
      print('유저 조회 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(String userId, UserUpdateRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      print('Sending update request: ${request.toJson()}');
      final response = await _service.updateUser(userId, request);
      if (response.code == 200 && response.data != null) {
        _user = response.data;
        print('Updated user data: ${_user?.user.toString()}');
      } else {
        print('유저 수정 실패: ${response.message}');
      }
    } catch (e) {
      print('유저 수정 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
