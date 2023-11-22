class UserProfileResponseModel {
  Data? data;

  UserProfileResponseModel({this.data});

  UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Profile>? profile;
  String? message;
  String? status;

  Data({this.code, this.profile, this.message, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['profile'] != null) {
      profile = <Profile>[];
      json['profile'].forEach((v) {
        profile!.add(new Profile.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.profile != null) {
      data['profile'] = this.profile!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Profile {
  int? id;
  String? areaId;
  String? name;
  String? email;
  int? mobile;
  String? emailVerifiedAt;
  String? type;
  String? active;
  String? createdAt;
  String? updatedAt;
  String? areaName;

  Profile(
      {this.id,
        this.areaId,
        this.name,
        this.email,
        this.mobile,
        this.emailVerifiedAt,
        this.type,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.areaName});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaId = json['area_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    areaName = json['area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area_id'] = this.areaId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['type'] = this.type;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['area_name'] = this.areaName;
    return data;
  }
}
