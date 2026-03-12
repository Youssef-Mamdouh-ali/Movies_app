import 'package:dio/dio.dart';

class ApiManager {
  final Dio dio;

  ApiManager(this.dio);

  Future<Response> getMovies(String genre) async {
    return await dio.get(
      "https://movies-api.accel.li/api/v2/list_movies.json",
      queryParameters: {
        "genre": genre,
      },
    );
  }
}