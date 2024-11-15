class MultipleSelectionModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  Null? errors;

  MultipleSelectionModel(
      {this.success, this.code, this.message, this.data, this.errors});

  MultipleSelectionModel.fromJson(Map<String, dynamic> json) {
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
  List<InterestList>? interestList;
  bool? isChecked;

  Data({this.interestList, this.isChecked});

  Data.fromJson(Map<String, dynamic> json) {
    isChecked = json['is_Checked'] ?? false;
    if (json['interest_list'] != null) {
      interestList = <InterestList>[];
      json['interest_list'].forEach((v) {
        interestList!.add(new InterestList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_Checked'] = this.isChecked;
    if (this.interestList != null) {
      data['interest_list'] =
          this.interestList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InterestList {
  int? id;
  String? title;
  bool? isChecked;
  List<SubInterest>? subInterest;

  InterestList({this.id, this.title, this.subInterest, this.isChecked});

  InterestList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isChecked = json['is_checked'] ?? false;
    if (json['sub_interest'] != null) {
      subInterest = <SubInterest>[];
      json['sub_interest'].forEach((v) {
        subInterest!.add(new SubInterest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['is_checked'] = this.isChecked;
    if (this.subInterest != null) {
      data['sub_interest'] = this.subInterest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubInterest {
  int? subInterestId;
  String? subInterestTitle;
  bool? isChecked;

  SubInterest({this.subInterestId, this.subInterestTitle, this.isChecked});

  SubInterest.fromJson(Map<String, dynamic> json) {
    subInterestId = json['sub_interest_id'];
    subInterestTitle = json['sub_interest_title'];
    isChecked = json['is_checked'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_interest_id'] = this.subInterestId;
    data['sub_interest_title'] = this.subInterestTitle;
    data['is_checked'] = this.isChecked;
    return data;
  }
}
