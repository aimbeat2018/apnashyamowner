class NotificationResponseModel {
  Data? data;

  NotificationResponseModel({this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Noti>? noti;
  String? status;

  Data({this.code, this.noti, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['noti'] != null) {
      noti = <Noti>[];
      json['noti'].forEach((v) {
        noti!.add(Noti.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (noti != null) {
      data['noti'] = noti!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Noti {
  int? id;
  String? title;
  String? createdAt;

  Noti({this.id, this.title, this.createdAt});

  Noti.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['created_at'] = createdAt;
    return data;
  }
}
