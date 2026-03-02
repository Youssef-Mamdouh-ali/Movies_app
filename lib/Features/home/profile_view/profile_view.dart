import 'package:flutter/material.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('profile',
              style: TextStyle(
                  color: Colors.white
              ),),
          )
        ],
      ),

    );
  }
}
