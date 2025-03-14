import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository repository;
  List<User> users = [];
  bool isLoading = false;

  UserViewModel(this.repository);

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();
    users = await repository.getUsers();
    isLoading = false;
    notifyListeners();
  }
}
