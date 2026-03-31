import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';

import '../../domain/entites/movie_entity.dart';
import 'custom_movie_card.dart';

class RecentMoviesSlider extends StatefulWidget {
  final List<MovieEntity> movies;

  const RecentMoviesSlider({super.key, required this.movies});

  @override
  State<RecentMoviesSlider> createState() => _RecentMoviesSliderState();
}

class _RecentMoviesSliderState extends State<RecentMoviesSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final featured = widget.movies.take(5).toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: CachedNetworkImage(
              key: ValueKey(_currentIndex),
              imageUrl: featured[_currentIndex].largeCoverImage,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(color: Colors.black),
              errorWidget: (_, _, _) => Container(color: Colors.black),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.85),
                  Colors.black,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: CarouselSlider(
              items: featured
                  .map(
                    (m) => CustomMovieCard(
                      movie: m,
                      inSlider: true,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PagesRoutesName.movieDetailsView,
                          arguments: m.id,
                        );
                      },
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * .42,
                viewportFraction: 0.6,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, _) =>
                    setState(() => _currentIndex = index),
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  featured[_currentIndex].title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  spacing: 12,
                  children: [
                    _chip(
                      context,
                      Icons.calendar_today_rounded,
                      featured[_currentIndex].year.toString(),
                    ),
                    _chip(
                      context,
                      Icons.star_rounded,
                      featured[_currentIndex].rating.toStringAsFixed(1),
                      iconColor: Colors.black,
                    ),
                    if (featured[_currentIndex].genres.isNotEmpty)
                      _chip(
                        context,
                        Icons.movie_filter_rounded,
                        featured[_currentIndex].genres.first,
                      ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            child: Text(
              'Recent Releases',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(
    BuildContext context,
    IconData icon,
    String label, {
    Color iconColor = Colors.white70,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: iconColor),
        ),
      ],
    );
  }
}
