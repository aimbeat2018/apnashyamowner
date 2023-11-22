import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/routes.dart';
import '../common/profile_sections.dart';
import '../common/title.dart';
class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(title: 'Setting'),
            SizedBox(
              height: 8.r,
            ),
            ProfileSections(
              label: 'Notification',
              onTap: () =>
                  Navigator.pushNamed(context, MyRoutes.notificationScreen),
            ),
            ProfileSections(
              label: 'Terms of Service',
              onTap: () =>
              Navigator.pushNamed(context, MyRoutes.termsOfServiceScreen),
            ),
            ProfileSections(
              label: 'Privacy Policy',
              onTap: () =>
                  Navigator.pushNamed(context, MyRoutes.privacyPOlicyScreen),
            ),
            // ProfileSections(
            //   label: 'Give Feedbacks',
            //   onTap: () => Navigator.push(context,
            //       pageNavigator(const OnNavigate(text: 'Give Feedbacks'))),
            // ),
            ProfileSections(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('userData');
                prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, MyRoutes.logIn, (route) => false);
              },
              label: 'Logout',
            )
          ],
        ),
      ),
    );
  }
}
