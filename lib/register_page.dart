import 'package:flutter/material.dart';
import 'package:motix_app/login_page.dart';
import 'package:motix_app/onboarding_screen.dart';
import 'package:motix_app/product/language/product_text.dart';

void main() {
  runApp(RegisterPage());
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFFEEF5FF),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const BackButtonIcon(),
                    const SignUpText(),
                    const InputField(
                      textFieldHintText: 'Ad - Soyad',
                      labelText: 'Ad - Soyad',
                    ),
                    const InputField(
                      textFieldHintText: 'E-posta',
                      labelText: 'E-posta',
                      customKeyboardTypes: TextInputType.emailAddress,
                    ),
                    const InputField(
                      textFieldHintText: 'Şifre',
                      labelText: 'Şifre',obscureText: true,
                    ),
                    const InputField(
                      textFieldHintText: 'Şifre Tekrar',
                      labelText: 'Şifre Tekrar', obscureText: true,
                    ),
                    InputArea5(),
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: RegisterButton(),
                    ),
                    const AlreadyHaveAccount(),
                  ],
                ),
              ),
            ),
          ),
        ));
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

class InputField extends StatelessWidget {
  final bool isDropdown;
  final String textFieldHintText;
  final TextInputType customKeyboardTypes;
  final String labelText;
  final double _textFormFieldSize = 50;
  final bool obscureText;

  const InputField(
      {Key? key,
      this.isDropdown = false,
      required this.textFieldHintText,
      this.customKeyboardTypes = TextInputType.name,
       
      required this.labelText,  this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: RegisterPadding.inputPaddingSymmetric,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _textFormFieldSize,
            child: TextFormField(
              obscureText: obscureText,
              keyboardType: customKeyboardTypes,
              // controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                labelText: labelText,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}

class InputArea5 extends StatefulWidget {
  @override
  _InputArea5State createState() => _InputArea5State();
}

class _InputArea5State extends State<InputArea5> {
  String? selectedOption; // Seçilen öğeyi saklamak için

  List<String> dropdownItems = ['Gülücük', 'Bulut', 'Fırça', 'Kalp'];

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
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedOption,
            isExpanded: true,
            // hint: Text('Seçenekler'),
            icon: const Icon(Icons.arrow_drop_down), // Açılır menü simgesi
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

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shadowColor: Colors.blueGrey,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(350, 45),
      ),
      onPressed: () {
        
      },
      child: Text(ProjectText().buttonText,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white)),
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
