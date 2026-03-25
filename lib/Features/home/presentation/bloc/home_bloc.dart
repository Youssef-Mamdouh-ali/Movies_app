import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/home/domain/usecases/add_to_history_use_case.dart';
import 'package:movies_app_project/Features/home/domain/usecases/add_to_watch_list_use_case.dart';
import 'package:movies_app_project/Features/home/domain/usecases/get_history_use_case.dart';
import 'package:movies_app_project/Features/home/domain/usecases/get_movie_details_use_case.dart';
import 'package:movies_app_project/Features/home/domain/usecases/get_movie_suggestions_use_case.dart';
import 'package:movies_app_project/Features/home/domain/usecases/get_watch_list_use_case.dart';
import 'package:movies_app_project/Features/home/domain/usecases/remove_from_watch_list_use_case.dart';
import 'package:movies_app_project/Features/home/domain/usecases/search_movies_use_case.dart';
import '../../../../core/utils/api/api_constants.dart';
import '../../domain/entites/movie_entity.dart';
import '../../domain/usecases/get_movies_by_genre_use_case.dart';
import '../../domain/usecases/get_recent_movies_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecentMoviesUseCase getRecentMoviesUseCase;
  final GetMoviesByGenreUseCase getMoviesByGenreUseCase;
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  final GetMovieSuggestionsUseCase getMovieSuggestionsUseCase;
  final SearchMoviesUseCase searchMoviesUseCase;

  final GetWatchListUseCase getWatchListUseCase;
  final AddToWatchListUseCase addToWatchListUseCase;
  final RemoveFromWatchListUseCase removeFromWatchListUseCase;
  final GetHistoryUseCase getHistoryUseCase;
  final AddToHistoryUseCase addToHistoryUseCase;

  HomeBloc({
    required this.getRecentMoviesUseCase,
    required this.getMoviesByGenreUseCase,
    required this.getMovieDetailsUseCase,
    required this.getMovieSuggestionsUseCase,
    required this.searchMoviesUseCase,
    required this.getWatchListUseCase,
    required this.addToWatchListUseCase,
    required this.removeFromWatchListUseCase,
    required this.getHistoryUseCase,
    required this.addToHistoryUseCase,
  }) : super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<FetchRecentMovies>(_onFetchRecentMovies);
    on<FetchMoviesByGenre>(_onFetchMoviesByGenre);
    on<FetchAllCategories>(_onFetchAllCategories);
    on<FetchMovieDetails>(_onFetchMovieDetails);
    on<FetchMovieSuggestions>(_onFetchMovieSuggestions);
    on<FetchSearchMovies>(_onFetchSearchMovies);
    on<FetchProfileData>(_onFetchProfileData);
    on<AddToWatchList>(_onAddToWatchList);
    on<RemoveFromWatchList>(_onRemoveFromWatchList);
    on<AddToHistory>(_onAddToHistory);
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

  Future<void> _onFetchMovieDetails(
    FetchMovieDetails event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(movieDetailsState: const MovieDetailsLoadingState()));

    final result = await getMovieDetailsUseCase(movieId: event.movieId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          movieDetailsState: MovieDetailsErrorState(failure.message),
        ),
      ),
      (movie) {
        emit(
          state.copyWith(movieDetailsState: MovieDetailsSuccessState(movie)),
        );
        add(FetchMovieSuggestions(event.movieId));
        add(AddToHistory(movie));
      },
    );
  }

  Future<void> _onFetchMovieSuggestions(
    FetchMovieSuggestions event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(suggestionsState: const MovieSuggestionsLoading()));

    final result = await getMovieSuggestionsUseCase(movieId: event.movieId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          suggestionsState: MovieSuggestionsError(failure.message),
        ),
      ),
      (movies) => emit(
        state.copyWith(suggestionsState: MovieSuggestionsSuccess(movies)),
      ),
    );
  }
  Future<void> _onFetchSearchMovies(
    FetchSearchMovies event,
    Emitter<HomeState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(searchState: const SearchMoviesInitial()));
      return;
    }

    emit(state.copyWith(searchState: const SearchMoviesLoading()));

    final result = await searchMoviesUseCase(
      queryTerm: event.query,
      limit: ApiConstants.categoryLimit,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(searchState: SearchMoviesError(failure.message))),
      (movies) =>
          emit(state.copyWith(searchState: SearchMoviesSuccess(movies))),
    );
  }
  Future<void> _onFetchProfileData(
    FetchProfileData event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        watchListState: WatchListLoading(),
        historyState: HistoryLoading(),
      ),
    );

    final watchListResult = await getWatchListUseCase();
    final historyResult = await getHistoryUseCase();

    emit(
      state.copyWith(
        watchListState: watchListResult.fold(
          (failure) => WatchListError(failure.message),
          (movies) => WatchListSuccess(movies),
        ),
        historyState: historyResult.fold(
          (failure) => HistoryError(failure.message),
          (movies) => HistorySuccess(movies),
        ),
      ),
    );
  }

  Future<void> _onAddToWatchList(
    AddToWatchList event,
    Emitter<HomeState> emit,
  ) async {
    final result = await addToWatchListUseCase(event.movie);
    await result.fold((failure) async => null, (_) async {
      final watchListResult = await getWatchListUseCase();
      watchListResult.fold(
        (failure) => null,
        (movies) =>
            emit(state.copyWith(watchListState: WatchListSuccess(movies))),
      );
    });
  }

  Future<void> _onRemoveFromWatchList(
    RemoveFromWatchList event,
    Emitter<HomeState> emit,
  ) async {
    final result = await removeFromWatchListUseCase(event.movieId);
    await result.fold((failure) async => null, (_) async {
      final watchListResult = await getWatchListUseCase();
      watchListResult.fold(
        (failure) => null,
        (movies) =>
            emit(state.copyWith(watchListState: WatchListSuccess(movies))),
      );
    });
  }

  Future<void> _onAddToHistory(
    AddToHistory event,
    Emitter<HomeState> emit,
  ) async {
    final result = await addToHistoryUseCase(event.movie);

    await result.fold(
      (failure) async {
        return null;
      },
      (_) async {
        final historyResult = await getHistoryUseCase();
        historyResult.fold(
          (failure) {
            return null;
          },
          (movies) {
            emit(state.copyWith(historyState: HistorySuccess(movies)));
          },
        );
      },
    );
  }
}
