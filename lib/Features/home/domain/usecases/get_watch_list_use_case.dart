import 'package:dartz/dartz.dart';
import 'package:movies_app_project/Features/home/data/repositories/home_repositories.dart';
import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart';
import 'package:movies_app_project/core/errors/failure.dart';

class GetWatchListUseCase {

  final HomeRepository repository;
  GetWatchListUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call() async {
    return await repository.getWatchList();
  }
}