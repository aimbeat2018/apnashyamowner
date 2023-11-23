
import 'package:apnashyamowner/constant/globalFunction.dart';
import 'package:apnashyamowner/model/response/myHotelsResponseModel.dart';
import 'package:get/get.dart';

import '../constant/repository/homeRepo.dart';
import '../model/response/CommonResponseModel.dart';
import '../model/response/TnCPrivacyPolicyResponseModel.dart';
import '../model/response/helpQuestionAnswersResponseModel.dart';
import '../model/response/loginResponseModel.dart';
import '../model/response/myBookingResponseModel.dart';
import '../model/response/notificationResponseModel.dart';
import '../model/response/otpResponseModel.dart';
import '../model/response/userProfileResponseModel.dart';


class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  // HomeResponseModel? homeResponseModel;
  // AreaResponseModel? areaResponseModel;
  // HotelListingResponseModel? hotelListingResponseModel;
  MyBookingResponseModel? myBookingResponseModel;
  CommonResponseModel? commonResponseModel;
  // CategoryResponseModel? categoryResponseModel;
  // HotelDetailResponseModel? hotelDetailResponseModel;
  // RoomListingResponseModel? roomListingResponseModel;
  // RoomDetailResponseModel? roomDetailResponseModel;
  UserProfileResponseModel? userProfileResponseModel;
  OtpResponseModel? otpResponseModel;
  LoginResponseModel? loginResponseModel;
  HelpQuestionAnswersResponseModel? helpQuestionAnswersResponseModel;
  MyHotelsResponseModel? myHotelsResponseModel;
  TnCPrivacyPolicyResponseModel? tnCPrivacyPolicyResponseModel;
  NotificationResponseModel? notificationResponseModel;
  // CouponsResponseModel? couponsResponseModel;

  bool? _isLoading = false;
  final bool _isDetailsLoading = false;

  bool get isLoading => _isLoading!;

  bool get isDetailsLoading => _isDetailsLoading;

  // Future<HomeResponseModel?> getBanner(
  //     {String? short_type, String? car_parking,
  //       String? rating, String? distance_min,
  //       String? distance_max, String? price_min,
  //       String? price_max,String? categoryId,}) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.banner(short_type,
  //       car_parking,
  //       rating,
  //       distance_min,
  //       distance_max,
  //       price_min,
  //       price_max,
  //       categoryId);
  //
  //   if (response.statusCode == 200) {
  //     homeResponseModel = HomeResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return homeResponseModel;
  // }
  //
  // Future<AreaResponseModel?> getAreaList(String? searchText) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.areaList(searchText);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     areaResponseModel = AreaResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return areaResponseModel;
  // }
  //
  // Future<HotelListingResponseModel?> getCategoryWiseHotels(
  //     String? catId) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.categoryWiseHotels(catId);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     hotelListingResponseModel =
  //         HotelListingResponseModel.fromJson(response.body);
  //     // print(
  //     //     "Category wise hotels - ${hotelListingResponseModel!.data!.hotelsVillas}");
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return hotelListingResponseModel;
  // }
  //
  // Future<HotelDetailResponseModel?> getHotelDetails(String? hotelId) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.hotel_details(hotelId);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     hotelDetailResponseModel =
  //         HotelDetailResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return hotelDetailResponseModel;
  // }
  //
  // Future<CategoryResponseModel?> getCategoriesListing() async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.category_listing();
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     categoryResponseModel = CategoryResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return categoryResponseModel;
  // }
  //
  // Future<CommonResponseModel?> addHotelToWishlist(String? hotelId) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.addHotelToWishlist(hotelId);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     commonResponseModel = CommonResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return commonResponseModel;
  // }
  //
  // Future<CommonResponseModel?> removeHotelFromWishlist(String? hotelId) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.removeHotelFromWishlist(hotelId);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     commonResponseModel = CommonResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return commonResponseModel;
  // }
  //
  // Future<CommonResponseModel?> submitReview(String? hotelId, String? review,
  //     String? rating) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.writeReview(
  //       hotel_id: hotelId, review: review, rating: rating);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     commonResponseModel = CommonResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return commonResponseModel;
  // }
  //
  // Future<RoomListingResponseModel?> getRoomListing(String? hotelId) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.room_listing(hotelId);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     roomListingResponseModel =
  //         RoomListingResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return roomListingResponseModel;
  // }
  //
  // Future<RoomDetailResponseModel?> getRoomDetails(String? roomId) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response = await homeRepo.room_details(roomId);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     roomDetailResponseModel = RoomDetailResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return roomDetailResponseModel;
  // }
  //
  Future<UserProfileResponseModel?> getUserProfile() async {
    _isLoading = true;

    // update();

    Response response = await homeRepo.userDetail();

    if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      // homeResponseModel = toResponseList(data);
      userProfileResponseModel =
          UserProfileResponseModel.fromJson(response.body);
    } else {
      // homeResponseModel = [];
      null;
    }

    _isLoading = false;
    update();
    return userProfileResponseModel;
  }
  Future<CommonResponseModel?> ownerChangePassword(String newpassword) async {
    _isLoading = true;

    // update();

    Response response = await homeRepo.userownerChangePassword(newpassword);

    if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      // homeResponseModel = toResponseList(data);
      commonResponseModel =
          CommonResponseModel.fromJson(response.body);
    } else {
      // homeResponseModel = [];
      null;
    }

    _isLoading = false;
    update();
    return commonResponseModel;
  }

  // Future<CommonResponseModel?> updateUserProfile(
  //     {String? email, String? name}) async {
  //   _isLoading = true;
  //
  //   // update();
  //
  //   Response response =
  //   await homeRepo.updateUserDetail(email: email, name: name);
  //
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // homeResponseModel = toResponseList(data);
  //     commonResponseModel = CommonResponseModel.fromJson(response.body);
  //   } else {
  //     // homeResponseModel = [];
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return commonResponseModel;
  // }

  // Future<OtpResponseModel?> getOtp(String? mobile) async {
  //   _isLoading = true;
  //
  //   Response response = await homeRepo.otp(mobile);
  //
  //   if (response.statusCode == 200) {
  //     otpResponseModel = OtpResponseModel.fromJson(response.body);
  //   } else {
  //     otpResponseModel;
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return otpResponseModel;
  // }

  Future<LoginResponseModel?> doLoginOrReg(String? email, String? password) async {
    _isLoading = true;

    Response response = await homeRepo.login(email, password);

    if (response.statusCode == 200) {
      loginResponseModel = LoginResponseModel.fromJson(response.body);

      // showCustomSnackBar(loginResponseModel!.data!.authToken!);
      homeRepo.saveUserToken(loginResponseModel!.data!.authToken!);
      homeRepo.saveEmail(email!);
    } else {
      loginResponseModel;
      null;
    }
    _isLoading = false;
    update();
    return loginResponseModel;
  }

  Future<HelpQuestionAnswersResponseModel?> helpQuestionList() async {
    _isLoading = true;

    Response response = await homeRepo.helpQuestionList();

    if (response.statusCode == 200) {
      helpQuestionAnswersResponseModel =
          HelpQuestionAnswersResponseModel.fromJson(response.body);
    } else {
      helpQuestionAnswersResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return helpQuestionAnswersResponseModel;
  }

  Future<MyHotelsResponseModel?> hotelListingApi() async {
    _isLoading = true;

    Response response = await homeRepo.hotelListing();

    if (response.statusCode == 200) {
      myHotelsResponseModel =
          MyHotelsResponseModel.fromJson(response.body);
    } else {
      myHotelsResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return myHotelsResponseModel;
  }

  // Future<CommonResponseModel?> submitBookings(String? hotelId,
  //     String? roomId,
  //     String? noOfRooms,
  //     String? adults,
  //     String? childs,
  //     String? fromDate,
  //     String? toDate,
  //     String? paymentId,
  //     String? amount,
  //     String? couponId,
  //     String? couponDiscountAmount,
  //     String? totalAmount,
  //     String? paymentType,
  //     String? paymentStatus) async {
  //   _isLoading = true;
  //
  //   Response response = await homeRepo.submitBooking(
  //       hotel_id: hotelId,
  //       room_id: roomId,
  //       no_of_rooms: noOfRooms,
  //       adults: adults,
  //       childs: childs,
  //       from_date: fromDate,
  //       to_date: toDate,
  //       payment_id: paymentId,
  //       amount: amount,
  //       coupon_id: couponId,
  //       coupon_discount_amount: couponDiscountAmount,
  //       total_amount: totalAmount,
  //       payment_type: paymentType,
  //       payment_status: paymentStatus);
  //
  //   if (response.statusCode == 200) {
  //     commonResponseModel = CommonResponseModel.fromJson(response.body);
  //   } else {
  //     commonResponseModel;
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return commonResponseModel;
  // }
  //
  //
  // Future<HotelListingResponseModel?> searchHotels({String? area_id,
  //   String? text,
  //   String? check_in,
  //   String? check_out,
  //   String? no_of_rooms,
  //   String? adult,
  //   String? children}) async {
  //   _isLoading = true;
  //
  //   Response response = await homeRepo.searchApi(
  //       area_id: area_id,
  //       text: text,
  //       check_in: check_in,
  //       check_out: check_out,
  //       no_of_rooms: no_of_rooms,
  //       adult: adult,
  //       children: children);
  //
  //   if (response.statusCode == 200) {
  //     hotelListingResponseModel =
  //         HotelListingResponseModel.fromJson(response.body);
  //   } else {
  //     hotelListingResponseModel;
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return hotelListingResponseModel;
  // }
  //
  Future<MyBookingResponseModel?> myBookingLists({String? hotel_id,String? flag}) async {
    _isLoading = true;

    Response response = await homeRepo.myBookingList(
        hotel_id: hotel_id,flag: flag);

    if (response.statusCode == 200) {
      myBookingResponseModel = MyBookingResponseModel.fromJson(response.body);
    } else {
      myBookingResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return myBookingResponseModel;
  }
  //
  // Future<FavouriteHotelsListingResponseModel?> favHotelsListing() async {
  //   _isLoading = true;
  //
  //   Response response = await homeRepo.favHotels();
  //
  //   if (response.statusCode == 200) {
  //     favHotelsLists = FavouriteHotelsListingResponseModel.fromJson(response.body);
  //   } else {
  //     favHotelsLists;
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return favHotelsLists;
  // }
  //
  //
  Future<CommonResponseModel?> cancelBooking({String? id}) async {
    _isLoading = true;

    Response response = await homeRepo.cancelBooking(
        id: id);

    if (response.statusCode == 200) {
      commonResponseModel = CommonResponseModel.fromJson(response.body);
    } else {
      commonResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return commonResponseModel;
  }

  Future<CommonResponseModel?> checkIn({String? room_id,String? booking_id,String? checkInDateTime}) async {
    _isLoading = true;

    Response response = await homeRepo.checkIn(
        room_id: room_id,
        booking_id: booking_id,
        checkInDateTime: checkInDateTime);

    if (response.statusCode == 200) {
      commonResponseModel = CommonResponseModel.fromJson(response.body);
      GlobalFunctions.showSuccessToast('Check In Successfully!');
    } else {
      commonResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return commonResponseModel;
  }

  Future<CommonResponseModel?> checkOut({String? room_id,String? booking_id,String? checkOutDateTime}) async {
    _isLoading = true;

    Response response = await homeRepo.checkOut(
        room_id: room_id,
        booking_id: booking_id,
        checkOutDateTime: checkOutDateTime);

    if (response.statusCode == 200) {
      commonResponseModel = CommonResponseModel.fromJson(response.body);
      GlobalFunctions.showSuccessToast('Check Out Successfully!');
    } else {
      commonResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return commonResponseModel;
  }
  //
  //
  // Future<CommonResponseModel?> storeSearch({String? id}) async {
  //   _isLoading = true;
  //
  //   Response response = await homeRepo.storeSearch(
  //       id: id);
  //
  //   if (response.statusCode == 200) {
  //     commonResponseModel = CommonResponseModel.fromJson(response.body);
  //   } else {
  //     commonResponseModel;
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return commonResponseModel;
  // }
  //
  // Future<CouponsResponseModel?> couponsListing() async {
  //   _isLoading = true;
  //
  //   Response response = await homeRepo.coupons();
  //
  //   if (response.statusCode == 200) {
  //     couponsResponseModel = CouponsResponseModel.fromJson(response.body);
  //   } else {
  //     couponsResponseModel;
  //     null;
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return couponsResponseModel;
  // }
  //
  //
  Future<TnCPrivacyPolicyResponseModel?> dynamicContent() async {
    _isLoading = true;

    Response response = await homeRepo.tncDynamicContent();

    if (response.statusCode == 200) {
      tnCPrivacyPolicyResponseModel = TnCPrivacyPolicyResponseModel.fromJson(response.body);
    } else {
      tnCPrivacyPolicyResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return tnCPrivacyPolicyResponseModel;
  }


  Future<NotificationResponseModel?> notificationListing() async {
    _isLoading = true;

    Response response = await homeRepo.notificationListing();

    if (response.statusCode == 200) {
      notificationResponseModel = NotificationResponseModel.fromJson(response.body);
    } else {
      notificationResponseModel;
      null;
    }

    _isLoading = false;
    update();
    return notificationResponseModel;
  }
  //
  //
  //
  //
  // List<HomeResponseModel> toResponseList(List<dynamic> data) {
  //   List<HomeResponseModel> value = <HomeResponseModel>[];
  //   for (var element in data) {
  //     value.add(HomeResponseModel.fromJson(element));
  //   }
  //   return value;
  // }

  String getUserToken() {
    return homeRepo.getUserToken();
  }

  String getUserId() {
    return homeRepo.getUserId();
  }

  String getname() {
    return homeRepo.getname();
  }

  String getemail() {
    return homeRepo.getemail();
  }

  String getimage() {
    return homeRepo.getimage();
  }

  String getmobile() {
    return homeRepo.getmobile();
  }
}
