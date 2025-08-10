import 'package:buyro_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LikeAndFavAd {
  Future<http.Response> likead({required String adid}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.post(
      Uri.parse('${baseURL}adv/add-like'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'adv_id': adid}),
    );
    return response;
  }

  Future<http.Response> removelikead({required String adid}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.post(
      Uri.parse('${baseURL}adv/remove-like'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'adv_id': adid}),
    );
    return response;
  }

  Future<http.Response> favad({required var adid}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.post(
      Uri.parse('${baseURL}adv/add-favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'adv_id': adid}),
    );
    return response;
  }

  Future<http.Response> removefavad({required var adid}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    final response = await http.post(
      Uri.parse('${baseURL}adv/remove-favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'adv_id': adid}),
    );
    return response;
  }
}
