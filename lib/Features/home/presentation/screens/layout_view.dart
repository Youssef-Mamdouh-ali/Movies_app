import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/home/presentation/screens/browse_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/home_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/profile_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/search_view.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
    int _selectedIndex = 0;
    final List<Widget> _pages = [
      HomeView(),
      SearchView(),
      BrowseView(),
      ProfileView()
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.darkColor ,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home_filled, 0),
                _buildNavItem(Icons.search, 1),
                _buildNavItem(Icons.explore_outlined, 2),
                _buildNavItem(Icons.account_circle, 3),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildNavItem(IconData icon, int index) {
      bool isSelected = _selectedIndex == index;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Icon(
          icon,
          size: 30,
          color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
        ),
      );
    }

  }

