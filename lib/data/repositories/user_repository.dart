import 'package:ggtdd_frontend/ui/domain/models/user_model.dart';

import '../services/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(this.apiService);

  Future<List<User>> getUsers() async {
    final response = await apiService.getUsers();
    return response.map((json) => User.fromJson(json)).toList();
  }
}
