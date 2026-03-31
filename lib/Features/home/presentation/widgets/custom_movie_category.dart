import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

import '../../domain/entites/movie_entity.dart';
import 'custom_movie_card.dart';

class CustomMoviesCategory extends StatelessWidget {
  final String categoryName;
  final List<MovieEntity> movies;
  final VoidCallback? onViewMore;

  const CustomMoviesCategory({
    super.key,
    required this.categoryName,
    required this.movies,
    this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(categoryName, style: Theme.of(context).textTheme.titleLarge),
              GestureDetector(
                onTap: onViewMore,
                child: Row(
                  spacing: 2,
                  children: [
                    Text(
                      'View More',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * .22,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  CustomMovieCard(movie: movies[index] ,
                   /// TODO : Navigation
                   // onTap: ,

                  ),
            ),
          ),
        ],
      ),
    );
  }
}
