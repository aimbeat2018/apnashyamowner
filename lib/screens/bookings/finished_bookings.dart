import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controller/homeController.dart';
import '../../model/response/myBookingResponseModel.dart';
import '../../widget/bookings/upcoming_booking.dart';

class FinishedBooking extends StatefulWidget {
  const FinishedBooking({super.key});

  @override
  State<FinishedBooking> createState() => _FinishedBookingState();
}

class _FinishedBookingState extends State<FinishedBooking> {
  MyBookingResponseModel? myBookingResponseModel;

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  void initState() {
    // TODO: implement initState

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
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        body: homeController.isLoading &&
            myBookingResponseModel == null ?
        const Center(child: CircularProgressIndicator(),)
            : myBookingResponseModel!.data == null ?
        const Center(child: CircularProgressIndicator(),)
            : myBookingResponseModel!.data!.list == null ?
        const Center(child: Center(child: Text('No records found!')),)
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ListView.builder(
              itemCount: myBookingResponseModel!.data!.list!.length,
              itemBuilder: (BuildContext context, int index) {
                return UpcomingBookingContainer(
                    isFinished: true,
                    list: myBookingResponseModel!
                        .data!.list![index]
                );
              },
            ),
          ),
        ]),
      );
    });
  }

  void getList() async{
    myBookingResponseModel =
    await Get.find<HomeController>().myBookingLists(hotel_id: "19",flag: "2");


  }
}
