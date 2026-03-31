import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_state.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_empty_list_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_movie_card.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';

class CustomHistoryListBodyWidget extends StatelessWidget {
  const CustomHistoryListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.historyState != current.historyState,
      builder: (context, state) {
        final historyState = state.historyState;



        if (historyState is HistoryLoading) {

          return const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (historyState is HistorySuccess) {


          if (historyState.movies.isEmpty) {

            return const CustomEmptyListWidget();
          }

          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 24.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: historyState.movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final movie = historyState.movies[index];

                return CustomMovieCard(movie: historyState.movies[index] , onTap: () {
                  Navigator.pushNamed(
                    context,
                    PagesRoutesName.movieDetailsView,
                     arguments: movie.id,
                  );
                },);
              },
            ),
          );
        }

        if (historyState is HistoryError) {

          return Center(
            child: Text(
              historyState.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const CustomEmptyListWidget();
      },
    );
  }
}