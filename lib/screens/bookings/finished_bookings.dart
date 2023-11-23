import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../colors/colors.dart';
import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controller/homeController.dart';
import '../../model/response/myBookingResponseModel.dart';
import '../../widget/bookings/upcoming_booking.dart';

class FinishedBooking extends StatefulWidget {
  String? hotel_id;
   FinishedBooking({super.key, this.hotel_id});

  @override
  State<FinishedBooking> createState() => _FinishedBookingState();
}

class _FinishedBookingState extends State<FinishedBooking> {
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
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = (ScreenUtil().screenWidth * .5) - 20.r;
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        body: homeController.isLoading &&
            myBookingResponseModel == null ?
        const Center(child: CircularProgressIndicator(),)
            : myBookingResponseModel!.data == null ?
        const Center(child: CircularProgressIndicator(),)
            :  myBookingResponseModel!.data!.code == "201"
            ? const Center(
          child: Text("Data not found!"),

        ): myBookingResponseModel!.data!.list == null ?
        const Center(child: Center(child: Text('No records found!')),)
            : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: myBookingResponseModel!
                      .data!.list!.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    return /*UpcomingBookingContainer(list: myBookingResponseModel!
                        .data!.list![index]);*/
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          elevation: 5,
                          color: CupertinoColors.lightBackgroundGray,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 15, bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                myBookingResponseModel!
                                                    .data!.list![index].userName!,
                                                style: TextStyle(
                                                    color: AppColors.btnColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 16.sp),
                                              ),
                                              SizedBox(
                                                height: 3.r,
                                              ),
                                              Text(
                                                  myBookingResponseModel!
                                                      .data!.list![index].roomCategory!,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                      fontSize:
                                                      13.sp)),

                                              SizedBox(
                                                height: 3.r,
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
                                                    style: TextStyle(
                                                        fontSize:
                                                        11.sp),
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
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 16.sp),
                                              ),
                                              SizedBox(
                                                height: 3.r,
                                              ),
                                              Text(
                                                'Total',
                                                style: TextStyle(
                                                    fontSize: 12.sp),
                                              ),
                                              // SizedBox(
                                              //   height: 10.r,
                                              // ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     showDialog(
                                              //       context: context,
                                              //       builder: (ctx) =>
                                              //           AlertDialog(
                                              //             title: const Text(
                                              //                 'Cancel Booking'),
                                              //             content: const Text(
                                              //                 'Are you sure you want to\ncancel this order?',
                                              //                 style: TextStyle(
                                              //                     color: Colors
                                              //                         .black)),
                                              //             actions: <Widget>[
                                              //               MaterialButton(
                                              //                 child: const Text(
                                              //                     'Dismiss'),
                                              //                 onPressed: () {
                                              //                   Navigator.of(
                                              //                       ctx)
                                              //                       .pop();
                                              //                 },
                                              //               ),
                                              //               MaterialButton(
                                              //                 child: const Text(
                                              //                   'Cancel Booking',
                                              //                   style: TextStyle(
                                              //                       fontWeight:
                                              //                       FontWeight
                                              //                           .bold),
                                              //                 ),
                                              //                 onPressed: () {
                                              //                   Navigator.of(
                                              //                       ctx)
                                              //                       .pop();
                                              //                   cancelBooking(index);
                                              //                 },
                                              //               )
                                              //             ],
                                              //           ),
                                              //     );
                                              //   },
                                              //   child: Container(
                                              //     height: 30.r,
                                              //     width: (width - 50),
                                              //     decoration: BoxDecoration(
                                              //         borderRadius:
                                              //         BorderRadius
                                              //             .circular(10),
                                              //         color: Colors.blueGrey),
                                              //     child: const Center(
                                              //       child: Text(
                                              //         'Cancel booking',
                                              //         style: TextStyle(
                                              //           color: Colors.white,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
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
                                              left: BorderSide(
                                                  color: AppColors
                                                      .shadowColor))),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 1.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  'Booking Date',
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                      fontSize:
                                                      12.sp),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '$fromDate - $toDate',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .w600,
                                                      fontSize:
                                                      14.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(left: 1),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  'Number of Rooms',
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                      fontSize:
                                                      12.sp),
                                                ),
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                                Text(
                                                  myBookingResponseModel!
                                                      .data!
                                                      .list![
                                                  index].childs ==
                                                      ""
                                                      ? '${myBookingResponseModel!.data!.list![index].noOfRooms} Room - ${(int.parse(myBookingResponseModel!.data!.list![index].adults!)).toString()} People'
                                                      : '${myBookingResponseModel!.data!.list![index].noOfRooms} Room - ${(int.parse(myBookingResponseModel!.data!.list![index].adults!) + int.parse(myBookingResponseModel!.data!.list![index].childs!)).toString()} People',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .w600,
                                                      fontSize:
                                                      14.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // const SizedBox(
                                          //   height: 50,
                                          // ),
                                          // Column(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment.start,
                                          //   children: [
                                          //     // SubmitButton(width: (width - 10), title: 'Change booking'),
                                          //
                                          //     GestureDetector(
                                          //       onTap: () {
                                          //         showDialog(
                                          //           context: context,
                                          //           builder: (ctx) =>
                                          //               AlertDialog(
                                          //                 title: const Text(
                                          //                     'Check In'),
                                          //                 content:  Text(
                                          //                     myBookingResponseModel!.data!.list![index].childs!=""?
                                          //                     'Are you sure you want to\ncheck in ${myBookingResponseModel!.data!.list![index].roomCategory!}?\n\nRooms: ${myBookingResponseModel!.data!.list![index].noOfRooms!}=> Adults: ${myBookingResponseModel!.data!.list![index].adults!} '
                                          //                         '& Children: ${myBookingResponseModel!.data!.list![index].childs!}':
                                          //                     'Are you sure you want to\ncheck in ${myBookingResponseModel!.data!.list![index].roomCategory!}?\n\nRooms: ${myBookingResponseModel!.data!.list![index].noOfRooms!}=> Adults: ${myBookingResponseModel!.data!.list![index].adults!}',
                                          //                     style: const TextStyle(
                                          //                         color: Colors
                                          //                             .black)),
                                          //                 actions: <Widget>[
                                          //                   MaterialButton(
                                          //                     child: const Text(
                                          //                         'Dismiss'),
                                          //                     onPressed: () {
                                          //                       Navigator.of(
                                          //                           ctx)
                                          //                           .pop();
                                          //                     },
                                          //                   ),
                                          //                   MaterialButton(
                                          //                     child: const Text(
                                          //                       'Check In',
                                          //                       style: TextStyle(
                                          //                           fontWeight:
                                          //                           FontWeight
                                          //                               .bold),
                                          //                     ),
                                          //                     onPressed: () {
                                          //                       Navigator.of(
                                          //                           ctx)
                                          //                           .pop();
                                          //                       checkIn(index);
                                          //                     },
                                          //                   )
                                          //                 ],
                                          //               ),
                                          //         );
                                          //       },
                                          //       child: Container(
                                          //         height: 30.r,
                                          //         width: (width - 50),
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //             BorderRadius
                                          //                 .circular(10),
                                          //             color: AppColors.btnColor),
                                          //         child: const Center(
                                          //           child: Text(
                                          //             'Check in',
                                          //             style: TextStyle(
                                          //               color: Colors.white,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  },
                ),
              ),
            ),
      );
    });
  }


  void convertDate(int index) {
    // var strtDate = list!.fromDate!;
    fromDate = DateFormat('dd MMM').format(
        DateTime.parse(myBookingResponseModel!.data!.list![index].fromDate!));
    myBookingResponseModel!.data!.list![index].fromDate= fromDate;
    toDate = DateFormat('dd MMM').format(DateTime.parse(myBookingResponseModel!.data!.list![index].toDate!));
    myBookingResponseModel!.data!.list![index].toDate=toDate;
  }

  void getList() async{
    myBookingResponseModel =
    await Get.find<HomeController>().myBookingLists(hotel_id:  widget.hotel_id,flag: "2");

    for (int i = 0; i < myBookingResponseModel!.data!.list!.length; i++) {
      convertDate(i);
    }

  }
}
