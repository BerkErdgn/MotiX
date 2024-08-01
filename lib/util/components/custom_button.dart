import 'package:flutter/material.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Future<void> Function() functionEmailAndPassword;
  final Color buttonBackgroundColor;
  final Color saveButtonTextColor;

  const CustomButton(
      {Key? key,
      required this.functionEmailAndPassword,
      required this.buttonText,
      required this.buttonBackgroundColor,
      this.saveButtonTextColor = MotixColor.mainColorDarkGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
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
              .bodyMedium!
              .copyWith(color: saveButtonTextColor)),
    );
  }
} //end class CustomButton
