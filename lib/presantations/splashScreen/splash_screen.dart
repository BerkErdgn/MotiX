import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/main_screen.dart';
import 'package:motix_app/presantations/authPage/login_page.dart';
import 'package:motix_app/presantations/onBoarding/onboarding_screen.dart';
import 'package:motix_app/util/consts/motix_assets_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<Widget> _getNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('onBoard') ?? false;
    final authenticated = Auth().checkIfUserSignIn();
    if (!hasSeenOnboarding) {
      return const ConcentricAnimationOnboarding();
    } else if (authenticated) {
      return MainScreen();
    } else {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    String logoGif = MotixGifs.MotixSplashScreenGif;
    double iconSize = 300;
    int iconDuration = 6000;

    return FutureBuilder<Widget>(
      future: _getNextScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: const CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: Text(SplashScreenStrings.errorMessage),
            ),
          );
        } else if (snapshot.hasData) {
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            nextScreen: snapshot.data!,
          );
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: Text(SplashScreenStrings.loadingMessage),
            ),
          );
        }
      },
    );
  }
}
