import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/home/browse_view/widget/tab_bar_widget.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

import '../../../core/utils/app_assets/app_assets.dart';
import '../../../core/widgets/custom_card_widget.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            CategoryTabBar(),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.70,
                ),

                // padding: EdgeInsets.all(16),
                itemBuilder: (context, index) =>
                    CustomCardWidget(imagePath: AppAssets.onboarding2),
                // separatorBuilder: (context, index) => SizedBox(height: 30,width: 50,),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}