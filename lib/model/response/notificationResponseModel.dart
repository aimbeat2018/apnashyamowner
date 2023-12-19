class NotificationResponseModel {
  Data? data;

  NotificationResponseModel({this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Noti>? noti;
  String? status;

  Data({this.code, this.noti, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['noti'] != null) {
      noti = <Noti>[];
      json['noti'].forEach((v) {
        noti!.add(new Noti.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.noti != null) {
      data['noti'] = this.noti!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Noti {
  int? id;
  String? userId;
  String? userName;
  String? hotelsVillasId;
  String? hotelName;
  String? title;
  String? status;
  String? createdAt;

  Noti(
      {this.id,
        this.userId,
        this.userName,
        this.hotelsVillasId,
        this.hotelName,
        this.title,
        this.status,
        this.createdAt});

  Noti.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    hotelsVillasId = json['hotels_villas_id'];
    hotelName = json['hotel_name'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['hotels_villas_id'] = this.hotelsVillasId;
    data['hotel_name'] = this.hotelName;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
