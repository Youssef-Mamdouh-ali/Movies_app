part of 'layout_bloc.dart';



@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

class BrowseInitial extends LayoutState {}

class BrowseLoading extends LayoutState {}

class BrowseLoaded extends LayoutState {
  final List<Movie> movies;

  BrowseLoaded(this.movies);
}

class BrowseError extends LayoutState {
  final String message;

  BrowseError(this.message);
}