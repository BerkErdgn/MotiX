import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFEEF5FF),
        body: SingleChildScrollView(
          // En dıştaki Container'ı sarmalayın
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                child: Column(
                  children: [
                    SignUpText(), //SignUpText
                    Title(), // NAME AND SURNAME Title
                    InputArea(), // NAME AND SURNAME InputArea
                    Title2(), // E-MAIL Title
                    InputArea2(), // E-MAIL InputArea
                    Title3(), // PASSWORD Title
                    InputArea3(), // PASSWORD InputArea
                    Title4(), // PASSWORD VERIFY Title
                    InputArea4(), // PASSWORD VERIFY InputArea
                    Title5(),
                    InputArea5(),
                    
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CombinedButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////

//KAYIT OL YAZISININ OLDUĞU KODLAR//

class SignUpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100, left: 36),
      child: Column(
        children: [
          Container(
            width: 527,
            height: 72,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 527,
                  child: Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      color: Color(0xFF1A1C1E),
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0.995,
                      letterSpacing: -0.995,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: Text(
                    'Devam etmek için bir hesap oluşturun!',
                    style: TextStyle(
                      color: Color(0xFF6C7278),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400, //Yazının kalınlığını ayarlar
                      height: 0.16,
                      letterSpacing: -0.16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

// AD VE SOYAD BİLGİSİNİN ALINDIĞI KODLAR//

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 36,
                child: Text(
                  'Ad - Soyad',
                  style: TextStyle(
                    color: Color(0xFF6C7278),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.13,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 330,
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFFEDF1F3)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

//EPOSTA BİLGİSİNİN ALINDIĞI KODLAR//

class Title2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 36,
                child: Text(
                  'E-Posta',
                  style: TextStyle(
                    color: Color(0xFF6C7278),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.13,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputArea2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 330,
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFFEDF1F3)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
////////////////////////////////////////////////////////////////////////////////

//ŞİFRE BİLGİLERİNİN ALINDIĞI KODLAR//

class Title3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 36,
                child: Text(
                  'Şifre',
                  style: TextStyle(
                    color: Color(0xFF6C7278),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.13,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputArea3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 330,
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFFEDF1F3)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Doğrulayıcı ikinci şifre//

class Title4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 36, // Adjust 'left' property to position the text
                child: Text(
                  'Şifrenizi Tekrar Giriniz',
                  style: TextStyle(
                    color: Color(0xFF6C7278),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.13,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputArea4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 330,
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFFEDF1F3)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////////

//SEÇENEKLERİN YER ALDIĞI KODLAR//

class Title5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 36,
                child: Text(
                  'Bir Tane Simge Seçiniz',
                  style: TextStyle(
                    color: Color(0xFF6C7278),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.13,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputArea5 extends StatefulWidget {
  @override
  _InputArea5State createState() => _InputArea5State();
}

class _InputArea5State extends State<InputArea5> {
  String? selectedOption; // Seçilen öğeyi saklamak için

  List<String> dropdownItems = [
    'Gülücük',
    'Bulut',
    'Fırça',
    'Kalp'
// Gerektiğinde daha fazla seçenek eklenebilir
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32,
      left: 36,
      child: Container(
        width: 330,
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Color(0xFFEDF1F3)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3DE4E5E7),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedOption,
            isExpanded: true,
            // hint: Text('Seçenekler'),
            icon: Icon(Icons.arrow_drop_down), // Açılır menü simgesi
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue;
              });
            },
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////

class CombinedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32,
      left: 50,
      child: Container(
        width: 330,
        height: 46,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF176B87),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Color(0xFF176B87)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3DE4E5E7),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: TextButton(
          onPressed: () {
            // Butona tıklandığında yapılacak işlemler buraya yazılacak
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text('Kayıt Ol'),
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////