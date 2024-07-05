import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Center(
              child: Lottie.asset('assets/animations/ucuncu.json'),
              ),
          ),
          const SizedBox(height: 20),
           const Text(
            'Kendi Koçunuz Olun',
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
                text: 'Yapay zeka',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange,
                ),
                children: [
                  TextSpan(
                    text: ' destekli koçluk sistemimizle sorunlarınıza çözüm bulun ve hedeflerinize ulaşın',
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
