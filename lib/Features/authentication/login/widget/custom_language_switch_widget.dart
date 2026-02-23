import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';


class CustomLanguageSwitchWidget extends StatelessWidget {
  final Function()? onTapLeft;
  final Function()? onTapRight;
  final bool isArabic;
  const CustomLanguageSwitchWidget(
      {super.key, required this.isArabic, this.onTapLeft, this.onTapRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91,
      height: 38,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1.8,
          )),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedAlign(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTapLeft,
                  child: Center(
                    child: SvgPicture.asset(AppAssets.usaFlagIcon ,width: 30,height: 30,)
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTapLeft,
                  child: Center(
                    child: SvgPicture.asset(AppAssets.egyptFlagIcon ,width: 30,height: 30,),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
