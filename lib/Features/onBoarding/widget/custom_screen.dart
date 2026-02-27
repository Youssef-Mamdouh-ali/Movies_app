import 'package:flutter/material.dart';
import '../model/model.dart';

class CustomScreen extends StatelessWidget {
  bool child;
  final OnBoardingModel onBoardingModel;
  final Widget button;
  final Widget? secondButton;

  CustomScreen({
    super.key,
    this.child = false,
    required this.onBoardingModel,
    required this.button,
    this.secondButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            onBoardingModel.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          Container(
            child: child
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xff121312),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              onBoardingModel.tittle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: onBoardingModel.description !=null,
                              child: Text(
                                onBoardingModel.description ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white30,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            // if (widget.index > 1)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                button,
                                if (secondButton != null) ...[
                                  const SizedBox(height: 12),
                                  secondButton!,
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Spacer(),
                        Text(
                          textAlign: TextAlign.center,
                          'Find Your Next\nFavorite Movie Here',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white30,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 24),
                        Column(
                          children: [
                            button,
                            if (secondButton != null) ...[
                              const SizedBox(height: 12),
                              secondButton!,
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
