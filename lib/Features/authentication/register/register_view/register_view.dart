import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_project/core/widgets/custom_language_switch_widget.dart';
import 'package:movies_app_project/Features/authentication/register/register_data/register_data_model.dart';
import 'package:movies_app_project/Features/authentication/register/register_view/widget/custom_carousel_slider_widget.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/extension/padding_extension.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_app_bar_widget.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int selectedIndex = 1;
  bool isActivePassword = true;
  bool isActiveConfirmPassword = true;
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        customTitleWidget: Text(
          AppString.register,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        customLeadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCarouselSliderWidget(
              items: RegisterDataModel.registerList.map((avater) {
                return Container(
                  width: 120,
                  height: 118,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset(
                      avater.imagePath,
                      fit: BoxFit.cover,
                      width: 110,
                      height: 110,
                    ),
                  ),
                );
              }).toList(),
              onPageChanged: (index, reason) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 10),
            Text(AppString.avatar, style: theme.textTheme.bodyLarge),
            SizedBox(height: 12),
            CustomTextFormFieldWidget(
              text: AppString.name,
              customPrefixWidget: SvgPicture.asset(
                AppAssets.nameIcon,
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(height: 24),
            CustomTextFormFieldWidget(
              text: AppString.email,
              customPrefixWidget: SvgPicture.asset(
                AppAssets.emailIcon,
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(height: 24),
            CustomTextFormFieldWidget(
              text: AppString.password,
              isPassword: isActivePassword,
              customPrefixWidget: SvgPicture.asset(
                AppAssets.passwordIcon,
                width: 24,
                height: 24,
              ),
              customSuffixWidget: InkWell(
                onTap: () {
                  setState(() {
                    isActivePassword = !isActivePassword;
                  });
                },
                child: isActivePassword
                    ? SvgPicture.asset(
                  AppAssets.eyeIcon,
                  width: 20,
                  height: 20,
                )
                    : Icon(
                  Icons.remove_red_eye_sharp,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomTextFormFieldWidget(
              text: AppString.confirmPassword,
              isPassword: isActiveConfirmPassword,
              customPrefixWidget: SvgPicture.asset(
                AppAssets.passwordIcon,
                width: 24,
                height: 24,
              ),
              customSuffixWidget: InkWell(
                onTap: () {
                  setState(() {
                    isActiveConfirmPassword = !isActiveConfirmPassword;
                  });
                },
                child: isActiveConfirmPassword
                    ? SvgPicture.asset(
                  AppAssets.eyeIcon,
                  width: 20,
                  height: 20,
                )
                    : Icon(
                  Icons.remove_red_eye_sharp,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomTextFormFieldWidget(
              text: AppString.phoneNumber,
              customPrefixWidget: SvgPicture.asset(
                AppAssets.phoneIcon,
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButtonWidget(
                    onPressed: () {},
                    customChildWidget: Text(
                      AppString.headerCreateAccount,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppString.alreadyHaveAccount,
                      style: theme.textTheme.bodyMedium,
                    ),
                    WidgetSpan(
                      child: Bounceable(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PagesRoutesName.loginView,
                          );
                        },
                        child: Text(
                          AppString.login,
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
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLanguageSwitchWidget(
                  onTapLeft: () {
                    if (isArabic) {
                      setState(() {
                        isArabic = !isArabic;
                      });
                    }
                  },
                  onTapRight: () {
                    if (!isArabic) {
                      setState(() {
                        isArabic = !isArabic;
                      });
                    }
                  },
                  isArabic: isArabic,
                ),
              ],
            ),
          ],
        ).setHorizontalAndVerticalPadding(
          context,
          18,
          8,
          enableMediaQuery: false,
        ),
      ),
    );
  }
}




