class OrderSummaryModel {
  bool? status;
  OrderSummaryModelData? data;
  String? message;
  int? statusCode;

  OrderSummaryModel({this.status, this.data, this.message, this.statusCode});

  OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? OrderSummaryModelData.fromJson(json['data'])
        : null;
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

class OrderSummaryModelData {
  String? currency;
  List<OrderSummaryModelDataProduct>? product;
  dynamic subtotal;
  dynamic shippingCost;
  dynamic total;
  List<PaymentGateways>? paymentGateways;
  OrderSummaryModelDataUser? user;

  OrderSummaryModelData(
      {this.currency,
      this.product,
      this.subtotal,
      this.shippingCost,
      this.total,
      this.paymentGateways});

  OrderSummaryModelData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null
        ? OrderSummaryModelDataUser.fromJson(json['user'])
        : null;
    currency = json['currency'];
    if (json['product'] != null) {
      product = <OrderSummaryModelDataProduct>[];
      json['product'].forEach((v) {
        product!.add(OrderSummaryModelDataProduct.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    shippingCost = json['shipping_cost'];
    total = json['total'];
    if (json['payment_gateways'] != null) {
      paymentGateways = <PaymentGateways>[];
      json['payment_gateways'].forEach((v) {
        paymentGateways!.add(PaymentGateways.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = subtotal;
    data['shipping_cost'] = shippingCost;
    data['total'] = total;
    if (paymentGateways != null) {
      data['payment_gateways'] =
          paymentGateways!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderSummaryModelDataUser {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  OrderSummaryModelDataUser({this.firstName, this.lastName, this.email});

  OrderSummaryModelDataUser.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phone;
    return data;
  }
}

class OrderSummaryModelDataProduct {
  int? productId;
  int? variationId;
  String? name;
  dynamic price;
  dynamic image;

  OrderSummaryModelDataProduct(
      {this.productId, this.variationId, this.name, this.price});

  OrderSummaryModelDataProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variationId = json['variation_id'];
    name = json['name'];
    image = json['product_image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['variation_id'] = variationId;
    data['name'] = name;
    data['price'] = price;
    data['product_image'] = image;
    return data;
  }
}

class PaymentGateways {
  String? id;
  String? name;

  PaymentGateways({this.id, this.name});

  PaymentGateways.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
