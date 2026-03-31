import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exception.dart';
import '../../../../core/utils/api/api_constants.dart';
import '../model/movie_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MovieModel>> getRecentMovies({int limit = 20, int page = 1});

  Future<List<MovieModel>> getMoviesByGenre({
    required String genre,
    int limit = 10,
    int page = 1,
  });

  Future<MovieModel> getMovieDetails({required int movieId});

  Future<List<MovieModel>> getMovieSuggestions({required int movieId});

  Future<List<MovieModel>> searchMovies({
    required String queryTerm,
    int limit = 10,
    int page = 1,
  });


}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  const HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getRecentMovies({
    int limit = 20,
    int page = 1,
  }) async {
    final uri = Uri.parse(ApiConstants.listMovies).replace(
      queryParameters: {
        ApiConstants.limit: limit.toString(),
        ApiConstants.page: page.toString(),
        ApiConstants.sortBy: ApiConstants.sortByDateAdded,
        ApiConstants.orderBy: ApiConstants.orderDesc,
      },
    );
    return _fetchMovies(uri);
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre({
    required String genre,
    int limit = 10,
    int page = 1,
  }) async {
    final uri = Uri.parse(ApiConstants.listMovies).replace(
      queryParameters: {
        ApiConstants.genre: genre,
        ApiConstants.limit: limit.toString(),
        ApiConstants.page: page.toString(),
        ApiConstants.sortBy: ApiConstants.sortByRating,
        ApiConstants.orderBy: ApiConstants.orderDesc,
        ApiConstants.minimumRating: '6',
      },
    );
    return _fetchMovies(uri);
  }

  Future<List<MovieModel>> _fetchMovies(Uri uri) async {
    try {
      final response = await client
          .get(uri, headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;

        if (decoded['status'] != 'ok') {
          throw ServerException(
            decoded['status_message'] as String? ?? 'Unknown API error',
          );
        }

        final data = decoded['data'] as Map<String, dynamic>?;
        final movies = data?['movies'] as List<dynamic>?;

        if (movies == null || movies.isEmpty) return [];

        return movies
            .map((m) => MovieModel.fromJson(m as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Server error: ${response.statusCode}');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<MovieModel> getMovieDetails({required int movieId}) async {
    final uri = Uri.parse(ApiConstants.movieDetails).replace(
      queryParameters: {
        'movie_id': movieId.toString(),
        'with_images': 'true',
        'with_cast': 'true',
      },
    );

    try {
      final response = await client
          .get(uri, headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as Map<String, dynamic>;

        if (decodedData['status'] == 'ok') {
          final movieData =
              decodedData['data']['movie'] as Map<String, dynamic>?;
          if (movieData == null) {
            throw ServerException('No data was found for this film.');
          }
          return MovieModel.fromJson(movieData);
        } else {
          throw ServerException(
            decodedData['status_message'] ?? 'Unknown API error',
          );
        }
      } else {
        throw ServerException('Server error: ${response.statusCode}');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<List<MovieModel>> getMovieSuggestions({required int movieId}) async {
    final uri = Uri.parse(
      ApiConstants.movieSuggestions,
    ).replace(queryParameters: {'movie_id': movieId.toString()});

    try {
      final response = await client
          .get(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'Mozilla/5.0...',
              'Referer': 'https://yts.mx/',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData['status'] == 'ok') {
          final List moviesList = decodedData['data']['movies'] ?? [];
          return moviesList.map((m) => MovieModel.fromJson(m)).toList();
        }
        throw ServerException(decodedData['status_message'] ?? 'API Error');
      }
      throw ServerException('Server Error: ${response.statusCode}');
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<List<MovieModel>> searchMovies({
    required String queryTerm,
    int limit = 10,
    int page = 1,
  }) async {
    final uri = Uri.parse(ApiConstants.listMovies).replace(
      queryParameters: {
        'query_term': queryTerm,
        ApiConstants.limit: limit.toString(),
        ApiConstants.page: page.toString(),
      },
    );

    return _fetchMovies(uri);
  }

}
