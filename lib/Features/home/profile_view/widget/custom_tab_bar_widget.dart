import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTabBarWidget extends StatelessWidget {
  final List<String> tabTitles;
  final List<String> tabIcons;
  final void Function(int)? onTap;
  const CustomTabBarWidget({
    super.key,
    required this.tabTitles,
    required this.tabIcons,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorWeight: 2,
      onTap: onTap,
      tabs: List.generate(tabTitles.length, (index) {
        return Tab(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(tabIcons[index], width: 28, height: 24),
              SizedBox(height: 8),
              Text(tabTitles[index]),
            ],
          ),
        );
      }),
    );
  }
}
