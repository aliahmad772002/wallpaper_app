import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper_model.dart';


class ApiService {
  static const String _baseUrl = 'https://api.unsplash.com';
  static const String _clientId = '9kRkEvE3Ntkb7aqAJgD2AVgBnkEpMmQ1dAk8iOmn8Ko';

  static Future<List<Wallpaper>> fetchWallpapers(String query) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/search/photos/?client_id=$_clientId&query=$query&per_page=30'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      print('Fetched wallpapers: $results');
      return results.map((e) => Wallpaper.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
}

// class ApiService {
//   static const String _baseUrl = 'https://api.unsplash.com';
//   static const String _clientId = 'fnPayxvwq8VrwzgJTJLYNwjdVQWb3X0Rapd2S6ZPmjw';
//
//   static Future<List<Wallpaper>> fetchWallpapers(String query) async {
//     final response = await http.get(Uri.parse(
//         '$_baseUrl/search/photos/?client_id=$_clientId&query=$query&per_page=30'));
//
//     if (response.statusCode == 200) {
//       final List results = jsonDecode(response.body)['results'];
//
//       return results.map((e) => Wallpaper.fromJson(e)).toList();
//
//     } else {
//       throw Exception('Failed to load wallpapers');
//     }
//   }
// }
