import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';

class CustomHeaderContainerProfileWidget extends StatelessWidget {
  final String nameText;
  final String imagePath;
  const CustomHeaderContainerProfileWidget({
    super.key,
    required this.nameText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 300,
      decoration: BoxDecoration(color: AppColors.greyColor),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 52,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 59,
                      backgroundImage: AssetImage(imagePath),
                    ),
                    SizedBox(height: 15),
                    Text(nameText, style: theme.textTheme.titleLarge),
                  ],
                ),
                SizedBox(width: 46),
                Column(
                  children: [
                    Text("12", style: theme.textTheme.displayMedium),
                    SizedBox(height: 20),
                    Text(
                      AppString.wishList,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(width: 38),
                Column(
                  children: [
                    Text("10", style: theme.textTheme.displayMedium),
                    SizedBox(height: 20),
                    Text(
                      AppString.history,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PagesRoutesName.updateProfileScreen,
                      );
                    },
                    customChildWidget: Text(
                      AppString.editProfile,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: CustomElevatedButtonWidget(
                    onPressed: () {},
                    backgroundColor: AppColors.redColor,
                    boarderColor: AppColors.redColor,
                    customChildWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.exit, style: theme.textTheme.titleLarge),
                        SizedBox(width: 5),
                        Icon(Icons.logout, color: AppColors.whiteColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
