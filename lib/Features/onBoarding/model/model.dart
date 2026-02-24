import 'package:flutter/animation.dart';

class OnBoardingModel {
  final String tittle;
  final String? description;
  final String image;
  final VoidCallback? onPressed;
  void Function()? onArrowBack;

  OnBoardingModel({
    required this.tittle,
     this.description,
    required this.image,
    this.onPressed,
    this.onArrowBack,
  });
}
