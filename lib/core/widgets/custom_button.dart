import 'package:flutter/material.dart';

import '../utils/theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textcolor;

  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.color,
    this.textcolor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          color ?? AppColors.primaryColor,
        ),

        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
            side: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          text,
          style: TextStyle(
            color: textcolor ?? Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
