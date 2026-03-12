
import '../entites/browse_entities.dart';

abstract class BrowseRepository {
  Future<List<Movie>> getMovies(String genre);
}