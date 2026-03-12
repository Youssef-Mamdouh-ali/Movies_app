import '../../domain/entites/browse_entities.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.image,
    required super.rating,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? "",
      image: json['medium_cover_image'] ?? "",
      rating: (json['rating'] ?? 0).toDouble(),
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}