import 'package:dikla_spirit/model/dashboard_model.dart';

class SearchBgModel {
  bool? status;
  SearchBgModelData? data;
  String? message;
  int? statusCode;

  SearchBgModel({this.status, this.data, this.message, this.statusCode});

  SearchBgModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? SearchBgModelData.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}

class SearchBgModelData {
  List<DashboardModelFastResult>? products;
  List<SearchBgModelCategories>? categories;
  List<DashboardModelFastResult>? youMayAlsoLike;

  SearchBgModelData({this.products, this.categories, this.youMayAlsoLike});

  SearchBgModelData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <DashboardModelFastResult>[];
      json['products'].forEach((v) {
        products!.add(DashboardModelFastResult.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <SearchBgModelCategories>[];
      json['categories'].forEach((v) {
        categories!.add(SearchBgModelCategories.fromJson(v));
      });
    }
    if (json['you_may_also_like'] != null) {
      youMayAlsoLike = <DashboardModelFastResult>[];
      json['you_may_also_like'].forEach((v) {
        youMayAlsoLike!.add(DashboardModelFastResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (youMayAlsoLike != null) {
      data['you_may_also_like'] =
          youMayAlsoLike!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchBgModelCategories {
  String? title;
  String? id;
  String? slug;

  SearchBgModelCategories({this.title, this.id, this.slug});

  SearchBgModelCategories.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['slug'] = slug;
    return data;
  }
}
