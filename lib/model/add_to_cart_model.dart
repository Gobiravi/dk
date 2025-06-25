class AddToCartModel {
  bool? status;
  AddToCartModelData? data;
  String? message;
  int? statusCode;

  AddToCartModel({this.status, this.data, this.message, this.statusCode});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? AddToCartModelData.fromJson(json['data']) : null;
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

class AddToCartModelData {
  int? cartCount;
  String? cartTotal;

  AddToCartModelData({this.cartCount, this.cartTotal});

  AddToCartModelData.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    cartTotal = json['cart_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_count'] = cartCount;
    data['cart_total'] = cartTotal;
    return data;
  }
}

class AddtoCartParam {
  String productId;
  String? suggestedPrice;
  String? variationId;
  AddtoCartParam(
      {required this.productId, this.suggestedPrice, this.variationId});
}
