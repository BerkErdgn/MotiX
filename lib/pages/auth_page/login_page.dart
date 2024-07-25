import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/main_screen.dart';
import 'package:motix_app/pages/auth_page/register_page.dart';
import 'package:motix_app/product/components/inputField.dart';
import 'package:motix_app/product/components/registerButton.dart';
import 'package:motix_app/product/language/product_text.dart';

import 'forgotPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String signText = 'Hesabınıza Giriş Yapınız';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "E-mail yada şifreniz yanlış girilmiştir. Lütfen doğru giriniz.",
            ),));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/background1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _HeadLineText(signText: signText),
                    InputField(
                      controller: _controllerEmail,
                      labelText: "E-mail",
                      customKeyboardTypes: TextInputType.emailAddress,
                    ),
                    InputField(
                      controller: _controllerPassword,
                      labelText: "Şifre",
                      obscureText: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgetPassword(),
                                  ));
                            },
                            child: Text("Şifremi unuttum")),
                      ),
                    ),
                    const SizedBox(height: 25),
                    RegisterButton(
                        functionEmailAndPassword: signInWithEmailAndPassword,
                        buttonText: ProjectText().enteringButtonText),
                    const SizedBox(height: 25),
                    const SizedBox(height: 25),
                    const SignUpText(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadLineText extends StatelessWidget {
  const _HeadLineText({
    super.key,
    required this.signText,
  });

  final String signText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 120, bottom: 150, left: 20),
      child: Text(
        signText,
        style: GoogleFonts.quicksand(
          textStyle: TextStyle(
            color: Colors.deepOrange,
            fontSize: 36,
            fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}

class Title6 extends StatelessWidget {
  const Title6({super.key});

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
          child: const Stack(
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

class InputArea6 extends StatelessWidget {
  const InputArea6({super.key});

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
              side: const BorderSide(width: 2, color: Color(0xFFEDF1F3)),
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Mail Adresinizi Girin',
                    suffixIcon: Icon(Icons.mail),
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

class Title7 extends StatelessWidget {
  const Title7({super.key});

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
          child: const Stack(
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

class InputArea7 extends StatelessWidget {
  const InputArea7({super.key});

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
              side: const BorderSide(width: 2, color: Color(0xFFEDF1F3)),
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Şifrenizi Girin',
                    suffixIcon: Icon(Icons.password),
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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 327.0,
            height: 48.0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff176B87)),
              ),
              onPressed: () {},
              child: const Text(
                'Giriş Yap',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 13),
          child: Text(
            'Hesabınız yok mu ?',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RegisterPage();
            }));
          },
          child: const Text(
            'Kayıt Olun',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xff176B87),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
