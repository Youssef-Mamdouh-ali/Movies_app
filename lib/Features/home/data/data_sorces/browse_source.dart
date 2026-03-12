import '../../../../core/network_handler/api_manger/ApiManager.dart';
import '../models/MovieModel.dart';

abstract class BrowseRemoteDataSource {
  Future<List<MovieModel>> getMovies(String genre);
}

class BrowseRemoteDataSourceImpl implements BrowseRemoteDataSource {

  final ApiManager apiManager;

  BrowseRemoteDataSourceImpl(this.apiManager);

  @override
  Future<List<MovieModel>> getMovies(String genre) async {

    final response = await apiManager.getMovies(genre);

    final movies = response.data['data']['movies'] as List;

    return movies.map((e) => MovieModel.fromJson(e)).toList();
  }
}