import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_project/core/utils/extension/padding_extension.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class CustomStatsContainer extends StatelessWidget {
  final String iconPath;
  final String number;
  const CustomStatsContainer({
    super.key,
    required this.iconPath,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.greyColor,
      ),
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              SvgPicture.asset(iconPath),
              Text(number, style: theme.textTheme.bodyLarge),
            ],
          ).setHorizontalAndVerticalPadding(
            context,
            8,
            16,
            enableMediaQuery: false,
          ),
    );
  }
}
