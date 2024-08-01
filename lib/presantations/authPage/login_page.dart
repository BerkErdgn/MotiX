import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/main_screen.dart';
import 'package:motix_app/presantations/authPage/register_page.dart';
import 'package:motix_app/util/consts/motix_alert_messages.dart';
import 'package:motix_app/util/components/input_field.dart';
import 'package:motix_app/util/components/custom_button.dart';
import 'package:motix_app/util/consts/motix_assets_consts.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
} // end class LoginPage

class _LoginPageState extends State<LoginPage> {
  final String signText = LoginStrings.loginPrompt;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    // To Login with Email and Password
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } on FirebaseAuthException {
      // Error message displayed
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(MotixAlertMessages().wrongEmailorPasswordMessage),
        ));
      });
    }
  } //end Future signInWithEmailAndPassword

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              MotixImage.genericBacgroundImage,
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
                      obscureText: false,
                      controller: _controllerEmail,
                      labelText: LoginStrings.emailLabel,
                      customKeyboardTypes: TextInputType.emailAddress,
                    ),
                    InputField(
                      controller: _controllerPassword,
                      labelText: LoginStrings.passwordLabel,
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
                                    builder: (context) =>
                                        const ForgetPassword(),
                                  ));
                            },
                            child: Text(
                              LoginStrings.forgotPasswordText,
                              style:
                                  TextStyle(color: MotixColor.mainColorWhite),
                            )),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                        buttonBackgroundColor: MotixColor.mainColorLightGray,
                        functionEmailAndPassword: signInWithEmailAndPassword,
                        buttonText: LoginStrings.loginButtonText),
                    const SizedBox(height: 50),
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
} // end class _LoginPageState

class _HeadLineText extends StatelessWidget {
  const _HeadLineText({
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
            color: MotixColor.mainColorOrange,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} // end class _HeadLineText

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
            LoginStrings.noAccountText,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: MotixColor.mainColorWhite,
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
            LoginStrings.signUpText,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: MotixColor.mainColorOrange,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
} // end class SignUpText
