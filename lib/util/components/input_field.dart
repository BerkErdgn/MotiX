import 'package:flutter/material.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import '../../presantations/authPage/register_page.dart';

class InputField extends StatefulWidget {
  final bool isDropdown;
  final TextInputType customKeyboardTypes;
  final String labelText;
  final TextEditingController controller;

  const InputField({
    Key? key,
    this.isDropdown = false,
    this.customKeyboardTypes = TextInputType.name,
    required this.controller,
    required this.labelText,
    required bool obscureText,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
} //end class InputField

class _InputFieldState extends State<InputField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.labelText == LoginStrings.passwordLabel ||
        widget.labelText == RegisterStrings.verifyPasswordLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: RegisterPadding.inputPaddingSymmetric,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              style: TextStyle(color: MotixColor.mainColorDarkGrey),
              textInputAction: TextInputAction.next,
              obscureText: obscureText,
              keyboardType: widget.customKeyboardTypes,
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: MotixColor.mainColorLightGray,
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: MotixColor.mainColorDarkGrey)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MotixColor.mainColorOrange)),
                hintText: widget.labelText,
                prefixIcon: Icon(
                  widget.labelText == LoginStrings.emailLabel ||
                          widget.labelText == RegisterStrings.emailLabel
                      ? Icons.mail_outline_rounded
                      : widget.labelText == RegisterStrings.nameLabel
                          ? Icons.person_outline_rounded
                          : Icons.lock_outline_rounded,
                  color: MotixColor.mainColorDarkGrey,
                ),
                suffixIcon: widget.labelText == LoginStrings.passwordLabel ||
                        widget.labelText == RegisterStrings.verifyPasswordLabel
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          color: MotixColor.mainColorGrey,
                        ),
                      )
                    : null,
                hintStyle: TextStyle(color: MotixColor.mainColorDarkGrey),
              ),
            ),
          )
        ],
      ),
    );
  }
} //end class _InputFieldState
