class OtpResponseModel {
  Data? data;

  OtpResponseModel({this.data});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? mobile;
  int? otp;
  String? status;

  Data({this.code, this.mobile, this.otp, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    mobile = json['mobile'];
    otp = json['otp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['mobile'] = mobile;
    data['otp'] = otp;
    data['status'] = status;
    return data;
  }
}
