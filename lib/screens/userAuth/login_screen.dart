import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/custom_textfield.dart';
import '../../common/submit_button.dart';
import '../../common/title.dart';
import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';

import '../../constant/custom_snackbar.dart';

import '../../constant/routes.dart';
import '../../controller/homeController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State variable for switch button
  bool state = false;

  // Global Key for check validation amoung the form(No Validation added you can)
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // isVisible for Show/Hide Password
  bool isVisible = true;

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<HomeController>(builder: (homeController) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  elevation: 0,
                  iconTheme:
                      IconThemeData(color: Theme.of(context).primaryColor),
                  backgroundColor: Colors.transparent,
                ),
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 110, left: 20, right: 20).r,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTitle(title: 'Log in'),
                          SizedBox(
                            height: 26.r,
                          ),
                          CustomTextField(
                              controller: _emailController,
                              validator: (e) => e.toString().isEmail
                                  ? null
                                  : "Invalid email",
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Your Email'),
                          SizedBox(
                            height: 22.r,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (e) {
                              if (e.toString().isEmpty) {
                                return 'Password should be valid';
                              }
                              return null;
                            },
                            obscureText: isVisible,
                            label: 'Password',
                            suffixIcon: IconButton(
                              icon: isVisible == false
                                  ? Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                          ),
                          // SizedBox(
                          //   height: 30.r,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Row(
                          //       children: [
                          //         CustomSwitchButton(
                          //           inactiveColor: Colors.black,
                          //           activeColor: Colors.deepPurple.shade900,
                          //           value: state,
                          //           onToggle: (val) {
                          //             setState(() {
                          //               state = val;
                          //             });o
                          //           },
                          //         ),
                          //         SizedBox(
                          //           width: 8.r,
                          //         ),
                          //         Text(
                          //           'Remember',
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 13.sp,
                          //               color: Theme.of(context).primaryColor),
                          //         )
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 36.r,
                          ),
                          SubmitButton(
                            title: 'Log in',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                loginOrReg(homeController,_emailController.text,_passwordController.text, context);
                              }
                            },
                          ),
                          /* SizedBox(
                            height: 18.r,
                          ),
                          Center(
                              child: Text(
                            'OR',
                            style: Theme.of(context).textTheme.bodySmall!.merge(
                                TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor)),
                          )),
                          SizedBox(
                            height: 18.r,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 80,
                                child: Card(
                                  color: AppColors.btnColor,
                                  elevation: 10,
                                  child: Image.asset(
                                    'assets/logos/f_facebook_icon.png',
                                    width: 40,
                                    height: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 18.r,
                              ),
                              SizedBox(
                                height: 50,
                                width: 80,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 10,
                                  child: Image.asset(
                                    'assets/logos/g_google_icon.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                          /*const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have Account?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 8.r,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          MyRoutes.signUp,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
  }

  Future<void> loginOrReg(
      HomeController homeController, String email, String password, BuildContext context2) async {
    String? device_token= await FirebaseMessaging.instance.getToken();
    homeController.doLoginOrReg(email, password,device_token).then((model) async {
      if (model!.data!.code == "200") {
        showCustomSnackBar(model.data!.message!);

        Navigator.pushNamed(context2, MyRoutes.bookingsScreen);
      }else if (model!.data!.code == "201"&&model!.data!.message=="Account Deactive contact admin!Login Failed") {
        showCustomSnackBar('Your account is not active contact admin!');
      } else {
        showCustomSnackBar('Something went wrong!', isError: true);
      }
    });
  }
}
