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
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.greyColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 52, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// --- Row العلوي (البيانات) ---
            Row(
              children: [
                // 1. الصورة والاسم في جهة اليسار
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.12, // حجم ريسبونسيف
                        backgroundImage: imageUrl.isNotEmpty
                            ? AssetImage(imageUrl)
                            : null,
                        child: imageUrl.isEmpty ? const Icon(Icons.person, size: 40) : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        nameText,
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // 2. إحصائيات الـ WishList والـ History في جهة اليمين
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(theme, wishListCount.toString(), appLocalizations.wishList),
                      _buildStatItem(theme, historyCount.toString(), appLocalizations.history),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// --- Row الأزرار (Edit & Exit) ---
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, PagesRoutesName.updateProfileScreen);
                    },
                    customChildWidget: Text(
                      appLocalizations.editProfile,
                      style: theme.textTheme.titleLarge?.copyWith(color: AppColors.darkColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
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
                        const SizedBox(width: 5),
                        const Icon(Icons.logout, color: AppColors.whiteColor),
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

  // Widget مساعد للإحصائيات لمنع تكرار الكود وحل الـ Overflow
  Widget _buildStatItem(ThemeData theme, String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count, style: theme.textTheme.displayMedium),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}