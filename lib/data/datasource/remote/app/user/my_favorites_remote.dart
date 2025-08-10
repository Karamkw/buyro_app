import 'dart:convert';
import 'package:buyro_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetMyFav {
  Future<List<Map<String, dynamic>>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.get(
      Uri.parse('${baseURL}user/favorites'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<dynamic> favoritesList = data['data'];
      List<Map<String, dynamic>> advList = [];

      for (var fav in favoritesList) {
        if (fav['adv'] != null) {
          advList.add(Map<String, dynamic>.from(fav['adv']));
        }
      }
      return advList;
    } else {
      throw Exception('فشل في تحميل البيانات: ${response.statusCode}');
    }
  }
}
