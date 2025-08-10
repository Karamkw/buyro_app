import 'dart:convert';
import 'package:buyro_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetMyAds {
  Future<List<Map<String, dynamic>>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.get(
      Uri.parse('${baseURL}adv/all-user-advs'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['data'] ?? []);
    } else {
      throw Exception('فشل في تحميل البيانات: ${response.statusCode}');
    }
  }
}
