



import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart';

abstract class WatchListState {
  const WatchListState();
}

class WatchListInitial extends WatchListState {
  const WatchListInitial();
}

class WatchListLoading extends WatchListState {
  const WatchListLoading();
}

class WatchListSuccess extends WatchListState {
  final List<MovieEntity> movies;

  const WatchListSuccess(this.movies);
}

class WatchListError extends WatchListState {
  final String message;

  const WatchListError(this.message);
}


abstract class HistoryState {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistorySuccess extends HistoryState {
  final List<MovieEntity> movies;

  const HistorySuccess(this.movies);
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);
}

abstract class SearchState {
  const SearchState();
}

class SearchMoviesInitial extends SearchState {
  const SearchMoviesInitial();
}

class SearchMoviesLoading extends SearchState {
  const SearchMoviesLoading();
}

class SearchMoviesSuccess extends SearchState {
  final List<MovieEntity> movies;

  const SearchMoviesSuccess(this.movies);
}

class SearchMoviesError extends SearchState {
  final String message;

  const SearchMoviesError(this.message);
}

abstract class MovieSuggestionsState {
  const MovieSuggestionsState();
}

class MovieSuggestionsInitial extends MovieSuggestionsState {
  const MovieSuggestionsInitial();
}

class MovieSuggestionsLoading extends MovieSuggestionsState {
  const MovieSuggestionsLoading();
}

class MovieSuggestionsSuccess extends MovieSuggestionsState {
  final List<MovieEntity> movies;

  const MovieSuggestionsSuccess(this.movies);
}

class MovieSuggestionsError extends MovieSuggestionsState {
  final String message;

  const MovieSuggestionsError(this.message);
}

abstract class MovieDetailsState {
  const MovieDetailsState();
}

class MovieDetailsInitialState extends MovieDetailsState {
  const MovieDetailsInitialState();
}

class MovieDetailsLoadingState extends MovieDetailsState {
  const MovieDetailsLoadingState();
}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieEntity movie;

  const MovieDetailsSuccessState(this.movie);
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String message;

  const MovieDetailsErrorState(this.message);
}

abstract class RecentMoviesState {
  const RecentMoviesState();
}

class RecentMoviesInitial extends RecentMoviesState {
  const RecentMoviesInitial();
}

class RecentMoviesLoading extends RecentMoviesState {
  const RecentMoviesLoading();
}

class RecentMoviesLoaded extends RecentMoviesState {
  final List<MovieEntity> movies;

  const RecentMoviesLoaded(this.movies);
}

class RecentMoviesError extends RecentMoviesState {
  final String message;

  const RecentMoviesError(this.message);
}

abstract class CategoryMoviesState {
  const CategoryMoviesState();
}

class CategoryMoviesInitial extends CategoryMoviesState {
  const CategoryMoviesInitial();
}

class CategoryMoviesLoading extends CategoryMoviesState {
  const CategoryMoviesLoading();
}

class CategoryMoviesLoaded extends CategoryMoviesState {
  final Map<String, List<MovieEntity>> categoryMovies;

  const CategoryMoviesLoaded(this.categoryMovies);
}

class CategoryMoviesError extends CategoryMoviesState {
  final String message;

  const CategoryMoviesError(this.message);
}

class HomeState {
  final RecentMoviesState recentState;
  final CategoryMoviesState categoryState;
  final MovieDetailsState movieDetailsState;
  final MovieSuggestionsState suggestionsState;
  //  final SearchState searchState;
  final WatchListState watchListState;
  final HistoryState historyState;
  const HomeState({
    this.recentState = const RecentMoviesInitial(),
    this.categoryState = const CategoryMoviesInitial(),
    this.movieDetailsState = const MovieDetailsInitialState(),
    this.suggestionsState = const MovieSuggestionsInitial(),
   // this.searchState = const SearchMoviesInitial(),
    this.watchListState = const WatchListInitial(),
    this.historyState = const HistoryInitial(),
  });

  HomeState copyWith({
    RecentMoviesState? recentState,
    CategoryMoviesState? categoryState,
    MovieDetailsState? movieDetailsState,
    MovieSuggestionsState? suggestionsState,
  //  SearchState? searchState,
    WatchListState? watchListState,
    HistoryState? historyState,
  }) {
    return HomeState(
      recentState: recentState ?? this.recentState,
      categoryState: categoryState ?? this.categoryState,
      movieDetailsState: movieDetailsState ?? this.movieDetailsState,
      suggestionsState: suggestionsState ?? this.suggestionsState,
//      searchState: searchState ?? this.searchState,
      watchListState: watchListState ?? this.watchListState,
      historyState: historyState ?? this.historyState,
    );
  }
}
