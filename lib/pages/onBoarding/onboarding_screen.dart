import 'package:flutter/material.dart';
import 'package:motix_app/pages/onBoarding/intro_screens/intro_page1.dart';
import 'package:motix_app/pages/onBoarding/intro_screens/intro_page2.dart';
import 'package:motix_app/pages/register_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_screens/intro_page3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _controller = PageController();


  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });

            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  RegisterPage()),
                      );
                    },
                    child: Text('skip'),
                  ),
                  SmoothPageIndicator(controller: _controller, count: 3),

                  onLastPage ?
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  RegisterPage()),
                      );
                    },
                    child: Text('done'),
                  )
                      : GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text('next'),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}