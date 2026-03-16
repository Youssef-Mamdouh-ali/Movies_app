import 'package:movies_app_project/core/utils/api/api_constants.dart';

import '../../domain/entites/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.summary,
    required super.mediumCoverImage,
    required super.largeCoverImage,
    required super.genres,
    required super.runtime,
    required super.language,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json[ApiConstants.id] as int? ?? 0,
      title: json[ApiConstants.title] as String? ?? '',
      year: json[ApiConstants.year] as int? ?? 0,
      rating: (json[ApiConstants.rating] as num?)?.toDouble() ?? 0.0,
      summary: json[ApiConstants.summary] as String? ?? '',
      mediumCoverImage: json[ApiConstants.mediumImage] as String? ?? '',
      largeCoverImage: json[ApiConstants.largeImage] as String? ?? '',
      genres:
          (json[ApiConstants.genres] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      runtime: json[ApiConstants.runtime] as int? ?? 0,
      language: json[ApiConstants.language] as String? ?? 'en',
    );
  }

  Map<String, dynamic> toJson() => {
    ApiConstants.id: id,
    ApiConstants.title: title,
    ApiConstants.year: year,
    ApiConstants.rating: rating,
    ApiConstants.summary: summary,
    ApiConstants.mediumImage: mediumCoverImage,
    ApiConstants.largeImage: largeCoverImage,
    ApiConstants.genres: genres,
    ApiConstants.runtime: runtime,
    ApiConstants.language: language,
  };
}
