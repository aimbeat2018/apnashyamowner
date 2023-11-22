// Custom App Bar // Currently not implemented
import 'package:apnashyamowner/constant/globalFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/routes.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  CustomAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions:  [
        SizedBox(width: 10,),
        GestureDetector(
          onTap:() {
            Navigator.pushNamed(
                context,
                MyRoutes.profileScreen);
          },
          child: Icon(CupertinoIcons.profile_circled,
            color: Colors.white,
          size: 27,),
        ),
        SizedBox(width: 15,),
        GestureDetector(
          onTap:() async {
            // Navigator.pushNamed(
            //     context,
            //     MyRoutes.profileScreen);
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('userData');
            prefs.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, MyRoutes.logIn, (route) => false);
          },
          child: Icon(Icons.logout,
          color: Colors.white,
            size: 27,),
        ),
        SizedBox(width: 20,),
      ],
      backgroundColor: Theme.of(context).splashColor,
        title: Text(widget.title,
          style: TextStyle( fontFamily: 'Rozha One',
              fontSize: 17.sp,
              height: 1,
              color: Colors.white),)

    );
  }
}
