import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entites/movie_entity.dart';
import '../data_sorces/home_remote_data_source.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MovieEntity>>> getRecentMovies({
    int limit = 20,
    int page = 1,
  });

  Future<Either<Failure, List<MovieEntity>>> getMoviesByGenre({
    required String genre,
    int limit = 10,
    int page = 1,
  });
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> getRecentMovies({
    int limit = 20,
    int page = 1,
  }) async {
    try {
      final movies = await remoteDataSource.getRecentMovies(
        limit: limit,
        page: page,
      );
      return Right(movies.cast<MovieEntity>());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getMoviesByGenre({
    required String genre,
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final movies = await remoteDataSource.getMoviesByGenre(
        genre: genre,
        limit: limit,
        page: page,
      );
      return Right(movies.cast<MovieEntity>());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
