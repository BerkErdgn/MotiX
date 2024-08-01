import 'package:flutter/material.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/util/consts/motix_alert_messages.dart';
import 'package:motix_app/util/components/input_field.dart';
import 'package:motix_app/util/components/custom_button.dart';
import 'package:motix_app/util/consts/motix_assets_consts.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _controllerForgetPasswordEmail =
      TextEditingController();

  Future<void> sendEmail() async {
    await Auth().sendPasswordResetLink(_controllerForgetPasswordEmail.text);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(MotixAlertMessages().sendEmailMessage)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                MotixImage.genericBacgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ForgetPasswordStrings.promptText),
                    SizedBox(
                      height: 20,
                    ),
                    InputField(
                      obscureText: false,
                      controller: _controllerForgetPasswordEmail,
                      labelText: ForgetPasswordStrings.emailLabel,
                      customKeyboardTypes: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      buttonBackgroundColor: MotixColor.mainColorLightGray,
                      buttonText: ForgetPasswordStrings.sendEmailButtonText,
                      functionEmailAndPassword: sendEmail,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
