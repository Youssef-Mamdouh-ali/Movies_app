import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';

import '../../../core/utils/app_assets/app_assets.dart';
import '../browse_view/browse_view.dart';
import '../home_view/home_view.dart';
import '../profile_view/profile_view.dart';
import '../search_view/search_view.dart';

class LayoutView extends StatefulWidget {
   LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeView(),
      BrowseView(),
      SearchView(),
      ProfileView(),
    ];
    return Scaffold(

      body: screens[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          iconSize: 24,
          currentIndex: 0,
          onTap: (index) {
            currentIndex = index;

            setState(() {});
          },
          elevation: 0,

          items: [
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppAssets.emailIcon,color: Colors.black,),
              activeIcon: SvgPicture.asset(AppAssets.emailIcon,color: Colors.black,),

              label: 'Home',

            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.emailIcon,color: Colors.black,),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.emailIcon,color: Colors.black,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.emailIcon,color: Colors.black,),
              label: 'Profile',
            ),
          ],
        ),
      ),



    );
  }
}
