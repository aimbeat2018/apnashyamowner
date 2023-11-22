// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextInputAction? textInputAction;
  final label;
  final obscureText;
  final suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      this.validator,
      this.controller,
      this.textInputAction,
      this.keyboardType,
      this.hintText,
      required this.label,
      this.obscureText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        cursorColor: Theme.of(context).primaryColor,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            suffixIconConstraints: BoxConstraints.tight(const Size(40, 20)),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: CupertinoColors.lightBackgroundGray,
            )),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.grey,
            )),
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            suffixIcon: suffixIcon,
            hintText: hintText,
            label: Text(label)),
      ),
    );
  }
}
