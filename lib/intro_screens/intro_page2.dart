import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://lottie.host/0f1056a9-cf82-40d2-ad0f-0c2ae281dea7/GILc0ZMtfI.json'
        ),
      ),
    );
  }
}