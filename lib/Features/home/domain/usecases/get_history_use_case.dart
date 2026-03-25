import 'package:dartz/dartz.dart';
import 'package:movies_app_project/Features/home/data/repositories/home_repositories.dart';
import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart';
import 'package:movies_app_project/core/errors/failure.dart';

class GetHistoryUseCase {
  final HomeRepository repository;
  GetHistoryUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call() async {
    return await repository.getHistory();
  }
}