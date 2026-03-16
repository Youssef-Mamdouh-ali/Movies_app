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
}
