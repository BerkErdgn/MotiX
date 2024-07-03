import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motivasyonunuzu Paylaşın'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Motivasyon sözlerinizi ve sorunlarınızı paylaşarak destek alın ve diğer kullanıcılardan ilham alın.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Center(
            child: Lottie.network(
                'https://lottie.host/0f1056a9-cf82-40d2-ad0f-0c2ae281dea7/GILc0ZMtfI.json'
            ),
          ),
        ],
      ),
    );
  }
}
