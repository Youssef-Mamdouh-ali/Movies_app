import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_project/Features/home/search_view/widgets/custom_container_film.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        title: CustomTextFormFieldWidget(
          text: 'Search',
          customPrefixWidget: SvgPicture.asset(AppAssets.searchIcon),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 8,
            childAspectRatio: 0.69,
          ),
          itemBuilder: (context, index) {
            return CustomContainerFilm();
          },
          itemCount: 8,
        ),
      ),
    );
  }
}
