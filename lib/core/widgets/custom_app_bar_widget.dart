import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/extension/padding_extension.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? customLeadingWidget;
  final Widget? customTitleWidget;
  final List<Widget>? customActionListWidget;
  int? titleSpacing;


   CustomAppBarWidget({
    super.key,
    this.titleSpacing=0,
    this.customLeadingWidget,
     this.customTitleWidget,
    this.customActionListWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: customLeadingWidget,
      title: customTitleWidget,
      actions: customActionListWidget,
    ).setHorizontalPaddingOnWidget(16);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
