import 'package:dio/dio.dart';
import 'package:movies_app_project/core/network_handler/api_constant.dart';
import 'package:movies_app_project/core/network_handler/end_points.dart';

class ApiManager {
  final Dio dio;

  ApiManager(this.dio);

  Future<Response> getMovies(String genre) async {
    return await dio.get(
      ApiConstant.baseUrl + EndPoints.movieList,
      queryParameters: {"genre": genre},
    );
  }
}
