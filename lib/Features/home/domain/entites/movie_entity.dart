class MovieEntity {
  final int id;
  final String title;
  final int year;
  final double rating;
  final String summary;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<String> genres;
  final int runtime;
  final String language;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.summary,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.genres,
    required this.runtime,
    required this.language,
  });
}
