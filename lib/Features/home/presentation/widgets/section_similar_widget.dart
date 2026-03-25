
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_state.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_movie_card.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';

import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class SectionSimilarWidget extends StatelessWidget {
  const SectionSimilarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
      previous.suggestionsState != current.suggestionsState,
      builder: (context, state) {
        final suggestionsState = state.suggestionsState;

        if (suggestionsState is MovieSuggestionsLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        } else if (suggestionsState is MovieSuggestionsError) {
          return Center(child: Text(suggestionsState.message, style: const TextStyle(color: Colors.white)));
        } else if (suggestionsState is MovieSuggestionsSuccess) {
          final movies = suggestionsState.movies;

          if (movies.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appLocalizations.similar, style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return CustomMovieCard(
                    movie: movie,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        PagesRoutesName.movieDetailsView,
                        arguments: movies[index].id,
                      );
                    },
                  );
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}