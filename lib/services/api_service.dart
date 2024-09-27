import "package:flutter_chat_app/constants/api_url.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class ApiService {
  var path = Uri.parse(loginUrl);

  Future login(String email, String password) async {
    var response = await http.post(
      path,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "userName": email,
        "password": password,
      }),
    );
    return response;
  }
}
