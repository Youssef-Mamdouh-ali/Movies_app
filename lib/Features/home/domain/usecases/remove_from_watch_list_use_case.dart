import 'package:dartz/dartz.dart';
import 'package:movies_app_project/Features/home/data/repositories/home_repositories.dart';
import 'package:movies_app_project/core/errors/failure.dart';

class RemoveFromWatchListUseCase {
  final HomeRepository repository;

  RemoveFromWatchListUseCase(this.repository);

  Future<Either<Failure, void>> call(int movieId) async {
    return await repository.removeFromWatchList(movieId);
  }
}
