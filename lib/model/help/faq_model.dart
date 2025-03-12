class FAQModel {
  bool? status;
  List<FaqOtherModelData>? moon;
  List<FaqOtherModelData>? spell;
  List<FaqOtherModelData>? channeling;
  List<FaqOtherModelData>? data;
  String? message;
  int? statusCode;

  FAQModel(
      {this.status,
      this.moon,
      this.spell,
      this.channeling,
      this.message,
      this.data,
      this.statusCode});

  FAQModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['moon'] != null) {
      moon = <FaqOtherModelData>[];
      json['moon'].forEach((v) {
        moon!.add(FaqOtherModelData.fromJson(v));
      });
    }
    if (json['data'] != null) {
      data = <FaqOtherModelData>[];
      json['data'].forEach((v) {
        data!.add(FaqOtherModelData.fromJson(v));
      });
    }
    if (json['spell'] != null) {
      spell = <FaqOtherModelData>[];
      json['spell'].forEach((v) {
        spell!.add(FaqOtherModelData.fromJson(v));
      });
    }
    if (json['channeling'] != null) {
      channeling = <FaqOtherModelData>[];
      json['channeling'].forEach((v) {
        channeling!.add(FaqOtherModelData.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (moon != null) {
      data['moon'] = moon!.map((v) => v.toJson()).toList();
    }
    if (spell != null) {
      data['spell'] = spell!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (channeling != null) {
      data['channeling'] = channeling!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}

class FaqOtherModelData {
  int? id;
  String? title;
  String? content;

  FaqOtherModelData({this.id, this.title, this.content});

  FaqOtherModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}

class FaqItemListModel {
  bool? status;
  List<FaqItemListModelData>? data;
  String? message;
  int? statusCode;

  FaqItemListModel({this.status, this.data, this.message, this.statusCode});

  FaqItemListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <FaqItemListModelData>[];
      json['data'].forEach((v) {
        data!.add(FaqItemListModelData.fromJson(v));
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

class FaqItemListModelData {
  String? key;
  String? value;
  String? image;

  FaqItemListModelData({this.key, this.value, this.image});

  FaqItemListModelData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    data['image'] = image;
    return data;
  }
}
