import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_client.dart';
import '../app_constants.dart';

class HomeRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  HomeRepo({required this.apiClient, required this.sharedPreferences});


  // Future<Response> areaList(String? searchText) async {
  //   return await apiClient
  //       .postData(AppConstants.home, {"area": searchText});
  // }

  Future<Response> hotelListing() async {
    return await apiClient.postData(
        AppConstants.hotel_list, {});
  }

  Future<Response> room_listing(String? hotelId) async {
    return await apiClient
        .postData(AppConstants.room_listing, {"hotel_id": hotelId});
  }

  Future<Response> hotel_details(String? hotelId) async {
    return await apiClient
        .postData(AppConstants.hotel_details, {"hotel_id": hotelId});
  }

  Future<Response> category_listing() async {
    return await apiClient.postData(AppConstants.category_listing, {});
  }

  Future<Response> addHotelToWishlist(String? hotelId) async {
    return await apiClient
        .postData(AppConstants.add_wishlist, {"hotel_id": hotelId});
  }

  Future<Response> removeHotelFromWishlist(String? hotelId) async {
    return await apiClient
        .postData(AppConstants.remove_wishlist, {"hotel_id": hotelId});
  }

  Future<Response> writeReview(
      {String? hotel_id, String? review, String? rating}) async {
    return await apiClient.postData(AppConstants.reviews,
        {"hotel_id": hotel_id, "rating": rating, "review": review});
  }

  Future<Response> room_details(String? roomId) async {
    return await apiClient
        .postData(AppConstants.room_details, {"room_id": roomId});
  }

  Future<Response> userDetail() async {
    return await apiClient.postData(AppConstants.profile, {});
  }

  Future<Response> userownerChangePassword(String newpassword) async {
    return await apiClient.postData(AppConstants.ownerChangePassword, {"newpassword": newpassword});
  }

  Future<Response> updateUserDetail({String? email, String? name}) async {
    return await apiClient
        .postData(AppConstants.profile_update, {"email": email, "name": name});
  }

  // Future<Response> otp(String? phone) async {
  //   return await apiClient.postData(AppConstants.otp, {"mobile": phone});
  // }

  Future<Response> login(String? email, String? password) async {
    return await apiClient.postData(AppConstants.login, {"email": email,"password": password});
  }

  Future<Response> helpQuestionList() async {
    return await apiClient.getData(AppConstants.help_question_list);
  }

  Future<Response> submitBooking(
      {String? hotel_id,
      String? room_id,
      String? no_of_rooms,
      String? adults,
      String? childs,
      String? from_date,
      String? to_date,
      String? payment_id,
      String? amount,
      String? coupon_id,
      String? coupon_discount_amount,
      String? total_amount,
      String? payment_type,
      String? payment_status}) async {
    return await apiClient.postData(AppConstants.booking, {
      "hotel_id": hotel_id,
      "room_id": room_id,
      "no_of_rooms": no_of_rooms,
      "adults": adults,
      "childs": childs,
      "from_date": from_date,
      "to_date": to_date,
      "payment_id": payment_id,
      "amount": amount,
      "coupon_id": coupon_id,
      "coupon_discount_amount": coupon_discount_amount,
      "total_amount": total_amount,
      "payment_type": payment_type,
      "payment_status": payment_status
    });
  }

  Future<Response> searchApi(
      {String? area_id,
      String? text,
      String? check_in,
      String? check_out,
      String? no_of_rooms,
      String? adult,
      String? children}) async {
    return await apiClient.postData(AppConstants.search, {
      "area_id": area_id,
      "text": text,
      "check_in": check_in,
      "check_out": check_out,
      "no_of_rooms": no_of_rooms,
      "adult": adult,
      "children": children
    });
  }


  Future<Response> myBookingList({String? hotel_id,String? flag}) async {
    return await apiClient
        .postData(AppConstants.home, {"hotel_id": hotel_id,"flag": flag});
  }

  Future<Response> cancelBooking({String? id}) async {
    return await apiClient
        .postData(AppConstants.booking_cancel, {"booking_id": id});
  }

  Future<Response> checkIn({String? room_id,String? booking_id,String? checkInDateTime}) async {
    return await apiClient
        .postData(AppConstants.owner_check_in, {"room_id": room_id,"booking_id": booking_id,"checkInDateTime": checkInDateTime,});
  }


  Future<Response> checkOut({String? room_id,String? booking_id,String? checkOutDateTime}) async {
    return await apiClient
        .postData(AppConstants.owner_check_out, {"room_id": room_id,"booking_id": booking_id,"checkOutDateTime": checkOutDateTime,});
  }

  Future<Response> storeSearch({String? id}) async {
    return await apiClient
        .postData(AppConstants.store_search, {"hotel_id": id});
  }

  Future<Response> coupons() async {
    return await apiClient
        .getData(AppConstants.coupons);
  }

  Future<Response> tncDynamicContent() async {
    return await apiClient
        .getData(AppConstants.tnc_pp);
  }

  Future<Response> notificationListing() async {
    return await apiClient
        .getData(AppConstants.notifications);
  }


  // Future<Response> favHotels() async {
  //   return await apiClient
  //       .postData(AppConstants.favorate_hotels, {});
  // }



  /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<bool> saveUserId(String userId) async {
    return await sharedPreferences.setString(AppConstants.userId, userId);
  }

  Future<bool> savename(String name) async {
    return await sharedPreferences.setString(AppConstants.name, name);
  }

  Future<bool> saveemail(String email) async {
    return await sharedPreferences.setString(AppConstants.email, email);
  }

  Future<bool> saveimage(String image) async {
    return await sharedPreferences.setString(AppConstants.image, image);
  }

  Future<bool> saveEmail(String mobile) async {
    return await sharedPreferences.setString(AppConstants.email, mobile);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  String getname() {
    return sharedPreferences.getString(AppConstants.name) ?? "";
  }

  String getemail() {
    return sharedPreferences.getString(AppConstants.email) ?? "";
  }

  String getimage() {
    return sharedPreferences.getString(AppConstants.image) ?? "";
  }

  String getmobile() {
    return sharedPreferences.getString(AppConstants.email) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
