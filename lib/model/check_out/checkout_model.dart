class CheckoutModel {
  bool? status;
  String? message;
  String? paymentUrl;
  int? orderId;
  String? orderStatus;

  CheckoutModel(
      {this.status,
      this.message,
      this.paymentUrl,
      this.orderId,
      this.orderStatus});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    paymentUrl = json['payment_url'];
    orderId = json['order_id'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['payment_url'] = paymentUrl;
    data['order_id'] = orderId;
    data['order_status'] = orderStatus;
    return data;
  }
}
