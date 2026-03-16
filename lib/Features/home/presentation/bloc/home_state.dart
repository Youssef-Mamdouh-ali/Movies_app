import '../../domain/entites/movie_entity.dart';

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

  const HomeState({
    this.recentState = const RecentMoviesInitial(),
    this.categoryState = const CategoryMoviesInitial(),
  });

  HomeState copyWith({
    RecentMoviesState? recentState,
    CategoryMoviesState? categoryState,
  }) {
    return HomeState(
      recentState: recentState ?? this.recentState,
      categoryState: categoryState ?? this.categoryState,
    );
  }
}
