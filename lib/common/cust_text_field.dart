// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon? icon;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final verticlePadding;
  final suffixIcon;
  final color;
  final keyboardType;
  final maxLines;
  final textPadding;
  final borderRadius;

  const CustomTextField(
      {super.key,
      required this.hintText,
      this.color,
      this.onFieldSubmitted,
      this.controller,
      this.icon,
      this.verticlePadding,
      this.suffixIcon,
      this.keyboardType,
      required this.maxLines,
      this.textPadding,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticlePadding ?? 10).r,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 12).r,
            color: color ?? Colors.white),
        child: Padding(
          padding: EdgeInsets.only(left: textPadding ?? 20).r,
          child: TextFormField(
            controller: controller,
            onFieldSubmitted: onFieldSubmitted,
            maxLines: maxLines,
            decoration: InputDecoration(
                prefixIcon: icon,
                suffixIcon: suffixIcon,
                hintText: hintText,
                border: const OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ),
    );
  }
}
