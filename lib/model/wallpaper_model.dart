class Wallpaper {
  final String id;
  final String regularUrl;
  final String imageUrl;

  Wallpaper({required this.id, required this.regularUrl,required this.imageUrl });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(

      id: json['id'],
      regularUrl: json['urls']['regular'],
      imageUrl: json['urls']['full'],
    );
  }
}
