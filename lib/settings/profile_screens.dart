import 'dart:async';

import 'package:apnashyamowner/constant/custom_snackbar.dart';
import 'package:apnashyamowner/model/response/CommonResponseModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/profile_sections.dart';
import '../common/submit_button.dart';
import '../common/title.dart';
import '../constant/app_constants.dart';
import '../constant/images/images.dart';
import '../constant/internetConnectivity.dart';
import '../constant/no_internet_screen.dart';
import '../constant/routes.dart';
import '../controller/homeController.dart';
import '../model/response/userProfileResponseModel.dart';
import 'package:share/share.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  UserProfileResponseModel? userProfileResponseModel;
  CommonResponseModel? commonResponseModel;
TextEditingController newPasswordController = TextEditingController();

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
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<HomeController>(builder: (homeController) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: homeController.isLoading && userProfileResponseModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : userProfileResponseModel!.data == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : userProfileResponseModel!.data!.profile == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 27.r),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        homeController.getUserToken() == ""
                                            ? const CustomTitle(title: 'Guest')
                                            : userProfileResponseModel!
                                                        .data!.profile![0].name ==
                                                    ""
                                                ? const CustomTitle(
                                                    title: 'Guest')
                                                : CustomTitle(
                                                    title:
                                                        userProfileResponseModel!
                                                            .data!
                                                            .profile![0]
                                                            .name!),
                                        userProfileResponseModel!
                                                    .data!.profile![0].email ==
                                                ""
                                            ? Text(
                                                '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(fontSize: 13.sp),
                                              )
                                            : Text(
                                                userProfileResponseModel!.data!.profile![0].email!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(fontSize: 13.sp),
                                              ),
                                        userProfileResponseModel!
                                                    .data!.profile![0].mobile ==
                                                ""
                                            ? Text(
                                                '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(fontSize: 13.sp),
                                              )
                                            : Text(
                                                userProfileResponseModel!.data!.profile![0].mobile!.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(fontSize: 13.sp),
                                              )
                                      ],
                                    ),
                                    // CircleAvatar(
                                    //   radius: 42.r,
                                    //   backgroundImage: const AssetImage(seaSide),
                                    // )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.r,
                                ),
                                // homeController.getUserToken() != ""
                                //     ? ProfileSections(
                                //         label: 'Edit Profile',
                                //         onTap: () {
                                //           Navigator.of(context)
                                //               .push(MaterialPageRoute(
                                //               builder: (context) => CreateProfile(
                                //                   email: userProfileResponseModel!
                                //                       .data!.user![0]
                                //                       .email!,
                                //                   name: userProfileResponseModel!
                                //                       .data!.user![0]
                                //                       .name!),))
                                //               .then((value) => {getUserProfile()});
                                //
                                //         }
                                //       )
                                //     : const SizedBox(),
                                homeController.getUserToken() != ""
                                    ? ProfileSections(
                                        label: 'Change Password',
                                        onTap: () =>
                                            modalBottomSheetForChangePassword(
                                                context))
                                    : const SizedBox(),
                                // ProfileSections(
                                //   label: 'Coupons',
                                //   onTap: () => Navigator.pushNamed(
                                //       context, MyRoutes.couponsScreen),
                                // ),
                                ProfileSections(
                                    label: 'Invite Friends',
                                    onTap: () =>
                                        showModalBottomSheetForInvite(context)),
                                ProfileSections(
                                  onTap: () => Navigator.pushNamed(
                                      context, MyRoutes.helpSupportScreen),
                                  label: 'Help & Support',
                                ),
                                // ProfileSections(
                                //     label: 'Payments',
                                //     onTap: () => Navigator.pushNamed(
                                //         context, MyRoutes.paymentScreen)),
                                ProfileSections(
                                  onTap: () => Navigator.pushNamed(
                                      context, MyRoutes.profileSettings),
                                  label: 'Settings',
                                ),
                              ]),
                            ),
            );
          });
  }

//showModalBottomSheetForInvite
  Future<dynamic> showModalBottomSheetForInvite(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 90.r,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubmitButton(
                  title: 'Share',
                  height: 50.r,
                  onTap: () {
                    Navigator.pop(context);
                    Share.share('Check out this app https://google.com', subject: 'I recommend u this app');
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

//modalBottomSheetForChangePassword
  Future<dynamic> modalBottomSheetForChangePassword(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  resetPassword,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "You can setup a new password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SubmitButton(
                    title: 'Enter New Password',
                    onTap: () => dialogForChangePassword(context))
              ],
            ),
          ),
        );
      },
    );
  }

//dialogForChangePassword
  Future<dynamic> dialogForChangePassword(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text(
                'Enter new password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(border: InputBorder.none)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SubmitButton(
            title: 'Submit',
            height: 30,
            onTap: () {
              // final snackBar = SnackBar(
              //   content: const Text('Changed Password Successfully'),
              //   action: SnackBarAction(
              //     textColor: Colors.white,
              //     label: 'dismiss',
              //     onPressed: () {},
              //   ),
              // );
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              if(newPasswordController.text!=""&&newPasswordController.text.length>2){
                changePassword(newPasswordController.text);
                newPasswordController.text="";
              }else{
                showCustomSnackBar("Password is not valid!");
              }
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  changePassword(String newpassword) async {
    commonResponseModel =
        await Get.find<HomeController>().ownerChangePassword(newpassword);

    // if (commonResponseModel!.data!.code != "200") {
      showCustomSnackBar(commonResponseModel!.data!.message!);

    // }
    setState(() {});
  }
  getUserProfile() async {
    userProfileResponseModel =
        await Get.find<HomeController>().getUserProfile();
    setState(() {});
  }
}
