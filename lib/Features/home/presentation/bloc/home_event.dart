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
