import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final String buttonText;
  final Future<void>  Function() functionEmailAndPassword;
  const RegisterButton({Key? key, required this.functionEmailAndPassword, required this.buttonText}) : super(key: key);

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
      onPressed: () async {
        await functionEmailAndPassword();
      },
      child: Text(buttonText,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white)),
    );
  }
}