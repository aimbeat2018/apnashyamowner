class MyHotelsResponseModel {
  Data? data;

  MyHotelsResponseModel({this.data});

  MyHotelsResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? areaName;
  String? categoryId;
  String? categoryName;
  String? ownerId;
  String? ownerName;
  String? title;
  String? description;
  String? bestDeal;
  String? distance;
  String? image;
  String? createdAt;
  int? review;
  int? rating;
  List<Features>? features;

  Profile(
      {this.id,
        this.areaId,
        this.areaName,
        this.categoryId,
        this.categoryName,
        this.ownerId,
        this.ownerName,
        this.title,
        this.description,
        this.bestDeal,
        this.distance,
        this.image,
        this.createdAt,
        this.review,
        this.rating,
        this.features});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaId = json['area_id'];
    areaName = json['area_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    ownerId = json['owner_id'];
    ownerName = json['owner_name'];
    title = json['title'];
    description = json['description'];
    bestDeal = json['best_deal'];
    distance = json['distance'];
    image = json['image'];
    createdAt = json['created_at'];
    review = json['review'];
    rating = json['rating'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['owner_id'] = this.ownerId;
    data['owner_name'] = this.ownerName;
    data['title'] = this.title;
    data['description'] = this.description;
    data['best_deal'] = this.bestDeal;
    data['distance'] = this.distance;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['review'] = this.review;
    data['rating'] = this.rating;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? featureName;

  Features({this.featureName});

  Features.fromJson(Map<String, dynamic> json) {
    featureName = json['feature_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feature_name'] = this.featureName;
    return data;
  }
}
