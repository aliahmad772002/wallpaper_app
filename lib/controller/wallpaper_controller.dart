import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import '../services/api_service.dart';
import 'package:http/http.dart' as http;

class WallpaperController extends GetxController {
  var wallpapers = <Wallpaper>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  /// Fetch wallpapers based on query or category
  void fetchWallpapers(String query) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      wallpapers.value = await ApiService.fetchWallpapers(query);
    } catch (e) {
      errorMessage.value = 'Failed to load wallpapers. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch default wallpapers to show on the home screen
  void fetchDefaultWallpapers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      wallpapers.value = await ApiService.fetchDefaultWallpapers(); // Example method
    } catch (e) {
      errorMessage.value = 'Error occurred while loading default wallpapers.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> downloadImage(String url, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(url));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File('${documentDirectory.path}/wallpaper.jpg');
      file.writeAsBytesSync(response.bodyBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper downloaded to ${file.path}')),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> shareImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp.jpg');
      file.writeAsBytesSync(response.bodyBytes);

      await Share.shareXFiles([XFile(file.path)], text: 'Check out this wallpaper!');
    } catch (e) {
      print(e);
    }
  }
}
