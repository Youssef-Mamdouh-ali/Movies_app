class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://movies-api.accel.li/api/v2';
  static const String listMovies = '$baseUrl/list_movies.json';
  static const String movieDetails = "$baseUrl/movie_details.json";
  static const String movieSuggestions = "$baseUrl/movie_suggestions.json";

  static const String limit = 'limit';
  static const String page = 'page';
  static const String genre = 'genre';
  static const String sortBy = 'sort_by';
  static const String orderBy = 'order_by';
  static const String minimumRating = 'minimum_rating';
  static const String queryTerm = 'query_term';

  static const String sortByDateAdded = 'date_added';
  static const String sortByRating = 'rating';
  static const String sortByDownloadCount = 'download_count';

  static const String orderDesc = 'desc';
  static const String orderAsc = 'asc';

  static const String id = 'id';
  static const String title = 'title';
  static const String year = 'year';
  static const String rating = 'rating';
  static const String summary = 'summary';
  static const String mediumImage = 'medium_cover_image';
  static const String largeImage = 'large_cover_image';
  static const String genres = 'genres';
  static const String runtime = 'runtime';
  static const String language = 'language';

  static const List<String> suggestionGenres = [
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Sci-Fi',
    'Animation',
    'Romance',
    'Thriller',
  ];

  static const int categoryLimit = 10;
  static const int recentLimit = 20;
}
