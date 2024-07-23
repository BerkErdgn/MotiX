import 'package:flutter/material.dart';
import 'package:motix_app/pages/auth_page/login_page.dart';
import 'package:motix_app/pages/onBoarding/intro_screens/intro_page1.dart';
import 'package:motix_app/pages/onBoarding/intro_screens/intro_page2.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  _storeOnBoardingInfo()async{
    bool isViewed = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onBoard", isViewed);
  }

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
              alignment: Alignment(0, 0.90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _storeOnBoardingInfo();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginPage()),
                      );
                    },
                    child: Text('Geç'),
                  ),
                  SmoothPageIndicator(controller: _controller, count: 3),

                  onLastPage ?
                  GestureDetector(
                    onTap: () async {
                      await _storeOnBoardingInfo();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginPage()),
                      );
                    },
                    child: Text('Bitti'),
                  )
                      : GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text('Devam'),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}