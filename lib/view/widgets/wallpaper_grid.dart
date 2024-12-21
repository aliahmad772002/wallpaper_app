import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WallpaperGrid extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const WallpaperGrid({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: data.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        double ht = index % 2 == 0 ? 200 : 100;
        String imageUrl = data[index]['urls']['regular'];

        return Padding(
          padding: const EdgeInsets.all(10),
          child: InstaImageViewer(
            child: GestureDetector(
              onTap: () => _showFullScreenImage(context, imageUrl),
              child: Image.network(
                imageUrl,
                height: ht,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    )
        : Container(
      height: 500,
      child: const Center(child: CircularProgressIndicator(color: Colors.blue)),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Full-screen image
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              // Share and Download buttons
              Positioned(
                bottom: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.share, size: 20, color: Colors.white),
                        onPressed: () {
                          // Add share functionality here
                          print("Share button clicked");
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.download, size: 20, color: Colors.white),
                        onPressed: () {
                          // Add download functionality here
                          print("Download button clicked");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
