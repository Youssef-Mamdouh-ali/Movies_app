import '../entites/browse_entities.dart';
import '../repository/BrowseRepository.dart';

class GetMovies {
  final BrowseRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>> call(String genre) {
    return repository.getMovies(genre);
  }
}
