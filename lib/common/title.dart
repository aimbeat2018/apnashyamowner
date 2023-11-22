//Custom Title That Used Many Times
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitle extends StatelessWidget {
  final String? title;
  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
          fontFamily: 'Rozha One',
          fontSize: 32.sp,
          height: 1,
          color: Theme.of(context).splashColor),
    );
  }
}
