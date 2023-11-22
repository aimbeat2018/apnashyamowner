import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/no_internet_screen.dart';
import '../../../model/response/notificationResponseModel.dart';
import '../common/title.dart';
import '../controller/homeController.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
NotificationResponseModel? notificationResponseModel;

  @override
  void initState() {
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });

    getList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: _connectionStatus == AppConstants.connectivityCheck
            ? const NoInternetScreen()
            : GetBuilder<HomeController>(builder: (homeController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTitle(title: 'Notification'),
                      homeController.isLoading &&
                          notificationResponseModel==null
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          :notificationResponseModel!.data==null? const Center(
                        child: CircularProgressIndicator(),
                      )
                          :notificationResponseModel!.data!.noti==null? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.only(top: 10.r),
                          itemCount: notificationResponseModel!.data!.noti!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return notificationWidget(
                              index,
                              context,
                              () {
                                //TODO: OnTap Functions
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                    ],
                  ),
                );
              }));
  }

// notificationWidget
  Widget notificationWidget(
      int index, BuildContext context, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              size: 20.sp,
              Icons.notifications_active,
            ),
            SizedBox(
              width: 10.r,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        notificationResponseModel!.data!.noti![index].title!,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      // const Spacer(
                      //   flex: 1,
                      // ),
                      // Text(
                      //   notifications[index].time,
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .caption
                      //       ?.copyWith(fontSize: 13.sp),
                      // )
                    ],
                  ),
                  // SizedBox(
                  //   height: 3.r,
                  // ),
                  // Text(
                  //   notifications[index].descriprtion,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .caption
                  //       ?.copyWith(fontSize: 13.sp),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getList() async {
    notificationResponseModel= await Get.find<HomeController>().notificationListing();
  }
}
