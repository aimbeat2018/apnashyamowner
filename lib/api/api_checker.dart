import 'package:get/get.dart';
import '../constant/custom_snackbar.dart';
import '../constant/routes.dart';

class ApiChecker {
  static void checkApi(Response response) {
  if (response.statusCode == 401) {
    Get.offAllNamed(MyRoutes.logIn);
  } else {
    showCustomSnackBar(response.statusText!);
  }
  }
}
