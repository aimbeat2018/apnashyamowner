// Sumbit Button That Use Maany Times
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final double? width;
  final Function()? onTap;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? fontSize;

  const SubmitButton(
      {super.key,
      required this.title,
      this.onTap,
      this.fontSize,
      this.textColor,
      this.height,
      this.color,
      this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45.r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ?? Theme.of(context).splashColor),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: textColor ?? Colors.white, fontSize: fontSize ?? 13.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
