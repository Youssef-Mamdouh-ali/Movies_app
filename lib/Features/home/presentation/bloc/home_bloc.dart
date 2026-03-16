import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/api/api_constants.dart';
import '../../domain/entites/movie_entity.dart';
import '../../domain/usecases/get_movies_by_genre_use_case.dart';
import '../../domain/usecases/get_recent_movies_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecentMoviesUseCase getRecentMoviesUseCase;
  final GetMoviesByGenreUseCase getMoviesByGenreUseCase;

  HomeBloc({
    required this.getRecentMoviesUseCase,
    required this.getMoviesByGenreUseCase,
  }) : super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<FetchRecentMovies>(_onFetchRecentMovies);
    on<FetchMoviesByGenre>(_onFetchMoviesByGenre);
    on<FetchAllCategories>(_onFetchAllCategories);
  }

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    add(const FetchRecentMovies());
    add(const FetchAllCategories());
  }

  Future<void> _onFetchRecentMovies(
    FetchRecentMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(recentState: const RecentMoviesLoading()));

    final result = await getRecentMoviesUseCase(
      limit: ApiConstants.recentLimit,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(recentState: RecentMoviesError(failure.message))),
      (movies) => emit(state.copyWith(recentState: RecentMoviesLoaded(movies))),
    );
  }

  Future<void> _onFetchAllCategories(
    FetchAllCategories event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoryState: const CategoryMoviesLoading()));

    final Map<String, List<MovieEntity>> categoryMap = {};

    final futures = ApiConstants.suggestionGenres.map((genre) async {
      final result = await getMoviesByGenreUseCase(
        genre: genre,
        limit: ApiConstants.categoryLimit,
      );
      result.fold(
        (_) => categoryMap[genre] = [],
        (movies) => categoryMap[genre] = movies,
      );
    });

    await Future.wait(futures);

    emit(state.copyWith(categoryState: CategoryMoviesLoaded(categoryMap)));
  }

  Future<void> _onFetchMoviesByGenre(
    FetchMoviesByGenre event,
    Emitter<HomeState> emit,
  ) async {
    final currentMap = state.categoryState is CategoryMoviesLoaded
        ? Map<String, List<MovieEntity>>.from(
            (state.categoryState as CategoryMoviesLoaded).categoryMovies,
          )
        : <String, List<MovieEntity>>{};

    final result = await getMoviesByGenreUseCase(
      genre: event.genre,
      limit: ApiConstants.categoryLimit,
    );

    result.fold(
      (failure) {
        currentMap[event.genre] = [];
        emit(state.copyWith(categoryState: CategoryMoviesLoaded(currentMap)));
      },
      (movies) {
        currentMap[event.genre] = movies;
        emit(state.copyWith(categoryState: CategoryMoviesLoaded(currentMap)));
      },
    );
  }
}
