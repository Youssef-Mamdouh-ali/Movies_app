
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app_project/core/utils/api/api_constants.dart';
import '../../domain/entites/movie_entity.dart';

part 'movie_model.g.dart';


@HiveType(typeId: 0)
class MovieModel extends MovieEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int year;
  @HiveField(3)
  final double rating;
  @HiveField(4)
  final String summary;
  @HiveField(5)
  final String mediumCoverImage;
  @HiveField(6)
  final String largeCoverImage;
  @HiveField(7)
  final List<String> genres;
  @HiveField(8)
  final int runtime;
  @HiveField(9)
  final String language;
  @HiveField(10)
  final String? url;
  @HiveField(11)
  final int? likeCount;
  @HiveField(12)
  final List<CastModel>? cast;
  @HiveField(13)
  final List<String>? screenshots;

  const MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.summary,
    required this.mediumCoverImage,
    required this.genres,
    required this.runtime,
    required this.largeCoverImage,
    required this.language,
    required this.url,
    required this.likeCount,
    required this.cast,
    required this.screenshots,
  }) : super(
    id: id,
    title: title,
    year: year,
    rating: rating,
    summary: summary,
    mediumCoverImage: mediumCoverImage,
    largeCoverImage: largeCoverImage,
    genres: genres,
    runtime: runtime,
    language: language,
    url: url,
    likeCount: likeCount,
    cast: cast,
    screenshots: screenshots,
  );


  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json[ApiConstants.id] ?? json['id'] ?? 0,
      title: json[ApiConstants.title] ?? json['title_english'] ?? '',
      year: json[ApiConstants.year] ?? json['year'] ?? 0,
      rating: (json[ApiConstants.rating] as num?)?.toDouble() ??
          (json['rating'] as num?)?.toDouble() ??
          0.0,
      summary: json[ApiConstants.summary] ?? json['description_full'] ?? '',
      mediumCoverImage: json[ApiConstants.mediumImage] ?? json['medium_cover_image'] ?? '',
      largeCoverImage: json[ApiConstants.largeImage] ?? json['large_cover_image'] ?? '',
      genres: json[ApiConstants.genres] != null
          ? List<String>.from(json[ApiConstants.genres])
          : (json['genres'] != null ? List<String>.from(json['genres']) : []),
      runtime: json[ApiConstants.runtime] ?? json['runtime'] ?? 0,
      language: json[ApiConstants.language] ?? json['language'] ?? '',
      url: json['url'],
      likeCount: json['like_count'],
      cast: json['cast'] != null
          ? (json['cast'] as List).map((e) => CastModel.fromJson(e)).toList()
          : null,
      screenshots: [
        json['medium_screenshot_image1'],
        json['medium_screenshot_image2'],
        json['medium_screenshot_image3'],
      ].whereType<String>().toList(),
    );
  }


  factory MovieModel.fromEntity(MovieEntity entity) {
    return MovieModel(
      id: entity.id,
      title: entity.title,
      year: entity.year,
      rating: entity.rating,
      summary: entity.summary,
      mediumCoverImage: entity.mediumCoverImage,
      largeCoverImage: entity.largeCoverImage,
      genres: entity.genres,
      runtime: entity.runtime,
      language: entity.language,
      url: entity.url,
      likeCount: entity.likeCount,
      cast: entity.cast?.map((e) => CastModel.fromEntity(e)).toList(),
      screenshots: entity.screenshots,
    );
  }


  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      year: year,
      rating: rating,
      summary: summary,
      mediumCoverImage: mediumCoverImage,
      largeCoverImage: largeCoverImage,
      genres: genres,
      runtime: runtime,
      language: language,
      url: url,
      likeCount: likeCount,
      cast: cast?.map((e) => e.toEntity()).toList(),
      screenshots: screenshots,
    );
  }
}

@HiveType(typeId: 1)
class CastModel extends CastEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String characterName;
  @HiveField(2)
  final String urlCastImage;

  CastModel({
    required this.name,
    required this.characterName,
    required this.urlCastImage,
  }) : super(
    name: name,
    characterName: characterName,
    urlCastImage: urlCastImage,
  );

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      urlCastImage: json['url_small_image'] ?? '',
    );
  }

  factory CastModel.fromEntity(CastEntity entity) => CastModel(
    name: entity.name,
    characterName: entity.characterName,
    urlCastImage: entity.urlCastImage,
  );

  CastEntity toEntity() => CastEntity(
    name: name,
    characterName: characterName,
    urlCastImage: urlCastImage,
  );
}