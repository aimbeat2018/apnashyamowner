import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../colors/colors.dart';
import '../../common/submit_button.dart';
import '../../constant/app_constants.dart';
import '../../constant/images/images.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/routes.dart';
import '../../controller/homeController.dart';

class BookedSuccessful extends StatefulWidget {
  const BookedSuccessful({super.key});

  @override
  State<BookedSuccessful> createState() => _BookedSuccessfulState();
}

class _BookedSuccessfulState extends State<BookedSuccessful> {
  // When value is false it shows a circular Progress indicator
  bool isWaiting = false;

// Function For Change Value of isWaiting
  forWaiting() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isWaiting = true;
    });
  }

  final String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    forWaiting();

    String connectionStatus = 'unKnown';
    final Connectivity connectivity = Connectivity();
    late StreamSubscription<ConnectivityResult> connectivitySubscription;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<HomeController>(builder: (homeController)
    {
      return Scaffold(
          backgroundColor: AppColors.dealScaffoldColor2,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isWaiting
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center(
                //   child: Lottie.asset(
                //     briefcase,
                //     repeat: false,
                //     height: 180.r,
                //     width: 180.r,
                //     fit: BoxFit.fill,
                //   ),
                // ),
                Center(
                  child: Image.asset(
                    bags,
                    height: 180.r,
                    width: 180.r,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 18.r,
                ),
                Text(
                  'Your booking is confirmed!',
                  style: GoogleFonts.rozhaOne(
                      fontSize: 35.sp,
                      color: Theme
                          .of(context)
                          .splashColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 18.r,
                ),
                homeController.getemail()==""?
                Text(
                  "We've emailed your confirmation to\nyour email id",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ):Text(
                  "We've emailed your confirmation to\n${homeController.getemail()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 130.r,
                ),
                SubmitButton(
                  onTap: () =>
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          MyRoutes.bookingsScreen,
                          arguments: 2,
                              (route) => false),
                  title: 'Manage Your Booking',
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Coming soon'),
                          content: const Text('We are currently working on this feature!', style: TextStyle(color: Colors.red)),
                          actions: <Widget>[
                            MaterialButton(
                              child: const Text('Okay'),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            )
                          ],
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 60,
                      child: Card(
                          color: AppColors.btnColor,
                          elevation: 10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15),
                                child: Text('E Rickshaw Booking',
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5),
                                child: Image.asset(
                                  'assets/images/rickshaw_small.png',
                                  width: 40, height: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ],)
                        /*Image.asset('assets/logos/f_facebook_icon.png',
                    width: 40,height: 40,
                    color: Colors.white,
                ),*/
                      ),
                    ),
                  ),
                ),
              ],
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ));
    });
  }
}
