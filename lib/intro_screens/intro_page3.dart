import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planlarınızı Organize Edin'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Yapacaklarınızı not alın ve gününüzü verimli bir şekilde planlayın.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Center(
            child: Lottie.network(
                'https://lottie.host/fd072d82-478c-4870-8d8b-34a1aa69d709/vYGropia8Y.json'
            ),
          ),
        ],
      ),
    );
  }
}
