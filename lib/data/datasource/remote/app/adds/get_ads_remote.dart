import 'dart:convert';
import 'package:buyro_app/constants.dart';
import 'package:http/http.dart' as http;


class GetProducts {
  Future<List<Map<String, dynamic>>> getData() async {
    final response = await http.get(
      Uri.parse('${baseURL}adv/'),
      headers: {'Content-Type': 'application/json'},
    ); 
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('فشل في تحميل البيانات: ${response.statusCode}');
    }
  }
}
