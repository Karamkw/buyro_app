import 'package:buyro_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddAdRemote {
  Future<http.Response> postData({required var body}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.post(
      Uri.parse('${baseURL}adv/create'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    return response;
  }
}
