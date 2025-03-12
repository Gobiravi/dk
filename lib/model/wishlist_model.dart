import 'package:dikla_spirit/model/dashboard_model.dart';

class WishlistModel {
  bool? status;
  WishlistModelData? data;
  String? message;
  int? statusCode;

  WishlistModel({this.status, this.data, this.message, this.statusCode});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? WishlistModelData.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}

class WishlistModelData {
  List<DashboardModelFastResult>? wishlist;
  List<DashboardModelFastResult>? youMayLike;
  String? currency;

  WishlistModelData({this.wishlist, this.youMayLike, this.currency});

  WishlistModelData.fromJson(Map<String, dynamic> json) {
    if (json['wishlist'] != null) {
      wishlist = <DashboardModelFastResult>[];
      json['wishlist'].forEach((v) {
        wishlist?.add(DashboardModelFastResult.fromJson(v));
      });
    }
    if (json['you_may_like'] != null) {
      youMayLike = <DashboardModelFastResult>[];
      json['you_may_like'].forEach((v) {
        youMayLike?.add(DashboardModelFastResult.fromJson(v));
      });
    }
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wishlist != null) {
      data['wishlist'] = wishlist!.map((v) => v.toJson()).toList();
    }
    if (youMayLike != null) {
      data['you_may_like'] = youMayLike!.map((v) => v.toJson()).toList();
    }
    data['currency'] = currency;
    return data;
  }
}
