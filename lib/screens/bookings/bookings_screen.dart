import 'dart:async';

import 'package:apnashyamowner/common/custom_appbar.dart';
import 'package:apnashyamowner/constant/globalFunction.dart';
import 'package:apnashyamowner/model/response/myHotelsResponseModel.dart';
import 'package:apnashyamowner/screens/bookings/cancelled_bookings.dart';
import 'package:apnashyamowner/screens/bookings/finished_bookings.dart';
import 'package:apnashyamowner/screens/bookings/upcoming_bookings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../colors/colors.dart';
import '../../constant/internetConnectivity.dart';
import '../../controller/homeController.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin<BookingsScreen> {
  MyHotelsResponseModel? myHotelsResponseModel;
  // We need a TabController to control the selected tab programmatically
  late final _tabController = TabController(length: 3, vsync: this);

  // List<String> items = [];
  // List<String> itemsId = [];
  String? selectedValue;
  int _selectedIndex=0;

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

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
      getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Booking Lists'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Used Custom Widget
              // const CustomTitle(title: 'My Bookings'),
              SizedBox(
                height: 18.r,
              ),
              myHotelsResponseModel == null
                  ? SizedBox()
                  : myHotelsResponseModel!.data == null
                      ? SizedBox()
                      : myHotelsResponseModel!.data!.profile != null
                          ? DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    Icon(
                                      Icons.hotel,
                                      size: 16,
                                      color: AppColors.btnColor,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Hotel',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.btnColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: myHotelsResponseModel!.data!.profile!
                                    .map((Profile item) =>
                                        DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text(
                                            item.title!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.btnColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue = value;
                                    setState(() {
                                      // _tabController.index = 0;
                                      _tabController.animateTo(_selectedIndex);
                                    });
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 160,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: CupertinoColors.lightBackgroundGray,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: AppColors.btnColor,
                                  iconDisabledColor: AppColors.btnColor,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: CupertinoColors.lightBackgroundGray,
                                  ),
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            )
                          : SizedBox(),

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
                  controller: _tabController,
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
                  onTap: (value) {
                    _selectedIndex=value;
                    setState(() {

                    });
                    // if(value==0){
                    //   UpcomingBookings(hotel_id: selectedValue!);
                    // }else if(value==1){
                    // FinishedBooking(hotel_id: selectedValue!);
                    // }else if(value==2){
                    //   CancelledBooking(hotel_id: selectedValue!);
                    // }
                  },
                ),
              ),
              SizedBox(
                height: 18.r,
              ),
              selectedValue!=null
              ?Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 620.r,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      UpcomingBookings(hotel_id: selectedValue!, selectedIndex:_selectedIndex+1),
                      FinishedBooking(hotel_id: selectedValue!, selectedIndex:_selectedIndex+1),
                      CancelledBooking(hotel_id: selectedValue!, selectedIndex:_selectedIndex+1),
                    ],
                  ),
                ),
              ):SizedBox(),
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

  void getList() async {
    myHotelsResponseModel = await Get.find<HomeController>().hotelListingApi();

    if(myHotelsResponseModel!.data!.profile!.length>0)
    selectedValue = myHotelsResponseModel!.data!.profile![0].id.toString();
    // items = [];
    // itemsId = [];
    //
    // for (int i = 0; i < myHotelsResponseModel!.data!.profile!.length; i++) {
    //   items.add(myHotelsResponseModel!.data!.profile![i].title!);
    //   itemsId.add(myHotelsResponseModel!.data!.profile![i].id.toString());
    // }
    // print(items);

    setState(() {});
  }
}
