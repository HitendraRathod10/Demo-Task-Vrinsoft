class SingleSelectionModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  Null? errors;

  SingleSelectionModel(
      {this.success, this.code, this.message, this.data, this.errors});

  SingleSelectionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class Data {
  List<GenderList>? genderList;

  Data({this.genderList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['gender_list'] != null) {
      genderList = <GenderList>[];
      json['gender_list'].forEach((v) {
        genderList!.add(new GenderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genderList != null) {
      data['gender_list'] = this.genderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GenderList {
  int? id;
  String? title;
  List<SubGender>? subGender;

  GenderList({this.id, this.title, this.subGender});

  GenderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['sub_gender'] != null) {
      subGender = <SubGender>[];
      json['sub_gender'].forEach((v) {
        subGender!.add(new SubGender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.subGender != null) {
      data['sub_gender'] = this.subGender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubGender {
  int? subGenderId;
  String? subGenderTitle;

  SubGender({this.subGenderId, this.subGenderTitle});

  SubGender.fromJson(Map<String, dynamic> json) {
    subGenderId = json['sub_gender_id'];
    subGenderTitle = json['sub_gender_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_gender_id'] = this.subGenderId;
    data['sub_gender_title'] = this.subGenderTitle;
    return data;
  }
}
