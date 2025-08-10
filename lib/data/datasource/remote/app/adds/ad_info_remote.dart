import 'dart:convert';
import 'package:buyro_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AddInofrmation {
  Future<Map<String, dynamic>> getData(String id) async {
      final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.get(
      Uri.parse('${baseURL}adv/show/$id'),
      headers: {'Content-Type': 'application/json', 'Authorization':'Bearer $token',
      },
    );
     print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
       return data['data'][0];
    } else {
      throw Exception('فشل في تحميل البيانات: ${response.statusCode}');
    }
  }
}
