import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';


import '../../../core/utils/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../model/model.dart';
import '../widget/custom_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// PAGE VIEW
            PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              children: [
                CustomScreen(
                  button: CustomElevatedButton(
                    text: AppString.exploreNow,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  onBoardingModel: OnBoardingModel(
                    tittle: "Discover Movies",
                    description:
                        "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
                    image: AppAssets.onboarding1,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                ),
                CustomScreen(
                  button: CustomElevatedButton(
                    text: AppString.next,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  onBoardingModel: OnBoardingModel(
                    tittle: "Discover Movies",
                    description:
                        "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
                    image: AppAssets.onboarding2,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  child: true,
                ),
                CustomScreen(
                  button: CustomElevatedButton(
                    text: 'Next',
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  secondButton: CustomElevatedButton(
                    color: Colors.transparent,
                    text: 'Back',
                    textcolor: AppColors.primaryColor,
                    onPressed: () {
                      onArrowBack(selectedPage);
                    },
                  ),
                  onBoardingModel: OnBoardingModel(
                    tittle: "Explore All Genres",
                    description:
                        "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
                    image:AppAssets.onboarding3,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  child: true,
                ),
                CustomScreen(
                  button: CustomElevatedButton(
                    text: 'Next',
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  secondButton: CustomElevatedButton(
                    color: Colors.transparent,
                    text: 'Back',
                    textcolor: AppColors.primaryColor,
                    onPressed: () {
                      onArrowBack(selectedPage);
                    },
                  ),
                  onBoardingModel: OnBoardingModel(
                    tittle: "Discover Movies",
                    description:
                        "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
                    image: AppAssets.onboarding4,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  child: true,
                ),
                CustomScreen(
                  button: CustomElevatedButton(
                    text: 'Next',
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  secondButton: CustomElevatedButton(
                    color: Colors.transparent,
                    text: 'Back',
                    textcolor: AppColors.primaryColor,
                    onPressed: () {
                      onArrowBack(selectedPage);
                    },
                  ),
                  onBoardingModel: OnBoardingModel(
                    tittle: "Rate, Review, and Learn",
                    description:
                        "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
                    image: AppAssets.onboarding5,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  child: true,
                ),
                CustomScreen(
                  button: CustomElevatedButton(
                    text: 'Finish',
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  secondButton: CustomElevatedButton(
                    color: Colors.transparent,
                    text: 'Back',
                    textcolor: AppColors.primaryColor,
                    onPressed: () {
                      onArrowBack(selectedPage);
                    },
                  ),
                  onBoardingModel: OnBoardingModel(
                    tittle: "Start Watching Now",
                    image: AppAssets.onboarding6,
                    onPressed: () {
                      onNext(selectedPage);
                    },
                  ),
                  child: true,
                ),
              ],
            ),
        
            /// BACK ARROW
            if (selectedPage > 0)
              Bounceable(
                onTap: () {
                  print("Arrow tapped");
                  onArrowBack(selectedPage);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Colors.white
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              )
            else
              SizedBox(),
          ],
        ),
      ),
    );
  }

  void onNext(int index) {
    if (index < 5) {
      _pageController.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, PagesRoutesName.loginView);
    }
    setState(() {});
  }

  void onArrowBack(int index) {
    if (index > 0) {
      _pageController.animateToPage(
        index - 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      setState(() {});
    }
  }
}
