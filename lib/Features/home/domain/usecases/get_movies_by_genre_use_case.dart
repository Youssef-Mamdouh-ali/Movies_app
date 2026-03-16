import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/repositories/home_repositories.dart';
import '../entites/movie_entity.dart';

class GetMoviesByGenreUseCase {
  final HomeRepository repository;

  const GetMoviesByGenreUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call({
    required String genre,
    int limit = 10,
    int page = 1,
  }) => repository.getMoviesByGenre(genre: genre, limit: limit, page: page);
}
