import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

import '../../../core/utils/extension/padding_extension.dart';
import '../../../core/widgets/custom_app_bar_widget.dart';
import '../../../core/widgets/custom_card_widget.dart';
import '../../../core/widgets/custom_text_form_field_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBarWidget(

        customTitleWidget: CustomTextFormFieldWidget(
          text: 'Search',
          customPrefixWidget: Icon(Icons.search, color: AppColors.primaryColor),
          maxLines: 1,
        ),
      ),

      body: Column(
        children: [
          // CustomAppBarWidget(
          //   customTitleWidget: CustomTextFormFieldWidget(
          //     text: 'search',
          //     customPrefixWidget: Icon(
          //       Icons.search,
          //       color: AppColors.primaryColor,
          //     ),
          //     maxLines: 1,
          //   ),
          // ),
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
    );
  }
}
