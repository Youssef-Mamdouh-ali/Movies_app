import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/home/profile_view/widget/custom_empty_list_widget.dart';


class CustomWatchListBodyWidget extends StatelessWidget {
  const CustomWatchListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWatchListEmpty = true;
    return isWatchListEmpty
        ? CustomEmptyListWidget()
        : Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: GridView.builder(
              shrinkWrap: true, 
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return Card(child: Text('Watch List Item $index'));
              },
              itemCount: 10,
            ),
          );
  }
}
