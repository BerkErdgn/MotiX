import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:motix_app/util/consts/motix_assets_consts.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authPage/login_page.dart';

class ConcentricAnimationOnboarding extends StatelessWidget {
  const ConcentricAnimationOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: ConcentricPageView(
          verticalPosition: screenWidth * 0.002,
          colors: pages.map((p) => p.bgColor).toList(),
          radius: screenWidth * 0.1,
          nextButtonBuilder: (context) => Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.001),
            child: Icon(
              Icons.navigate_next,
              size: screenWidth * 0.08,
            ),
          ),
          itemCount: pages.length,
          scaleFactor: 2,
          onFinish: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('onBoard', true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          itemBuilder: (index) {
            final page = pages[index % pages.length];
            return SafeArea(
              child: _Page(page: page, index: index),
            );
          },
        ),
      ),
    );
  }
}//end class ConcentricAnimationOnboarding

// PageData
class PageData {
  final String? title;
  final Color bgColor;
  final Color textColor;
  final String? animationPath;
  final String? description;

  const PageData({
    this.title,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.animationPath,
    this.description,
  });
}

class _Page extends StatelessWidget {
  final PageData page;
  final int index;

  const _Page({Key? key, required this.page, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLastPage = index == pages.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (page.animationPath != null)
          Padding(
            padding: isLastPage
                ? EdgeInsets.only(top: 16.0, bottom: 10.0, left: 30.0)
                : EdgeInsets.only(top: 16.0, bottom: 10.0),
            child: Lottie.asset(page.animationPath!),
          ),
        Text(
          page.title ?? "",
          style: TextStyle(
            letterSpacing: 2,
            color: page.textColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 26),
        if (page.description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: page.textColor,
                  fontSize: 20,
                ),
                children: _getSpannedText(page.description!, page.textColor),
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  List<TextSpan> _getSpannedText(String text, Color textColor) {
    const highlightColor = Color.fromARGB(255, 250, 214, 130);
    final List<TextSpan> spans = [];
    final List<String> highlightWords = [
      OnboardingStrings.highlightText1,
      OnboardingStrings.highlightText2,
      OnboardingStrings.highlightText3,
      OnboardingStrings.highlightText4,
    ];

    text.splitMapJoin(
      RegExp(highlightWords.join('|')),
      onMatch: (match) {
        spans.add(TextSpan(
          text: match.group(0)!,
          style: const TextStyle(
            color: highlightColor,
            fontWeight: FontWeight.bold,
          ),
        ));
        return match.group(0)!;
      },
      onNonMatch: (nonMatch) {
        spans.add(TextSpan(
          text: nonMatch,
          style: TextStyle(
            color: textColor,
          ),
        ));
        return nonMatch;
      },
    );

    return spans;
  }
}//end class _Page

//Page data
final List<PageData> pages = [
  const PageData(
    title: OnboardingStrings.titlePage1,
    description: OnboardingStrings.descriptionPage1,
    bgColor: MotixColor.onboardingBlack,
    textColor: MotixColor.mainColorWhite,
    animationPath: MotixLottieJson.onboardingJson1,
  ),
  const PageData(
    title: OnboardingStrings.titlePage2,
    description: OnboardingStrings.descriptionPage2,
    bgColor: MotixColor.onboardingPink,
    textColor: MotixColor.mainColorWhite,
    animationPath: MotixLottieJson.onboardingJson2,
  ),
  const PageData(
    title: OnboardingStrings.titlePage3,
    description: OnboardingStrings.descriptionPage3,
    bgColor: MotixColor.onboardingBlue,
    textColor: MotixColor.mainColorWhite,
    animationPath: MotixLottieJson.onboardingJson3,
  ),
];
