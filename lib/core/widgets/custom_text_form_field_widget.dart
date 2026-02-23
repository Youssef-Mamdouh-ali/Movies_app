import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget customPrefixWidget;
  final int maxLines;
  final Widget? customSuffixWidget;

  const CustomTextFormFieldWidget({
    super.key,
    required this.text,
    this.controller,
    this.validator,
    this.isPassword = false,
    required this.customPrefixWidget,
    this.customSuffixWidget,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      style: theme.textTheme.bodyLarge,
      cursorColor: AppColors.primaryColor,
      obscureText: isPassword,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: text,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: customPrefixWidget,
        ),
        suffixIcon: customSuffixWidget != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: customSuffixWidget,
              )
            : null,
      ),
    );
  }
}
