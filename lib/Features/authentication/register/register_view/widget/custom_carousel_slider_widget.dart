import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarouselSliderWidget extends StatelessWidget {
  final List<Widget>? items;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  const CustomCarouselSliderWidget({super.key, this.onPageChanged, this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: 160,
          aspectRatio: 16 / 9,
          viewportFraction: 0.35,
          initialPage: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.easeInOut,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeFactor: 0.37,
          onPageChanged: onPageChanged,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
