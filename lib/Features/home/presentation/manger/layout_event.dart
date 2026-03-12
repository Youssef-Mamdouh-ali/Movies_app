part of 'layout_bloc.dart';

@immutable
sealed class LayoutEvent {}


class GetMoviesEvent extends LayoutEvent {
  final String genre;

  GetMoviesEvent(this.genre);
}
