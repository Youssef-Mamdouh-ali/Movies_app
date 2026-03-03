import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/home/profile_view/widget/custom_header_container_profile_widget.dart';
import 'package:movies_app_project/Features/home/profile_view/widget/custom_history_list_body_widget.dart';
import 'package:movies_app_project/Features/home/profile_view/widget/custom_watch_list_body_widget.dart';
import 'package:movies_app_project/Features/home/profile_view/widget/custom_tab_bar_widget.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: selectedIndex,
          length: 2,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomHeaderContainerProfileWidget(
                  nameText: AppString.nameText,
                  imagePath: AppAssets.hoodieBoyProfileBackgroundImg,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.greyColor),
                  child: CustomTabBarWidget(
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    tabTitles: [AppString.watchList, AppString.history],
                    tabIcons: [AppAssets.watchListIcon, AppAssets.folderIcon],
                  ),
                ),
                selectedIndex == 0
                    ? const CustomWatchListBodyWidget()
                    : const CustomHistoryListBodyWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
