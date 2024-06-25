import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://lottie.host/fd072d82-478c-4870-8d8b-34a1aa69d709/vYGropia8Y.json'
        ),
      ),
    );
  }
}