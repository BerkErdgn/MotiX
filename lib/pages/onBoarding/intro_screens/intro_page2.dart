import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 55),
            child: Center(
              child: Lottie.asset('assets/animations/birinci.json',
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Motivasyonunuzu Paylaşın',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
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
                    text: 'Motivasyon sözlerinizi',
                    style: TextStyle(color: Colors.orange),
                  ),
                  TextSpan(
                    text: ' ve sorunlarınızı ',
                  ),
                  TextSpan(
                    text: 'paylaşarak',
                    style: TextStyle(color: Colors.orange),
                  ),
                  TextSpan(
                    text: ' destek alın ve diğer kullanıcılardan ilham alın',
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
