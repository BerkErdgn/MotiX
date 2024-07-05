import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(93.0),
            child: Center(
              child: Lottie.asset(
                'assets/animations/ikinci.json',
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Planlarınızı Organize Edin',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Yapacaklarınızı ',
                  ),
                  TextSpan(
                    text: 'not alın',
                    style: TextStyle(color: Colors.orange),
                  ),
                  TextSpan(
                    text: ' ve gününüzü verimli bir şekilde planlayın',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
