import 'package:dartz/dartz.dart';
import 'package:movies_app_project/Features/home/data/repositories/home_repositories.dart';
import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart';

import 'package:movies_app_project/core/errors/failure.dart';

class GetMovieDetailsUseCase {
  final HomeRepository repository;

  GetMovieDetailsUseCase(this.repository);

  Future<Either<Failure, MovieEntity>> call({
    required int movieId,
  }) async {
    return await repository.getMovieDetails(movieId: movieId);
  }
}