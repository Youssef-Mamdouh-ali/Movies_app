import 'package:dartz/dartz.dart';
import 'package:movies_app_project/Features/home/data/data_sorces/home_local_data_source.dart';
import 'package:movies_app_project/Features/home/data/model/movie_model.dart';
import 'package:movies_app_project/core/errors/exception.dart';
import 'package:movies_app_project/core/errors/failure.dart';
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

  Future<Either<Failure, MovieEntity>> getMovieDetails({
    required int movieId,
  });

  Future<Either<Failure, List<MovieEntity>>> getMovieSuggestions({required int movieId});
/*
  Future<Either<Failure, List<MovieEntity>>> searchMovies({
    required String queryTerm,
    int limit = 10,
    int page = 1,
  });
*/
  Future<Either<Failure, List<MovieEntity>>> getWatchList();
  Future<Either<Failure, void>> addToWatchList(MovieEntity movie);
  Future<Either<Failure, void>> removeFromWatchList(int movieId);

  Future<Either<Failure, List<MovieEntity>>> getHistory();
  Future<Either<Failure, void>> addToHistory(MovieEntity movie);
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  const HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

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

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails({
    required int movieId,
  }) async {
    try {
      final movieDetails = await remoteDataSource.getMovieDetails(
        movieId: movieId,
      );
      return Right(movieDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovieSuggestions({
    required int movieId,
  }) async {
    try {
      final movies = await remoteDataSource.getMovieSuggestions(
        movieId: movieId,
      );

      return Right(movies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
/*
  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies({
    required String queryTerm,
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final movies = await remoteDataSource.searchMovies(
        queryTerm: queryTerm,
        limit: limit,
        page: page,
      );
      return Right(movies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An error occurred while searching: $e'));
    }
  }
*/
  @override
  Future<Either<Failure, void>> addToHistory(MovieEntity movie) async {
    try {
      final model = MovieModel.fromEntity(movie);
      await localDataSource.addToHistory(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Unable to update viewing history'));
    }
  }

  @override
  Future<Either<Failure, void>> addToWatchList(MovieEntity movie) async {
    try {
      final model = MovieModel.fromEntity(movie);
      await localDataSource.addToWatchList(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('The film could not be added to the list.'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getHistory() async {
    try {
      final movies = await localDataSource.getHistory();
      return Right(movies);
    } catch (e) {
      return Left(DatabaseFailure('An error occurred while retrieving the viewing history.'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getWatchList() async {
    try {
      final movies = await localDataSource.getWatchList();
      return Right(movies);
    } catch (e) {
      return Left(DatabaseFailure('An error occurred while fetching the watchlist.'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWatchList(int movieId) async {
    try {
      await localDataSource.removeFromWatchList(movieId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('The movie could not be deleted from the list.'));
    }
  }
}
