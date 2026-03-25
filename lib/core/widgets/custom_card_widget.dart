import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class CustomCardWidget extends StatelessWidget {
  final String imagePath;
  final void Function()? onTap;

  const CustomCardWidget({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('4.5', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 4),
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
