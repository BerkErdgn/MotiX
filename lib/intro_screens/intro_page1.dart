import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kendi Koçunuz Olun'),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Yapay zeka destekli koçluk sistemimizle sorunlarınıza çözüm bulun ve hedeflerinize ulaşın',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Center(
           child: Lottie.network(
          'https://lottie.host/68842393-f892-4250-bd24-bfd2af985b00/NDAMAb21zx.json'
              ),
             ),
           ],
          ),
        );
      }
    }