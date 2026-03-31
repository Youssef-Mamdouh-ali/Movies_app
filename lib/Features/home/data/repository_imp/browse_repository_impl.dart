import '../../domain/entites/browse_entities.dart';
import '../../domain/repository/BrowseRepository.dart';
import '../data_sorces/browse_source.dart';

class BrowseRepositoryImpl implements BrowseRepository {

  final BrowseRemoteDataSource remoteDataSource;

  BrowseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getMovies(String genre) {
    return remoteDataSource.getMovies(genre);
  }
}