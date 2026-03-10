import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

import '../../../core/models/movie_card_model.dart';
import '../../../core/widgets/custom_movie_card.dart';
import '../../../core/widgets/custom_movies_category.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<MovieCardModel> dataList = [
      MovieCardModel(rate: '7.7', imagePath: 'assets/images/home_img.png'),
      MovieCardModel(rate: '7.7', imagePath: 'assets/images/home_img.png'),
      MovieCardModel(rate: '7.7', imagePath: 'assets/images/home_img.png'),
    ];
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SingleChildScrollView(
        child: Column(
          spacing: 30,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_img.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: CarouselSlider(
                items: [
                  CustomMovieCard(
                    data: MovieCardModel(
                      rate: '7.7',
                      imagePath: 'assets/images/home_img.png',
                    ),
                    inSlider: true,
                  ),
                  CustomMovieCard(
                    data: MovieCardModel(
                      rate: '7.7',
                      imagePath: 'assets/images/home_img.png',
                    ),
                    inSlider: true,
                  ),
                  CustomMovieCard(
                    data: MovieCardModel(
                      rate: '7.7',
                      imagePath: 'assets/images/home_img.png',
                    ),
                    inSlider: true,
                  ),
                ],
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .4,
                  viewportFraction: 0.6,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            CustomMoviesCategory(categoryName: 'Action', data: dataList),
            CustomMoviesCategory(categoryName: 'Drama', data: dataList),
            CustomMoviesCategory(categoryName: 'Comedy', data: dataList),
          ],
        ),
      ),
    );
  }
}
