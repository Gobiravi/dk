class RemoveFromCartModel {
  bool? status;
  String? message;
  int? cartCount;
  String? cartTotal;

  RemoveFromCartModel(
      {this.status, this.message, this.cartCount, this.cartTotal});

  RemoveFromCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cartCount = json['cart_count'];
    cartTotal = json['cart_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['cart_count'] = cartCount;
    data['cart_total'] = cartTotal;
    return data;
  }
}
