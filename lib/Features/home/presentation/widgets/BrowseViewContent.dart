import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movies_app_project/Features/home/presentation/manger/layout_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/tab_bar_widget.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/utils/app_assets/app_assets.dart';
import '../screens/movie_details_view.dart';

class BrowseViewContent extends StatefulWidget {
  const BrowseViewContent({super.key});

  @override
  State<BrowseViewContent> createState() => _BrowseViewContentState();
}

class _BrowseViewContentState extends State<BrowseViewContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CategoryTabBar(
              onCategorySelected: (genre) {
                context.read<LayoutBloc>().add(GetMoviesEvent(genre));
              },
            ),            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<LayoutBloc, LayoutState>(
                builder: (context, state) {
                  if (state is BrowseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BrowseLoaded) {
                    final movies = state.movies;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];

                        return Bounceable(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailsView(movieId: movie.id),
                              ),
                            );
                          },
                          child: CustomCardWidget(
                            imagePath: movie.image,
                            rate: movie.rating,
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                        child: Text(
                          "Error loading movies",
                          style: TextStyle(color: Colors.white),
                        ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}