import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/api/api_constants.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/custom_movie_category.dart';
import '../widgets/recent_movie_slider.dart';
import '../widgets/skeleton_widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: Colors.black,
            backgroundColor: Colors.black,
            onRefresh: () async {
              context.read<HomeBloc>().add(const HomeStarted());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 28,
                children: [
                  _buildRecentSection(state),

                  _buildCategoriesSection(context, state),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentSection(HomeState state) {
    final recentState = state.recentState;

    if (recentState is RecentMoviesLoading ||
        recentState is RecentMoviesInitial) {
      return const SliderSkeleton();
    }

    if (recentState is RecentMoviesError) {
      return _ErrorSection(message: recentState.message, height: 300);
    }

    if (recentState is RecentMoviesLoaded && recentState.movies.isNotEmpty) {
      return RecentMoviesSlider(movies: recentState.movies);
    }

    return const SizedBox.shrink();
  }

  Widget _buildCategoriesSection(BuildContext context, HomeState state) {
    final categoryState = state.categoryState;

    if (categoryState is CategoryMoviesLoading ||
        categoryState is CategoryMoviesInitial) {
      return Column(
        spacing: 24,
        children: List.generate(3, (_) => const CategorySkeleton()),
      );
    }

    if (categoryState is CategoryMoviesError) {
      return _ErrorSection(message: categoryState.message);
    }

    if (categoryState is CategoryMoviesLoaded) {
      final map = categoryState.categoryMovies;

      return Column(
        spacing: 24,
        children: ApiConstants.suggestionGenres.map((genre) {
          final movies = map[genre] ?? [];
          if (movies.isEmpty) return const SizedBox.shrink();

          return CustomMoviesCategory(
            categoryName: genre,
            movies: movies,
            onViewMore: () {
              // TODO: Navigate to genre listing page
            },
          );
        }).toList(),
      );
    }

    return const SizedBox.shrink();
  }
}

class _ErrorSection extends StatelessWidget {
  final String message;
  final double? height;

  const _ErrorSection({required this.message, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: Colors.redAccent, size: 40),
            Text(
              message,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () =>
                  context.read<HomeBloc>().add(const HomeStarted()),
              child: const Text('Retry',
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
