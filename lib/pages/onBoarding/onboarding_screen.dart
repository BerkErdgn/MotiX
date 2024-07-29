import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../auth_page/login_page.dart';

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
          onFinish: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          itemBuilder: (index) {
            final page = pages[index % pages.length];
            return SafeArea(
              child: _Page(page: page),
            );
          },
        ),
      ),
    );
  }
}

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

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (page.animationPath != null)
          Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 10.0),
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
      'Yapay zeka',
      'Motivasyon sözlerinizi',
      'paylaşarak',
      'not alın'
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
}

final List<PageData> pages = [
  const PageData(
    title: "Kendi Koçunuz Olun",
    description:
    "Yapay zeka destekli koçluk sistemimizle sorunlarınıza çözüm bulun ve hedeflerinize ulaşın.",
    bgColor: Color.fromARGB(255, 21, 21, 21),
    textColor: Colors.white,
    animationPath: 'assets/animations/ucuncu.json',
  ),
  const PageData(
    title: "Motivasyonunuzu Paylaşın",
    description:
    "Motivasyon sözlerinizi ve sorunlarınızı paylaşarak destek alın ve diğer kullanıcılardan ilham alın.",
    bgColor: Color(0xFFC73659),
    textColor: Colors.white,
    animationPath: 'assets/animations/birinci.json',
  ),
  const PageData(
    title: "Planlarınızı Organize Edin",
    description:
    "Yapacaklarınızı not alın ve gününüzü verimli bir şekilde planlayın.",
    bgColor: Color(0xFF03346E),
    textColor: Colors.white,
    animationPath: 'assets/animations/ikinci.json',
  ),
];