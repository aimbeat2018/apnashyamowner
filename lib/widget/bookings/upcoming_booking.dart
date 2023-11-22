import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../colors/colors.dart';
import '../../controller/homeController.dart';
import '../../model/response/myBookingResponseModel.dart';

class UpcomingBookingContainer extends StatelessWidget {
  // If isFinised true then it will show Finished Widget Otherwise it will show upcoming widget

  final bool? isFinished;
  final List1? list;
  String? fromDate, toDate;

  UpcomingBookingContainer({super.key, this.isFinished, this.list});



  @override
  Widget build(BuildContext context) {
    convertDate();
    var width = (ScreenUtil().screenWidth * .5) - 20.r;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(list!.hotelImage!), fit: BoxFit.fill)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list!.hotelsName!,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 3.r,
                  ),
                  Text(list!.location!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 13.sp)),
                  SizedBox(
                    height: 3.r,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 11.sp,
                      ),
                      SizedBox(
                        width: 3.r,
                      ),
                      Text(
                        '${list!.distance!} km to city',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 3.r),
                      //   child: StarSymbol(
                      //     size: 11.sp,
                      //   ),
                      // ),
                      Text(
                        list!.totalNoOfRatings!.toString(),
                        style: TextStyle(fontSize: 11.sp),
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${list!.amount!}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 3.r,
                  ),
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              )
            ],
          ),
          const Divider(
            color: AppColors.shadowColor,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Travel Date',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 12.sp),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '$fromDate - $toDate',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(color: AppColors.shadowColor))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Number of Rooms',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 12.sp),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          list!.childs == ""
                              ? '${list!.noOfRooms} Room - ${(int.parse(list!.adults!)).toString()} People'
                              : '${list!.noOfRooms} Room - ${(int.parse(list!.adults!) + int.parse(list!.childs!)).toString()} People',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // isFinished != null?
          //     SubmitButton(
          //         title: 'Write a review',
          //         onTap: () => Navigator.push(
          //             context,
          //             PageTransition(
          //                 child: WriteReview(hotelId: list!.hotelsVillasId!),
          //                 type: PageTransitionType.fade)),
          //       )
          //     :const SizedBox()
        ],
      ),
    );
  }

  void convertDate() {
    // var strtDate = list!.fromDate!;
fromDate = DateFormat('dd MMM').format(DateTime.parse(list!.fromDate!));
toDate = DateFormat('dd MMM').format(DateTime.parse(list!.toDate!));

  }

  Future<void> cancelBooking() async {
    await Get.find<HomeController>().cancelBooking(id: list!.id.toString());

  }
}
