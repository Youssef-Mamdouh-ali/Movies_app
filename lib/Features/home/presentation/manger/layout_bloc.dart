import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entites/browse_entities.dart';
import '../../domain/use_cases/browse_use_case.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  final GetMovies getMovies;

  LayoutBloc(this.getMovies) : super(LayoutInitial()) {
    on<GetMoviesEvent>((event, emit) async {

      emit(BrowseLoading());

      try {

        final movies = await getMovies(event.genre);

        emit(BrowseLoaded(movies));

      } catch (e) {

        emit(BrowseError(e.toString()));

      }

    });
  }
}
