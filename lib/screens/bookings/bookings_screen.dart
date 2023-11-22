

import 'package:apnashyamowner/common/custom_appbar.dart';
import 'package:apnashyamowner/screens/bookings/cancelled_bookings.dart';
import 'package:apnashyamowner/screens/bookings/finished_bookings.dart';
import 'package:apnashyamowner/screens/bookings/upcoming_bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/colors.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with AutomaticKeepAliveClientMixin<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Booking Lists'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Used Custom Widget
              // const CustomTitle(title: 'My Bookings'),
              SizedBox(
                height: 18.r,
              ),
              Container(
                height: 55.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.shadowColor2,
                          offset: Offset(3, 3),
                          blurRadius: 10)
                    ]),
                child: TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  splashBorderRadius: BorderRadius.circular(10),
                  physics: const NeverScrollableScrollPhysics(),
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 13.sp),
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.all(0),
                  indicatorPadding: const EdgeInsets.all(0),
                  tabs: [
                    _individualTab('Upcoming'),
                    _individualTab('Finished'),
                    const Tab(
                      icon: Text('Cancelled'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.r,
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 620.r,
                  child: const TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      UpcomingBookings(),
                      FinishedBooking(),
                      CancelledBooking(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Custom Widegt For Tabbar Titles With Divider
  Widget _individualTab(String title) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 20 + MediaQuery.of(context).padding.bottom,
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(
                right: BorderSide(
                    color: Colors.grey, width: 1, style: BorderStyle.solid))),
        child: Tab(
          icon: Text(title),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
