import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/controller/auth_controller.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/view/widgets/category_list.dart';
import 'package:wallpaper_app/view/widgets/wallpaper_grid.dart';
import 'widgets/search_bar.dart' as custom;

class HomeView extends StatelessWidget {
  final WallpaperController controller = Get.put(WallpaperController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // Fetch default wallpapers on app start
    controller.fetchDefaultWallpapers();

    return Scaffold(
      appBar: AppBar(title: const Text('Wallpaper App'), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            authController.logout();
          },
        ),
      ]),
      body: Column(
        children: [
          SearchBar(onSubmitted: (query) {
            controller.fetchWallpapers(query);
          }),
          const SizedBox(height: 10),
          CategoryList(
            categories: [
              'Architecture',
              'Movie',
              'Travel',
              'Animal',
              'Food',
              'Sport',
              'Nature',
            ], // Example categories
            onCategoryTap: (category) {
              controller.fetchWallpapers(category);
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              } else {
                return WallpaperGrid(
                  data: controller.wallpapers.map((wallpaper) => {
                    'urls': {'regular': wallpaper.imageUrl}
                  }).toList(),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
