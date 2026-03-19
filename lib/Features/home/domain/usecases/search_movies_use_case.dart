/*
import 'package:dartz/dartz.dart';
import 'package:movies_app_project/Features/home/data/repositories/home_repositories.dart';
import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart';

import 'package:movies_app_project/core/errors/failure.dart';

class SearchMoviesUseCase {
  final HomeRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call({
    required String queryTerm,
    int limit = 10,
    int page = 1,
  }) async {
    return await repository.searchMovies(
      queryTerm: queryTerm,
      limit: limit,
      page: page,
    );
  }
}
*/