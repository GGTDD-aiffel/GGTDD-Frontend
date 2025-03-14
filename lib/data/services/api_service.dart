import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    // final response = await http.get(Uri.parse('http://10.0.2.2:8000/users'));
    return jsonDecode(response.body);
  }

  Future<void> createUser(Map<String, dynamic> data) async {
    await http.post(Uri.parse('$baseUrl/users'), body: jsonEncode(data));
  }

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    await http.put(Uri.parse('$baseUrl/users/$id'), body: jsonEncode(data));
  }

  Future<void> deleteUser(String id) async {
    await http.delete(Uri.parse('$baseUrl/users/$id'));
  }
}
