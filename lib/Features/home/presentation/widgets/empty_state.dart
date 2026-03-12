import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';

class CustomEmptyStateWidget extends StatelessWidget {
  const CustomEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double availableHeight = MediaQuery.of(context).size.height - 340;

    return Container(
      width: double.infinity,
      height: availableHeight,
      alignment: Alignment.center,
      child: LottieBuilder.asset(AppAssets.popcornAnimation),
    );
  }
}
