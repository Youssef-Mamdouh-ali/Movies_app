import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/home/domain/entites/movie_entity.dart'; // ✅ تم استيراد الـ Entity
import 'package:movies_app_project/Features/home/presentation/bloc/home_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_event.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_state.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_header_movie_details_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_stats_container.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/section_cast_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/section_genres_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/section_screen_shots_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/section_similar_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/section_summary_widget.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/extension/padding_extension.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsView extends StatefulWidget {
  final int movieId;

  const MovieDetailsView({super.key, required this.movieId});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  Future<void> _launchMovieUrl(String? urlString) async {
    if (urlString == null || urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The viewing link is currently unavailable.ً")),
      );
      return;
    }

    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(FetchMovieDetails(widget.movieId));
    context.read<HomeBloc>().add(const FetchProfileData());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.movieDetailsState != current.movieDetailsState ||
            previous.watchListState != current.watchListState,
        builder: (context, state) {
          if (state.movieDetailsState is MovieDetailsSuccessState) {
            final movie =
                (state.movieDetailsState as MovieDetailsSuccessState).movie;


            bool isBookmarked = false;
            if (state.watchListState is WatchListSuccess) {
              final list = (state.watchListState as WatchListSuccess).movies;
              isBookmarked = list.any((m) => m.id == movie.id);
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomHeaderMovieDetailsWidget(
                    imageUrl: movie.largeCoverImage,
                    year: movie.year.toString(),
                    title: movie.title,
                    isBookmarked: isBookmarked,
                    onBookmarkTap: () {
                      if (isBookmarked) {
                        context.read<HomeBloc>().add(
                          RemoveFromWatchList(movie.id),
                        );
                      } else {
                        context.read<HomeBloc>().add(AddToWatchList(movie));
                      }
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildWatchSection(theme, movie),
                      const SizedBox(height: 24),
                      _buildStatsRow(movie),
                      const SizedBox(height: 24),
                      SectionScreenShotsWidget(images: movie.screenshots ?? []),
                      const SizedBox(height: 20),
                      const SectionSimilarWidget(),
                      const SizedBox(height: 20),
                      SectionSummaryWidget(bodySummary: movie.summary),
                      const SizedBox(height: 20),
                      SectionCastWidget(castList: movie.cast ?? []),
                      const SizedBox(height: 20),
                      SectionGenresWidget(genres: movie.genres),
                      const SizedBox(height: 20),
                    ],
                  ).setHorizontalPaddingOnWidget(16.0),
                ],
              ),
            );
          } else if (state.movieDetailsState is MovieDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.redColor),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildWatchSection(ThemeData theme, MovieEntity movie) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButtonWidget(
            onPressed: () => _launchMovieUrl(movie.url),
            backgroundColor: AppColors.redColor,
            boarderColor: AppColors.redColor,
            customChildWidget: Text(
              appLocalizations.watch,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(MovieEntity movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomStatsContainer(
          iconPath: AppAssets.favourite,
          number: "${movie.likeCount ?? 0}",
        ),
        CustomStatsContainer(
          iconPath: AppAssets.clock,
          number: "${movie.runtime} min",
        ),
        CustomStatsContainer(
          iconPath: AppAssets.star,
          number: "${movie.rating}",
        ),
      ],
    );
  }
}
