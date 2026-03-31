import 'package:dartz/dartz.dart';
import 'package:movies_app_project/Features/home/data/repositories/home_repositories.dart';
import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart';
import 'package:movies_app_project/core/errors/failure.dart';

class AddToWatchListUseCase {
  final HomeRepository repository;
  AddToWatchListUseCase(this.repository);

  Future<Either<Failure, void>> call(MovieEntity movie) async {
    return await repository.addToWatchList(movie);
  }
}