import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

import '../../domain/entites/movie_entity.dart';

class CustomMovieCard extends StatelessWidget {
  final MovieEntity movie;
  final bool inSlider;
  final VoidCallback? onTap;

  const CustomMovieCard({
    super.key,
    required this.movie,
    this.inSlider = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: inSlider ? null : MediaQuery.of(context).size.width * .35,
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: inSlider ? StackFit.expand : StackFit.loose,
          children: [
            if (inSlider)
              CachedNetworkImage(
                imageUrl: movie.largeCoverImage,
                fit: BoxFit.cover,
                placeholder: (_, _) => _buildPlaceholder(),
                errorWidget: (_, _, _) => _buildPlaceholder(),
              )
            else
              AspectRatio(
                aspectRatio: 2 / 3,
                child: CachedNetworkImage(
                  imageUrl: movie.mediumCoverImage,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => _buildPlaceholder(),
                  errorWidget: (_, _, _) => _buildPlaceholder(),
                ),
              ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withAlpha(180),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Icon(Icons.movie_outlined, color: Colors.white24, size: 40),
      ),
    );
  }
}
