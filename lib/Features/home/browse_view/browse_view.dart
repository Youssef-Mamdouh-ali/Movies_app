import 'package:flutter/material.dart';
class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('browse',
              style: TextStyle(
                  color: Colors.white
              ),),
          )
        ],
      ),

    );
  }
}
