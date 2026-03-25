import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_state.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_empty_list_widget.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'custom_movie_card.dart';

class CustomWatchListBodyWidget extends StatelessWidget {
  const CustomWatchListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.watchListState != current.watchListState,
      builder: (context, state) {
        final watchListState = state.watchListState;

        if (watchListState is WatchListSuccess &&
            watchListState.movies.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: watchListState.movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final movie = watchListState.movies[index];
                return CustomMovieCard(
                  movie: watchListState.movies[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PagesRoutesName.movieDetailsView,
                      arguments:
                          movie.id,
                    );
                  },
                );
              },
            ),
          );
        }


        return const CustomEmptyListWidget();
      },
    );
  }
}
