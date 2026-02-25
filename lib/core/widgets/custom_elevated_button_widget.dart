import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final Widget? customChildWidget;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? boarderColor;

  const CustomElevatedButtonWidget({
    super.key,
    this.onPressed,
    this.customChildWidget,
    this.backgroundColor,
    this.boarderColor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        alignment: Alignment.center,
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: boarderColor ??AppColors.primaryColor),
        ),
      ),
      child: customChildWidget,
    );
  }
}
