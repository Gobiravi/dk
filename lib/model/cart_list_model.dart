import 'package:dikla_spirit/model/dashboard_model.dart';

class CartListModel {
  bool? status;
  CartListModelData? data;
  String? message;
  int? statusCode;

  CartListModel({this.status, this.data, this.message, this.statusCode});

  CartListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? CartListModelData.fromJson(json['data']) : null;
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

class CartListModelData {
  List<CartListModelDataCart>? cart;
  List<DashboardModelFastResult>? favourite;
  dynamic subtotal;
  dynamic total;
  dynamic currency;

  CartListModelData(
      {this.cart, this.favourite, this.subtotal, this.total, this.currency});

  CartListModelData.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <CartListModelDataCart>[];
      json['cart'].forEach((v) {
        cart!.add(CartListModelDataCart.fromJson(v));
      });
    }
    if (json['favourite'] != null) {
      favourite = <DashboardModelFastResult>[];
      json['favourite'].forEach((v) {
        favourite!.add(DashboardModelFastResult.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    total = json['total'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cart != null) {
      data['cart'] = cart!.map((v) => v.toJson()).toList();
    }
    if (favourite != null) {
      data['favourite'] = favourite!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = subtotal;
    data['total'] = total;
    data['currency'] = currency;
    return data;
  }
}

class CartListModelDataCart {
  int? productId;
  String? productImage;
  int? variationId;
  String? name;
  int? template;
  dynamic price;
  String? cartItemKey;

  CartListModelDataCart(
      {this.productId,
      this.productImage,
      this.variationId,
      this.name,
      this.price,
      this.template,
      this.cartItemKey});

  CartListModelDataCart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productImage = json['product_image'];
    variationId = json['variation_id'];
    template = json['template'];
    name = json['name'];
    price = json['price'];
    cartItemKey = json['cart_item_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_image'] = productImage;
    data['variation_id'] = variationId;
    data['template'] = template;
    data['name'] = name;
    data['price'] = price;
    data['cart_item_key'] = cartItemKey;
    return data;
  }
}
