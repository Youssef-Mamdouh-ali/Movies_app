import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class CustomContainerFilm extends StatelessWidget {
  const CustomContainerFilm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Image.asset(
              AppAssets.filmImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 13,
              ),
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.darkColor.withOpacity(0.7),
                ),
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('7.7'),
                    Image.asset(AppAssets.starImage, scale: 4.5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
