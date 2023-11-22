class HelpQuestionAnswersResponseModel {
  Data? data;

  HelpQuestionAnswersResponseModel({this.data});

  HelpQuestionAnswersResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<DataList>? list;
  String? message;
  String? status;

  Data({this.code, this.list, this.message, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['list'] != null) {
      list = <DataList>[];
      json['list'].forEach((v) {
        list!.add(DataList.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class DataList {
  int? id;
  String? question;
  String? answer;
  String? createdAt;

  DataList({this.id, this.question, this.answer, this.createdAt});

  DataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['created_at'] = createdAt;
    return data;
  }
}
