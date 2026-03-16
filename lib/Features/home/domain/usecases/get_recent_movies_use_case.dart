import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/repositories/home_repositories.dart';
import '../entites/movie_entity.dart';

class GetRecentMoviesUseCase {
  final HomeRepository repository;

  const GetRecentMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call({
    int limit = 20,
    int page = 1,
  }) => repository.getRecentMovies(limit: limit, page: page);
}
