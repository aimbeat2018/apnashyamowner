class TnCPrivacyPolicyResponseModel {
  Data? data;

  TnCPrivacyPolicyResponseModel({this.data});

  TnCPrivacyPolicyResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Detail>? detail;
  String? message;
  String? status;

  Data({this.code, this.detail, this.message, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(Detail.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (detail != null) {
      data['detail'] = detail!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Detail {
  int? id;
  String? termsOfService;
  String? privacyPolicy;

  Detail({this.id, this.termsOfService, this.privacyPolicy});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    termsOfService = json['terms_of_service'];
    privacyPolicy = json['privacy_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['terms_of_service'] = termsOfService;
    data['privacy_policy'] = privacyPolicy;
    return data;
  }
}
