import 'dart:convert';

import 'package:flutter_chat_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<String> loginUser(String email, String password) async {
    var response = await _apiService.login(email, password);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      String token = responseBody['data']['token'];

      await saveToken(token);

      return token;

      // print(token);
      // print(response.body);
    } else {
      print("Login failed with status code: ${response.statusCode}");
      return '';
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token'); // Token'ı sil
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
