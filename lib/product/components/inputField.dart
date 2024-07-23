import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/auth_page/register_page.dart';

class InputField extends StatelessWidget {
  final bool isDropdown;
  final TextInputType customKeyboardTypes;
  final String labelText;
  final double _textFormFieldSize = 50;
  final bool obscureText;
  final TextEditingController controller;

  const InputField({
    Key? key,
    this.isDropdown = false,
    this.customKeyboardTypes = TextInputType.name,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  }) : super(key: key);

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
              textInputAction: TextInputAction.next,
              obscureText: obscureText,
              keyboardType: customKeyboardTypes,
              controller: controller,
              decoration: InputDecoration(
                
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  labelText: labelText,
                  labelStyle: TextStyle(color: Colors.black)),
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
