class HelpQuestionsModel {
  bool? status;
  List<HelpQuestionsModelData>? data;
  String? message;
  int? statusCode;

  HelpQuestionsModel({this.status, this.data, this.message, this.statusCode});

  HelpQuestionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <HelpQuestionsModelData>[];
      json['data'].forEach((v) {
        data!.add(HelpQuestionsModelData.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}

class HelpQuestionsModelData {
  String? id;
  String? question;
  List<HelpQuestionsModelChildren>? children;

  HelpQuestionsModelData({this.id, this.question, this.children});

  HelpQuestionsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    if (json['children'] != null) {
      children = <HelpQuestionsModelChildren>[];
      json['children'].forEach((v) {
        children!.add(HelpQuestionsModelChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HelpQuestionsModelChildren {
  String? childId;
  String? childQuestion;

  HelpQuestionsModelChildren({this.childId, this.childQuestion});

  HelpQuestionsModelChildren.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childQuestion = json['child_question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['child_id'] = childId;
    data['child_question'] = childQuestion;
    return data;
  }
}
