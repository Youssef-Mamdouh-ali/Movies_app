import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_empty_list_widget.dart';

class CustomHistoryListBodyWidget extends StatelessWidget {
  const CustomHistoryListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isHistoryListEmpty = false;
    return isHistoryListEmpty
        ? CustomEmptyListWidget()
        : Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0,top: 24.0),
          child: GridView.builder(
            shrinkWrap: true, 
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: Center(child: Text('History Item $index')),
                );
              },
              itemCount: 10,
            )
        );
  }
}
