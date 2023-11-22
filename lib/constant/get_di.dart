import 'package:apnashyamowner/constant/repository/homeRepo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../controller/homeController.dart';
import 'app_constants.dart';

Future<void> init() async {

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => HomeRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() =>
  //     AttendanceRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(
  //     () => SalonRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  // Get.lazyPut(() =>
  //     DistributorRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(
  //     () => CampaignRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(
  //     () => TargetRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => HomeController(homeRepo: Get.find()));
  // Get.lazyPut(() => AttendanceController(attendanceRepo: Get.find()));
  // Get.lazyPut(() => SalonController(salonRepo: Get.find()));
  // Get.lazyPut(() => CartController(cartRepo: Get.find()));
  // Get.lazyPut(() => DistributorController(distributorRepo: Get.find()));
  // Get.lazyPut(() => CampaignController(campaignRepo: Get.find()));
  // Get.lazyPut(() => TargetController(targetRepo: Get.find()));
}
