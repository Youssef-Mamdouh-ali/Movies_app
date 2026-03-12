import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class CustomCardWidget extends StatelessWidget {
  final String imagePath;
  final double rate ;


  const CustomCardWidget({super.key, required this.imagePath,required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.darkColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$rate',
                  style: const TextStyle(color: AppColors.whiteColor),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.star, color: AppColors.primaryColor, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}