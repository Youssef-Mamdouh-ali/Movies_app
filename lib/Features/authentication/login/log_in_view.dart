import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/extension/padding_extension.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';

import '../../../core/widgets/custom_language_switch_widget.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  bool isActive = true;
  bool isArabic = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppAssets.headerLogo,
              width: 120,
                height: 118,
                fit: BoxFit.cover,
            ),
            SizedBox(height: 69),
            CustomTextFormFieldWidget(
              text: AppString.email,
              customPrefixWidget: SvgPicture.asset(AppAssets.emailIcon,
                width: 24,
                height: 24,
              )
            ),
            SizedBox(height: 22.5),
            CustomTextFormFieldWidget(
              text: AppString.password,
              isPassword: isActive,
              customPrefixWidget:SvgPicture.asset(AppAssets.passwordIcon,
                width: 24,
                height: 24,
              ) ,
              customSuffixWidget: InkWell(
                onTap: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
                child: isActive
                    ? SvgPicture.asset(AppAssets.eyeIcon,
                  width: 24,
                  height: 24,
                   )
                    : Icon(
                        Icons.remove_red_eye_sharp,
                  color: AppColors.whiteColor,
                      ),
              ),
            ),
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, PagesRoutesName.forgetPasswordView
                    );
                  },
                  child: Text(
                    AppString.forgetPassword,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: 33),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                   Navigator.pushNamed(context, PagesRoutesName.updateProfileScreen);
                    },
                    customChildWidget: Text(
                      AppString.login,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 23),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppString.doNotHaveAccount,
                      style: theme.textTheme.bodyMedium,
                    ),
                    WidgetSpan(
                      child: Bounceable(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PagesRoutesName.registerView);
                        },
                        child: Text(
                          AppString.register,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 23),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 99.5,
                    endIndent: 15,
                  ),
                ),
                Text(AppString.or,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryColor,
                    )),
                Expanded(
                  child: Divider(
                    indent: 15,
                    endIndent: 99.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButtonWidget(
                    onPressed: () {},
                    customChildWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.googleIcon,
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          AppString.loginWithGoogle,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLanguageSwitchWidget(isArabic: isArabic),
              ],
            )
          ],
        ).setHorizontalAndVerticalPadding(
          context,
          16,
          48,
          enableMediaQuery: false,
        ),
      ),
    );
  }
}
