class MyBookingResponseModel {
  Data? data;

  MyBookingResponseModel({this.data});

  MyBookingResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? code;
  List<List1>? list;
  String? message;
  String? status;

  Data({this.code, this.list, this.message, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['list'] != null) {
      list = <List1>[];
      json['list'].forEach((v) {
        list!.add(new List1.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class List1 {
  int? id;
  String? ownerId;
  String? userId;
  String? hotelsVillasId;
  String? hotelsName;
  String? hotelImage;
  String? roomsId;
  String? roomCategory;
  String? noOfRooms;
  String? adults;
  String? childs;
  String? fromDate;
  String? toDate;
  String? paymentId;
  String? amount;
  String? couponId;
  String? couponDiscountAmount;
  String? totalAmount;
  String? paymentType;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  String? location;
  String? distance;
  int? totalNoOfRatings;
  String? pricePerNight;
  String? userName;
  String? userMobile;
  String? roomImage;
  String? couponCode;
  String? cappingValue;
  String? coupon;
  int? checkinCheckoutFlag;

  List1(
      {this.id,
        this.ownerId,
        this.userId,
        this.hotelsVillasId,
        this.hotelsName,
        this.hotelImage,
        this.roomsId,
        this.roomCategory,
        this.noOfRooms,
        this.adults,
        this.childs,
        this.fromDate,
        this.toDate,
        this.paymentId,
        this.amount,
        this.couponId,
        this.couponDiscountAmount,
        this.totalAmount,
        this.paymentType,
        this.paymentStatus,
        this.createdAt,
        this.updatedAt,
        this.location,
        this.distance,
        this.totalNoOfRatings,
        this.pricePerNight,
        this.userName,
        this.userMobile,
        this.roomImage,
        this.couponCode,
        this.cappingValue,
        this.coupon,
        this.checkinCheckoutFlag});

  List1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    userId = json['user_id'];
    hotelsVillasId = json['hotels_villas_id'];
    hotelsName = json['hotels_name'];
    hotelImage = json['hotel_image'];
    roomsId = json['rooms_id'];
    roomCategory = json['room_category'];
    noOfRooms = json['no_of_rooms'];
    adults = json['adults'];
    childs = json['childs'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    paymentId = json['payment_id'];
    amount = json['amount'];
    couponId = json['coupon_id'];
    couponDiscountAmount = json['coupon_discount_amount'];
    totalAmount = json['total_amount'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    location = json['location'];
    distance = json['distance'];
    totalNoOfRatings = json['totalNoOfRatings'];
    pricePerNight = json['pricePerNight'];
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    roomImage = json['room_image'];
    couponCode = json['coupon_code'];
    cappingValue = json['capping_value'];
    coupon = json['coupon'];
    checkinCheckoutFlag = json['checkin_checkout_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['user_id'] = this.userId;
    data['hotels_villas_id'] = this.hotelsVillasId;
    data['hotels_name'] = this.hotelsName;
    data['hotel_image'] = this.hotelImage;
    data['rooms_id'] = this.roomsId;
    data['room_category'] = this.roomCategory;
    data['no_of_rooms'] = this.noOfRooms;
    data['adults'] = this.adults;
    data['childs'] = this.childs;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['payment_id'] = this.paymentId;
    data['amount'] = this.amount;
    data['coupon_id'] = this.couponId;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['total_amount'] = this.totalAmount;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['location'] = this.location;
    data['distance'] = this.distance;
    data['totalNoOfRatings'] = this.totalNoOfRatings;
    data['pricePerNight'] = this.pricePerNight;
    data['user_name'] = this.userName;
    data['user_mobile'] = this.userMobile;
    data['room_image'] = this.roomImage;
    data['coupon_code'] = this.couponCode;
    data['capping_value'] = this.cappingValue;
    data['coupon'] = this.coupon;
    data['checkin_checkout_flag'] = this.checkinCheckoutFlag;
    return data;
  }
}
