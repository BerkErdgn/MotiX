import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/product/components/inputField.dart';
import 'package:motix_app/product/components/registerButton.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

    final TextEditingController _controllerForgetPasswordEmail = TextEditingController();

    Future<void> sendEmail()async{
        await Auth().sendPasswordResetLink(_controllerForgetPasswordEmail.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "E-mail gönderildi.")));
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
                  "assets/background1.jpg",
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
                      Text("Şifrenizi sıfırlamak için lütfen E-mail giriniz."),
                      SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: _controllerForgetPasswordEmail,
                        labelText: "E-mail",
                        customKeyboardTypes: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RegisterButton(
                        buttonText: "Email gönder",
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

