import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:motix_app/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String logoGif = "assets/motix_logo.gif";
    double iconSize = 200;
    int iconDuration = 5000;
    return AnimatedSplashScreen(
      splash: Container(
        alignment: Alignment.center,
        child: Image.asset(
          logoGif,
          fit: BoxFit.contain,
        ),
      ),
      splashIconSize: iconSize,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
      duration: iconDuration,
      nextScreen: const OnBoardingScreen(),
    );
  }
}
