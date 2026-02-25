import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_button.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,color: AppColors.primaryColor,),),
        backgroundColor: AppColors.darkColor,
        title: Text(
          "Forget Password",
          style: theme.bodyMedium?.copyWith(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24,
        children: [
          Image.asset(AppAssets.forgetPassword),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextFormFieldWidget(
              text: AppString.email,
              customPrefixWidget: SvgPicture.asset(AppAssets.emailIcon),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomElevatedButtonWidget(
              onPressed: () {},
              customChildWidget: Text(AppString.verifyEmail,style: theme.titleMedium,),
            ),
          ),
        ],
      ),
    );
  }
}
