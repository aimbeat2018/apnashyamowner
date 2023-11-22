// Custom Tile For Profile Screen
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSections extends StatelessWidget {
  final String label;
  final dynamic onTapped;
  final Function()? onTap;
  final Widget? trailing;

  const ProfileSections(
      {super.key,
      required this.label,
      this.onTapped,
      this.onTap,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: ListTile(
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          minVerticalPadding: 20.h,
          onTap: onTap,
          trailing: trailing ??
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: onTapped,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20.r,
                  color: Theme.of(context).primaryColor,
                ),
              ),
          contentPadding: EdgeInsets.zero,
          title: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: Theme.of(context).primaryColor),
          ),
        ));
  }
}
