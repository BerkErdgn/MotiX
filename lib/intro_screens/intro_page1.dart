import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://lottie.host/68842393-f892-4250-bd24-bfd2af985b00/NDAMAb21zx.json'
        ),
      ),
    );
  }
}