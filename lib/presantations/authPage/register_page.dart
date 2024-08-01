import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/data/dropdownMenuData/DropdownMenuData.dart';
import 'package:motix_app/main_screen.dart';
import 'package:motix_app/cubit/registerCubit.dart';
import 'package:motix_app/presantations/authPage/login_page.dart';
import 'package:motix_app/util/consts/motix_alert_messages.dart';
import 'package:motix_app/util/components/input_field.dart';
import 'package:motix_app/util/components/custom_button.dart';
import 'package:motix_app/util/consts/motix_assets_consts.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';

void main() {
  runApp(RegisterPage());
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerVerifyPassword =
      TextEditingController();
  final TextEditingController _iconController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      if (_controllerEmail.text.isNotEmpty &&
          _controllerName.text.isNotEmpty &&
          _controllerPassword.text.isNotEmpty &&
          _controllerVerifyPassword.text.isNotEmpty) {
        if (_controllerPassword.text == _controllerVerifyPassword.text) {
          await Auth().createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);

          var userId = "";
          var userName = _controllerName.text;
          var userEmail = _controllerEmail.text;
          var profileIcon = _iconController.text;
          context
              .read<RegisterCubit>()
              .addUser(userId, userName, userEmail, profileIcon);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MainScreen();
          }));
        } else {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(MotixAlertMessages().doesntMatchMessage)));
          });
        }
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(MotixAlertMessages().filltheBlanksMessage)));
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.message == "The email address is badly formatted.") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(MotixAlertMessages().emailCorrectFormatMessage)));
        });
      } else if (e.message == "Password should be at least 6 characters") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(MotixAlertMessages().characterWrongMessage)));
        });
      } else if (e.message ==
          "The email address is already in use by another account.") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(MotixAlertMessages().alreadyExistsMessage)));
        });
      }
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
              MotixImage.genericBacgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SignUpText(),
                      InputField(
                        obscureText: false,
                        labelText: RegisterStrings.nameLabel,
                        controller: _controllerName,
                      ),
                      InputField(
                        obscureText: false,
                        labelText: RegisterStrings.emailLabel,
                        customKeyboardTypes: TextInputType.emailAddress,
                        controller: _controllerEmail,
                      ),
                      InputField(
                        labelText: RegisterStrings.passwordLabel,
                        obscureText: true,
                        controller: _controllerPassword,
                      ),
                      InputField(
                        labelText: RegisterStrings.verifyPasswordLabel,
                        obscureText: true,
                        controller: _controllerVerifyPassword,
                      ),
                      InputArea5(
                        controller: _iconController,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: CustomButton(
                          buttonBackgroundColor: MotixColor.mainColorLightGray,
                          buttonText: RegisterStrings.registerButtonText,
                          functionEmailAndPassword: signInWithEmailAndPassword,
                        ),
                      ),
                      Divider(),
                      const AlreadyHaveAccount(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: RegisterPadding.signUpTextPadding,
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: RegisterPadding.signUpTextBetweenPadding,
              child: Text(RegisterStrings.title,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: MotixColor.mainColorWhite,
                        fontWeight: FontWeight.bold,
                      )),
            ),
            Text(
              RegisterStrings.subTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: MotixColor.mainColorWhite),
            ),
          ],
        ),
      ),
    );
  }
}

class InputArea5 extends StatefulWidget {
  final TextEditingController controller;

  const InputArea5({Key? key, required this.controller}) : super(key: key);

  @override
  _InputArea5State createState() => _InputArea5State();
}

class _InputArea5State extends State<InputArea5> {
  ProfileLable? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 8.0),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 4, color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: DropdownMenu<ProfileLable>(
          menuHeight: 200,
          initialSelection: ProfileLable.bear,
          controller: widget.controller,
          requestFocusOnTap: false,
          leadingIcon: const Icon(Icons.search),
          label: const Text(RegisterStrings.selectProfileIcon),
          textStyle: TextStyle(color: MotixColor.mainColorWhite),
          onSelected: (ProfileLable? icon) {
            setState(() {
              selectedIcon = icon;
            });
          },
          dropdownMenuEntries:
              ProfileLable.values.map<DropdownMenuEntry<ProfileLable>>(
            (ProfileLable icon) {
              return DropdownMenuEntry<ProfileLable>(
                value: icon,
                label: icon.label,
                leadingIcon: SvgPicture.asset(
                  icon.icon,
                  width: 25,
                  height: 25,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(RegisterStrings.alreadyHaveAccountText,
            style: Theme.of(context).textTheme.bodyMedium),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
            child: Text(RegisterStrings.logIn,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: MotixColor.mainColorOrange)))
      ],
    );
  }
}

class RegisterPadding {
  static EdgeInsets inputPaddingSymmetric =
      const EdgeInsets.symmetric(horizontal: 10, vertical: 14);

  static EdgeInsets signUpTextPadding =
      const EdgeInsets.symmetric(vertical: 30, horizontal: 16);

  static EdgeInsets signUpTextBetweenPadding =
      const EdgeInsets.only(bottom: 10);
}
