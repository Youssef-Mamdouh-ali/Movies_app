import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/authentication/presentation/manager/auth_bloc.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';

class CustomHeaderContainerProfileWidget extends StatelessWidget {
  final String nameText;
  final String imageUrl;
  final int wishListCount;
  final int historyCount;
  const CustomHeaderContainerProfileWidget({
    super.key,
    required this.nameText,
    required this.imageUrl,
    required this.wishListCount,
    required this.historyCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(color: AppColors.greyColor),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 52,
          bottom: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 59,
                      backgroundImage: AssetImage(imageUrl),
                    ),
                    SizedBox(height: 15),
                    Text(nameText, style: theme.textTheme.titleLarge),
                  ],
                ),
                SizedBox(width: 46),
                Column(
                  children: [
                    Text(wishListCount.toString(), style: theme.textTheme.displayMedium),
                    SizedBox(height: 20),
                    Text(
                      appLocalizations.wishList,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(width: 38),
                Column(
                  children: [
                    Text(historyCount.toString(), style: theme.textTheme.displayMedium),
                    SizedBox(height: 20),
                    Text(
                      appLocalizations.history,
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
                      appLocalizations.editProfile,
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
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthenticationEventSignOut());
                    },
                    backgroundColor: AppColors.redColor,
                    boarderColor: AppColors.redColor,
                    customChildWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(appLocalizations.exit, style: theme.textTheme.titleLarge),
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
