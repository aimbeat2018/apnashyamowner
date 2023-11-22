import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// All Constants Decoration
class MyDecoration {
  BoxShadow boxShadow(BuildContext context) {
    return BoxShadow(
        color: Theme.of(context).shadowColor,
        offset: Offset(3.r, 5.r),
        blurRadius: 8.r);
  }
}
