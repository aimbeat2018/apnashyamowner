import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/no_internet_screen.dart';
import '../../../constant/routes.dart';
import '../../common/profile_sections.dart';
import '../../constant/images/images.dart';
import '../../constant/texts/texts.dart';
import '../../controller/homeController.dart';
import '../../model/response/helpQuestionAnswersResponseModel.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  HelpQuestionAnswersResponseModel? helpQuestionAnswersResponseModel;

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

    getHelpQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<HomeController>(builder: (homeController) {
            return Scaffold(
              // floatingActionButton: FloatingActionButton(
              //   backgroundColor: Theme
              //       .of(context)
              //       .cardColor,
              //   child: Icon(
              //     Icons.support_agent,
              //     color: Theme
              //         .of(context)
              //         .primaryColor,
              //     size: 50,
              //   ),
              //   onPressed: () =>
              //       Navigator.pushNamed(context, MyRoutes.helpSupportMessageScreen),
              // ),
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 315.r,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(
                              hawaii,
                            ),
                            fit: BoxFit.fill,
                            opacity: 0.6)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 108.r, left: 18.r),
                      child: Text(
                          textAlign: TextAlign.left,
                          'Hello, How can we\nhelp you?',
                          style: GoogleFonts.rozhaOne(
                            height: 1,
                            fontSize: 30.sp,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          kFAQ,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 13.r,
                                  ),
                        ),
                        homeController.isLoading &&
                                helpQuestionAnswersResponseModel == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : helpQuestionAnswersResponseModel!.data == null
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : helpQuestionAnswersResponseModel!
                                            .data!.code=="201"
                                        ? const Center(
                                            child:
                                                Column(
                                                  children: [
                                                    SizedBox(height: 100,),
                                                    Text("No questions added yet!"),
                                                  ],
                                                ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                helpQuestionAnswersResponseModel!
                                                    .data!.list!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 20,
                                                ),
                                                child: ProfileSections(
                                                    onTap: () =>
                                                        Navigator.pushNamed(
                                                          context,
                                                          MyRoutes.answerScreen,
                                                          arguments: [
                                                            helpQuestionAnswersResponseModel!
                                                                .data!
                                                                .list![index]
                                                                .question!,
                                                            helpQuestionAnswersResponseModel!
                                                                .data!
                                                                .list![index]
                                                                .answer!
                                                          ],
                                                        ),
                                                    label:
                                                        helpQuestionAnswersResponseModel!
                                                            .data!
                                                            .list![index]
                                                            .question!),
                                              );
                                            },
                                          ),
                        SizedBox(
                          height: 8.r,
                        ),
                        // Text(
                        //   'Read more',
                        //   style: TextStyle(color: Theme
                        //       .of(context)
                        //       .primaryColor),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
  }

  void getHelpQuestions() async {
    helpQuestionAnswersResponseModel =
        await Get.find<HomeController>().helpQuestionList();
  }
}
