import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

import '../models/movie_card_model.dart';
import 'custom_movie_card.dart';

class CustomMoviesCategory extends StatelessWidget {
  final String categoryName;
  final List<MovieCardModel> data;

  const CustomMoviesCategory({
    super.key,
    required this.categoryName,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(categoryName, style: Theme.of(context).textTheme.titleLarge),
              GestureDetector(
                onTap: () {},
                child: Row(
                  spacing: 2,
                  children: [
                    Text(
                      AppString.viewMore,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.primaryColor,
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
              itemBuilder: (BuildContext context, int index) {
                return CustomMovieCard(data: data[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 16);
              },
              itemCount: data.length,
            ),
          ),
        ],
      ),
    );
  }
}
