import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors/colors.dart';
import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controller/homeController.dart';
import '../../model/response/myBookingResponseModel.dart';

class UpcomingBookings extends StatefulWidget {
  String? hotel_id;
  int? selectedIndex;

  UpcomingBookings({super.key, this.hotel_id, this.selectedIndex});

  @override
  State<UpcomingBookings> createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
  MyBookingResponseModel? myBookingResponseModel;
  String? fromDate, toDate;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    getList();
    // Length Of List
    // int list = myBookingResponseModel!.data!.list!.length;

    var width = (ScreenUtil().screenWidth * .5) - 20.r;
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<HomeController>(builder: (homeController) {
            return Scaffold(
              body: homeController.isLoading && myBookingResponseModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : myBookingResponseModel!.data == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : myBookingResponseModel!.data!.code == "201"
                          ? const Center(
                              child: Text("Data not found!"),
                            )
                          : myBookingResponseModel!.data!.list == null ||
                                  myBookingResponseModel!.data!.list!.length ==
                                      0
                              ? const Center(
                                  child:
                                      Center(child: Text('No records found!')),
                                )
                              : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            'You have ${myBookingResponseModel!.data!.list!.length} upcoming booking'),
                                        SizedBox(
                                          height: 10.r,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: myBookingResponseModel!
                                                .data!.list!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return myBookingResponseModel!
                                                              .data!
                                                              .list![index]
                                                              .checkinCheckoutFlag ==
                                                          0 ||
                                                      myBookingResponseModel!
                                                              .data!
                                                              .list![index]
                                                              .checkinCheckoutFlag ==
                                                          1
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5.0),
                                                      child: Card(
                                                        elevation: 5,
                                                        color: CupertinoColors
                                                            .lightBackgroundGray,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15,
                                                                  bottom: 15),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // Container(
                                                                  //   height: 70,
                                                                  //   width: 70,
                                                                  //   decoration: BoxDecoration(
                                                                  //       borderRadius:
                                                                  //           BorderRadius.circular(
                                                                  //               10),
                                                                  //       image: DecorationImage(
                                                                  //           image: NetworkImage(
                                                                  //               myBookingResponseModel!
                                                                  //                   .data!
                                                                  //                   .list![index]
                                                                  //                   .roomImage!),
                                                                  //           fit: BoxFit.fill)),
                                                                  // ),
                                                                  // const SizedBox(
                                                                  //   height: 20,
                                                                  // ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                15.0),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            myBookingResponseModel!.data!.list![index].userName!=""?
                                                                            Text(
                                                                              myBookingResponseModel!.data!.list![index].userName!,
                                                                              style: TextStyle(
                                                                                  color: AppColors.btnColor,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16.sp),
                                                                            ):Text(
                                                                              'Guest(No Name)',
                                                                              style: TextStyle(
                                                                                  color: AppColors.btnColor,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16.sp),
                                                                            ),myBookingResponseModel!.data!.list![index].userMobile!=""?
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  myBookingResponseModel!.data!.list![index].userMobile!,
                                                                                  style: TextStyle(
                                                                                      color: AppColors.btnColor,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 16.sp),
                                                                                ),
                                                                                IconButton(onPressed: () {
                                                                                  _launchCaller(myBookingResponseModel!.data!.list![index].userMobile!);
                                                                                }, icon: Icon(Icons.phone))
                                                                              ],
                                                                            ):Text(
                                                                              '',
                                                                              style: TextStyle(
                                                                                  color: AppColors.btnColor,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16.sp),
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                                  3.r,
                                                                            ),
                                                                            Text(
                                                                                myBookingResponseModel!.data!.list![index].roomCategory!,
                                                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13.sp)),
                                                                            SizedBox(
                                                                              height:
                                                                                  3.r,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.money,
                                                                                  size: 11.sp,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 3.r,
                                                                                ),
                                                                                Text(
                                                                                  'Payment\nStatus: ${myBookingResponseModel!.data!.list![index].paymentStatus!}',
                                                                                  style: TextStyle(fontSize: 11.sp),
                                                                                ),
                                                                                // Padding(
                                                                                //   padding: EdgeInsets
                                                                                //       .symmetric(
                                                                                //           horizontal:
                                                                                //               3.r),
                                                                                //   child: StarSymbol(
                                                                                //     size: 11.sp,
                                                                                //   ),
                                                                                // ),
                                                                                // Text(
                                                                                //   myBookingResponseModel!
                                                                                //       .data!
                                                                                //       .list![index].totalNoOfRatings!
                                                                                //       .toString(),
                                                                                //   style: TextStyle(
                                                                                //       fontSize:
                                                                                //           11.sp),
                                                                                // )
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              '₹${myBookingResponseModel!.data!.list![index].totalAmount!}',
                                                                              style:
                                                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                                  3.r,
                                                                            ),
                                                                            Text(
                                                                              'Total',
                                                                              style:
                                                                                  TextStyle(fontSize: 12.sp),
                                                                            ),
                                                                            myBookingResponseModel!.data!.list![index].checkinCheckoutFlag == 0
                                                                                ? SizedBox(
                                                                                    height: 10.r,
                                                                                  )
                                                                                : SizedBox(),
                                                                            myBookingResponseModel!.data!.list![index].checkinCheckoutFlag == 0
                                                                                ? GestureDetector(
                                                                                    onTap: () {
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (ctx) => AlertDialog(
                                                                                          title: const Text('Cancel Booking'),
                                                                                          content: const Text('Are you sure you want to\ncancel this order?', style: TextStyle(color: Colors.black)),
                                                                                          actions: <Widget>[
                                                                                            MaterialButton(
                                                                                              child: const Text('Dismiss'),
                                                                                              onPressed: () {
                                                                                                Navigator.of(ctx).pop();
                                                                                              },
                                                                                            ),
                                                                                            MaterialButton(
                                                                                              child: const Text(
                                                                                                'Cancel Booking',
                                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              onPressed: () {
                                                                                                Navigator.of(ctx).pop();
                                                                                                cancelBooking(index);
                                                                                              },
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 30.r,
                                                                                      width: (width - 50),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueGrey),
                                                                                      child: const Center(
                                                                                        child: Text(
                                                                                          'Cancel booking',
                                                                                          style: TextStyle(
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : SizedBox(),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // const Divider(
                                                                  //   color: AppColors.shadowColor,
                                                                  //   height: 80,
                                                                  // ),
                                                                  Container(
                                                                    width: width,
                                                                    decoration: const BoxDecoration(
                                                                        border: Border(
                                                                            left:
                                                                                BorderSide(color: AppColors.shadowColor))),
                                                                    child: Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left:
                                                                                  1.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Booking Date',
                                                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 2,
                                                                              ),
                                                                              Text(
                                                                                '$fromDate - $toDate',
                                                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              7,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left:
                                                                                  1),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Number of Rooms',
                                                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 1,
                                                                              ),
                                                                              Text(
                                                                                myBookingResponseModel!.data!.list![index].childs == "" ? '${myBookingResponseModel!.data!.list![index].noOfRooms} Room - ${(int.parse(myBookingResponseModel!.data!.list![index].adults!)).toString()} People' : '${myBookingResponseModel!.data!.list![index].noOfRooms} Room - ${(int.parse(myBookingResponseModel!.data!.list![index].adults!) + int.parse(myBookingResponseModel!.data!.list![index].childs!)).toString()} People',
                                                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              50,
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            // SubmitButton(width: (width - 10), title: 'Change booking'),
                                                                            myBookingResponseModel!.data!.list![index].checkinCheckoutFlag == 0
                                                                                ? GestureDetector(
                                                                                    onTap: () {
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (ctx) => AlertDialog(
                                                                                          title: const Text('Check In'),
                                                                                          content: Text(
                                                                                              myBookingResponseModel!.data!.list![index].childs != ""
                                                                                                  ? 'Are you sure you want to\ncheck in room ${myBookingResponseModel!.data!.list![index].roomsId!} - ${myBookingResponseModel!.data!.list![index].roomCategory!}?\n\nRooms: ${myBookingResponseModel!.data!.list![index].noOfRooms!}=> Adults: ${myBookingResponseModel!.data!.list![index].adults!} '
                                                                                                      '& Children: ${myBookingResponseModel!.data!.list![index].childs!}'
                                                                                                  : 'Are you sure you want to\ncheck in  room ${myBookingResponseModel!.data!.list![index].roomsId!} - ${myBookingResponseModel!.data!.list![index].roomCategory!}?\n\nRooms: ${myBookingResponseModel!.data!.list![index].noOfRooms!}=> Adults: ${myBookingResponseModel!.data!.list![index].adults!}',
                                                                                              style: const TextStyle(color: Colors.black)),
                                                                                          actions: <Widget>[
                                                                                            MaterialButton(
                                                                                              child: const Text('Dismiss'),
                                                                                              onPressed: () {
                                                                                                Navigator.of(ctx).pop();
                                                                                              },
                                                                                            ),
                                                                                            MaterialButton(
                                                                                              child: const Text(
                                                                                                'Check In',
                                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              onPressed: () {
                                                                                                Navigator.of(ctx).pop();
                                                                                                checkIn(index);
                                                                                              },
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 30.r,
                                                                                      width: (width - 50),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.btnColor),
                                                                                      child: const Center(
                                                                                        child: Text(
                                                                                          'Check in',
                                                                                          style: TextStyle(
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : myBookingResponseModel!.data!.list![index].checkinCheckoutFlag == 1
                                                                                    ? GestureDetector(
                                                                                        onTap: () {
                                                                                          showDialog(
                                                                                            context: context,
                                                                                            builder: (ctx) => AlertDialog(
                                                                                              title: const Text('Check Out'),
                                                                                              content: Text(
                                                                                                  myBookingResponseModel!.data!.list![index].childs != ""
                                                                                                      ? 'Are you sure you want to\ncheck out room ${myBookingResponseModel!.data!.list![index].roomsId!} - ${myBookingResponseModel!.data!.list![index].roomCategory!}?\n\nRooms: ${myBookingResponseModel!.data!.list![index].noOfRooms!}=> Adults: ${myBookingResponseModel!.data!.list![index].adults!} '
                                                                                                          '& Children: ${myBookingResponseModel!.data!.list![index].childs!}'
                                                                                                      : 'Are you sure you want to\ncheck out room ${myBookingResponseModel!.data!.list![index].roomsId!} - ${myBookingResponseModel!.data!.list![index].roomCategory!}?\n\nRooms: ${myBookingResponseModel!.data!.list![index].noOfRooms!}=> Adults: ${myBookingResponseModel!.data!.list![index].adults!}',
                                                                                                  style: const TextStyle(color: Colors.black)),
                                                                                              actions: <Widget>[
                                                                                                MaterialButton(
                                                                                                  child: const Text('Dismiss'),
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(ctx).pop();
                                                                                                  },
                                                                                                ),
                                                                                                MaterialButton(
                                                                                                  child: const Text(
                                                                                                    'Check Out',
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(ctx).pop();
                                                                                                    checkOut(index);
                                                                                                  },
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 30.r,
                                                                                          width: (width - 50),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.btnColor),
                                                                                          child: const Center(
                                                                                            child: Text(
                                                                                              'Check Out',
                                                                                              style: TextStyle(
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : SizedBox(),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox();
                                            },
                                          ),
                                        ),
                                      ]),
                              ),
            );
          });
  }

  void getList() async {

    print("sel flag upcoming"+(widget.selectedIndex!).toString());
    myBookingResponseModel = await Get.find<HomeController>()
        .myBookingLists(
        hotel_id: widget.hotel_id, flag: widget.selectedIndex.toString());
    if (myBookingResponseModel!.data!.list != null) {
      if (myBookingResponseModel!.data!.list!.length > 0)
        for (int i = 0; i < myBookingResponseModel!.data!.list!.length; i++) {
          convertDate(i);
        }
    }
  }

  void convertDate(int index) {
    // var strtDate = list!.fromDate!;
    fromDate = DateFormat('dd MMM').format(
        DateTime.parse(myBookingResponseModel!.data!.list![index].fromDate!));
    myBookingResponseModel!.data!.list![index].fromDate = fromDate;
    toDate = DateFormat('dd MMM').format(
        DateTime.parse(myBookingResponseModel!.data!.list![index].toDate!));
    myBookingResponseModel!.data!.list![index].toDate = toDate;
  }

  Future<void> cancelBooking(int index) async {
    await Get.find<HomeController>().cancelBooking(
        id: myBookingResponseModel!.data!.list![index].id.toString());
    setState(() {
      getList();
    });
  }

  Future<void> checkIn(int index) async {
    var now = DateTime.now();
    String checkInDateTime = (DateFormat('yyyy-MM-dd HH:mm:ss').format(now));
    await Get.find<HomeController>().checkIn(
        room_id: myBookingResponseModel!.data!.list![index].roomsId.toString(),
        booking_id: myBookingResponseModel!.data!.list![index].id!.toString(),
        checkInDateTime: checkInDateTime);
    setState(() {
      getList();
    });
  }

  Future<void> checkOut(int index) async {
    var now = DateTime.now();
    String checkOutDateTime = (DateFormat('yyyy-MM-dd HH:mm:ss').format(now));
    await Get.find<HomeController>().checkOut(
        room_id: myBookingResponseModel!.data!.list![index].roomsId.toString(),
        booking_id: myBookingResponseModel!.data!.list![index].id!.toString(),
        checkOutDateTime: checkOutDateTime);
    setState(() {
      getList();
    });
  }

  _launchCaller(String? number) async {
    String url = "tel:${number!}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $url';
    }
  }
}
