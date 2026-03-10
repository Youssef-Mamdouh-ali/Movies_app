import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import '../models/movie_card_model.dart';

class CustomMovieCard extends StatelessWidget {
  final MovieCardModel data;
  final bool inSlider;

  const CustomMovieCard({super.key, required this.data, this.inSlider = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inSlider ? null : MediaQuery.of(context).size.width * .35,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(data.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.darkColor.withAlpha(150),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(data.rate, style: Theme.of(context).textTheme.bodyLarge),
            Icon(Icons.star, size: 18, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
