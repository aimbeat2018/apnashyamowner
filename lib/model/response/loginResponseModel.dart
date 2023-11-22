class LoginResponseModel {
  Data? data;

  LoginResponseModel({this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? code;
  String? authToken;
  int? otp;
  String? message;
  String? status;

  Data({this.code, this.authToken, this.otp, this.message, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    authToken = json['auth_token'];
    otp = json['otp'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['auth_token'] = authToken;
    data['otp'] = otp;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
