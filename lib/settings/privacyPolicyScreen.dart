import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/no_internet_screen.dart';
import '../common/title.dart';
import '../controller/homeController.dart';
import '../model/response/TnCPrivacyPolicyResponseModel.dart';

class PrivacyPOlicyScreen extends StatefulWidget {
  static const String routeName = '/PrivacyPOlicyScreen';

  const PrivacyPOlicyScreen({super.key});

  @override
  State<StatefulWidget> createState() => PrivacyPOlicyScreenState();
}

class PrivacyPOlicyScreenState extends State<PrivacyPOlicyScreen>
    with TickerProviderStateMixin {
  TnCPrivacyPolicyResponseModel? tnCPrivacyPolicyResponseModel;

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
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

    getList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                const CustomTitle(title: 'Privacy policy'),
                SizedBox(
                  height: 20.r,
                ),
                homeController.isLoading &&
                    tnCPrivacyPolicyResponseModel==null
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    :tnCPrivacyPolicyResponseModel!.data==null? const Center(
                  child: CircularProgressIndicator(),
                )
                    :tnCPrivacyPolicyResponseModel!.data!.detail==null? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Card(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Text(
                            tnCPrivacyPolicyResponseModel!.data!.detail![0].termsOfService!,
                            style: const TextStyle(color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),)

                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Future<void> getList() async {
    tnCPrivacyPolicyResponseModel =
    await Get.find<HomeController>().dynamicContent();
  }

}
