import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_constants.dart';
import 'colorsConstant.dart';
import 'internetConnectivity.dart';

class NoInternetScreen extends StatefulWidget {
  final Function? onTapRetry;

  const NoInternetScreen({super.key, this.onTapRetry});

  @override
  NoInternetScreenState createState() => NoInternetScreenState();
}

class NoInternetScreenState extends State<NoInternetScreen> {
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: _connectionStatus == AppConstants.connectivityCheck
          ? const NoInternetScreen()
          : Scaffold(
              body: Container(
              margin: EdgeInsetsDirectional.only(
                  start: width / 10.0, end: width / 10.0, top: height / 5.0),
              width: width,
              child: Column(children: [
                Image.asset(
                  "assets/images/no_internet.png",
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: height / 20.0),
                Text(
                  'whoops',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 26,
                      fontWeight: FontWeight.w700),
                  maxLines: 2,
                ),
                const SizedBox(height: 5.0),
                const Text(
                    'Could not connect to the internet. please check your network.',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                InkWell(
                    onTap: () {
                      setState(() {});
                      Future.delayed(const Duration(seconds: 3), () {
                        CheckInternet.initConnectivity();
                        setState(() {});
                      });
                    },
                    child: Container(
                        margin: EdgeInsetsDirectional.only(top: height / 10.0),
                        padding: EdgeInsetsDirectional.only(
                            top: height / 70.0,
                            bottom: 10.0,
                            start: width / 20.0,
                            end: width / 20.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: const Text("Try again",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)))),
              ]),
            )),
    );
  }
}
