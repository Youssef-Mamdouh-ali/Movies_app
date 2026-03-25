import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class FetchRecentMovies extends HomeEvent {
  const FetchRecentMovies();
}

class FetchMoviesByGenre extends HomeEvent {
  final String genre;

  const FetchMoviesByGenre(this.genre);
}

class FetchAllCategories extends HomeEvent {
  const FetchAllCategories();
}

class FetchMovieDetails extends HomeEvent {
  final int movieId;
  const FetchMovieDetails(this.movieId);
}

class FetchMovieSuggestions extends HomeEvent {
  final int movieId;
  const FetchMovieSuggestions(this.movieId);

}

/*
class FetchSearchMovies extends HomeEvent {
  final String query;
  const FetchSearchMovies(this.query);
}
*/
class FetchProfileData extends HomeEvent {
  const FetchProfileData();
}


class AddToWatchList extends HomeEvent {
  final MovieEntity movie;
  const AddToWatchList(this.movie);
}

class RemoveFromWatchList extends HomeEvent {
  final int movieId;
  const RemoveFromWatchList(this.movieId);
}


class AddToHistory extends HomeEvent {

  final MovieEntity movie;
  const AddToHistory(this.movie);
}