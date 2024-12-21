import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.unsplash.com';
  static const String _clientId = '9kRkEvE3Ntkb7aqAJgD2AVgBnkEpMmQ1dAk8iOmn8Ko';

  /// Fetch wallpapers based on a search query
  static Future<List<Wallpaper>> fetchWallpapers(String query) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/search/photos/?client_id=$_clientId&query=$query&per_page=30'));

      if (response.statusCode == 200) {
        final List results = jsonDecode(response.body)['results'];
        return results.map((e) => Wallpaper.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load wallpapers for query: $query');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching wallpapers: $e');
    }
  }

  /// Fetch default wallpapers for the home screen (could fetch from specific categories like Architecture, Nature, etc.)
  static Future<List<Wallpaper>> fetchDefaultWallpapers() async {
    try {
      final categories = ['Architecture', 'Nature', 'Food', 'Animal', 'Travel'];
      List<Wallpaper> defaultWallpapers = [];

      // Fetch wallpapers for each category (this can be adjusted to fit specific categories you want to show by default)
      for (var category in categories) {
        final response = await http.get(Uri.parse(
            '$_baseUrl/search/photos/?client_id=$_clientId&query=$category&per_page=5'));

        if (response.statusCode == 200) {
          final List results = jsonDecode(response.body)['results'];
          defaultWallpapers.addAll(results.map((e) => Wallpaper.fromJson(e)).toList());
        } else {
          print('Failed to load wallpapers for category: $category');
        }
      }

      return defaultWallpapers;
    } catch (e) {
      throw Exception('Error occurred while fetching default wallpapers: $e');
    }
  }
}
