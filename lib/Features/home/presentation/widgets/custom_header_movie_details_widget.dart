import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class CustomHeaderMovieDetailsWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

   const CustomHeaderMovieDetailsWidget({
    super.key,
    required this.imageUrl,
    required this.year,
    required this.title,
    required this.isBookmarked,
    required this.onBookmarkTap,
  });



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [

        SizedBox(
          height: screenHeight * 0.45,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.white),
          ),
        ),


        Positioned.fill(

          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 0.4],
                colors: [Colors.black.withOpacity(0.9), Colors.transparent],
              ),
            ),
          ),
        ),


        Positioned.fill(
          child: Center(
            child: GestureDetector(
              onTap: () {

              },
              child: SvgPicture.asset(
                AppAssets.play,
                width: 60,
                height: 60,
              ),
            ),
          ),
        ),


        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: onBookmarkTap,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border_rounded,
                    color: isBookmarked ? AppColors.primaryColor : Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),


        Positioned(
          bottom: 30,
          left: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                year,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
