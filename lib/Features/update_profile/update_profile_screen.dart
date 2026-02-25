import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

import '../../core/widgets/custom_elevated_button_widget.dart';
import '../../core/widgets/custom_text_form_field_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final List<String> avatarImages = [
    AppAssets.beardedGamerProfileBackgroundImg,
    AppAssets.beardedManProfileBackgroundImg,
    AppAssets.blondeFemaleProfileBackgroundImg,
    AppAssets.catEarsFemaleProfileBackgroundImg,
    AppAssets.coolGamerProfileBackgroundImg,
    AppAssets.gamerGirlProfileBackgroundImg,
    AppAssets.gentlemanProfileBackgroundImg,
    AppAssets.hoodieBoyProfileBackgroundImg,
    AppAssets.redHeadFemaleProfileBackgroundImg,
  ];
  String selectedAvatar = AppAssets.hoodieBoyProfileBackgroundImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        leading: Icon(
          Icons.arrow_back,
          color: AppColors.primaryColor,
          size: 26,
        ),
        title: Text(
          "Pick Avatar",
          style: TextStyle(color: AppColors.primaryColor, fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Avatar Image
              GestureDetector(
                onTap: () {
                  _showAvatarBottomSheet(context);
                },
                child: CircleAvatar(
                  radius: 60,
                  child: ClipOval(
                    child: Image.asset(
                      selectedAvatar,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              CustomTextFormFieldWidget(
                customPrefixWidget: Icon(
                  Icons.person,
                  color: AppColors.whiteColor,
                ),
                text: "Your Name",
              ),
              SizedBox(height: 10),
              CustomTextFormFieldWidget(
                customPrefixWidget: Icon(
                  Icons.phone,
                  color: AppColors.whiteColor,
                ),
                text: "Phone number",
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              CustomElevatedButtonWidget(
                onPressed: () {},
                backgroundColor: AppColors.redColor,
                customChildWidget: Text(
                  "Delete Account",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 17),
                ),
                boarderColor: AppColors.redColor,
              ),
              SizedBox(height: 16),
              CustomElevatedButtonWidget(
                onPressed: () {},
                backgroundColor: AppColors.primaryColor,
                customChildWidget: Text(
                  "Update Data",
                  style: TextStyle(color: AppColors.darkColor, fontSize: 17),
                ),
                boarderColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAvatarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: avatarImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatarImages[index];
                  });

                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(avatarImages[index], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
