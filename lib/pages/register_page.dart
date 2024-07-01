import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/data/dropdownMenuData/DropdownMenuData.dart';
import 'package:motix_app/pages/cubit/registerCubit.dart';
import 'package:motix_app/pages/home_page.dart';
import 'package:motix_app/pages/login_page.dart';
import 'package:motix_app/pages/onBoarding/onboarding_screen.dart';
import 'package:motix_app/product/components/inputField.dart';
import 'package:motix_app/product/components/registerButton.dart';
import 'package:motix_app/product/language/product_text.dart';

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
  final TextEditingController _controllerVerifyPassword = TextEditingController();
  final TextEditingController _iconController = TextEditingController();


  Future<void> signInWithEmailAndPassword() async{

    try{
      if(_controllerEmail.text.isNotEmpty && _controllerName.text.isNotEmpty && _controllerPassword.text.isNotEmpty && _controllerVerifyPassword.text.isNotEmpty){
        if(_controllerPassword.text == _controllerVerifyPassword.text){
          await Auth().createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);

          var userId ="";
          var userName = _controllerName.text;
          var userEmail = _controllerEmail.text;
          var profileIcon = _iconController.text;
          context.read<RegisterCubit>().addUser(userId, userName, userEmail, profileIcon);

          Navigator.push(context, MaterialPageRoute(builder:(context) {return const HomePage();}));
        }else{
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Şifreler uyuşmuyor")));
          });
        }
      }else{
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bütün boşlukları doldurunuz.")));
        });
      }

    }on FirebaseAuthException catch(e){
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.message}")));
        });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: const Color(0xFFEEF5FF),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const BackButtonIcon(),
                    const SignUpText(),
                     InputField(
                      labelText: 'Ad - Soyad',
                       controller: _controllerName,
                    ),
                     InputField(
                      labelText: 'E-posta',
                      customKeyboardTypes: TextInputType.emailAddress,
                       controller: _controllerEmail,
                    ),
                     InputField(
                      labelText: 'Şifre',obscureText: true,
                       controller: _controllerPassword,
                    ),
                     InputField(
                      labelText: 'Şifre Tekrar', obscureText: true,
                       controller: _controllerVerifyPassword,
                    ),
                    InputArea5(controller: _iconController,),
                     Padding(
                      padding: EdgeInsets.all(32.0),
                      child:
                       RegisterButton( buttonText: ProjectText().registerButtonText,  functionEmailAndPassword: signInWithEmailAndPassword,)
                    ),
                    const AlreadyHaveAccount(),
                  ],
                ),
              ),
            ),
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
              child: Text(ProjectText().title,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
            ),
            Text(
              ProjectText().subTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}


class InputArea5 extends StatefulWidget {
  final TextEditingController controller;

  const InputArea5(
      {Key? key, required this.controller})
      : super(key: key);

  @override
  _InputArea5State createState() => _InputArea5State();
}

class _InputArea5State extends State<InputArea5> {

  ProfileLable? selectedIcon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 8.0),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Color(0xFFEEF5FF),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Color(0xFFEDF1F3)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0xFFEEECEC),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: DropdownMenu<ProfileLable>(
          initialSelection: ProfileLable.bear,
          controller: widget.controller,
          requestFocusOnTap: true,
          leadingIcon: const Icon(Icons.search),
          label: const Text('Select Profile Image'),
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
                leadingIcon: SvgPicture.asset(icon.icon, width: 25, height: 25,),
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
        Text(ProjectText().alreadyHaveAccountText,
            style: Theme.of(context).textTheme.bodyMedium),
        TextButton(
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context){
                return LoginPage();
              }));
            },
            child: Text(ProjectText().logIn,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.blue)))
      ],
    );
  }
}

class BackButtonIcon extends StatelessWidget {
  const BackButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const OnBoardingScreen();
                }));
              },
              icon: const Icon(
                Icons.chevron_left_outlined,
                size: 35,
              ))
        ],
      ),
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
