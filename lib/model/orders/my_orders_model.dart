import 'package:dikla_spirit/model/dashboard_model.dart';

class MyOrdersListModel {
  bool? status;
  MyOrdersListModelData? data;
  MyOrdersListModelPagination? pagination;
  String? message;
  int? statusCode;

  MyOrdersListModel(
      {this.status, this.data, this.pagination, this.message, this.statusCode});

  MyOrdersListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? MyOrdersListModelData.fromJson(json['data'])
        : null;
    pagination = json['pagination'] != null
        ? MyOrdersListModelPagination.fromJson(json['pagination'])
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
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}

class MyOrdersListModelData {
  List<MyOrdersListModelOrders>? orders;
  List<DashboardModelFastResult>? searchProduct;

  MyOrdersListModelData({this.orders, this.searchProduct});

  MyOrdersListModelData.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <MyOrdersListModelOrders>[];
      json['orders'].forEach((v) {
        orders!.add(MyOrdersListModelOrders.fromJson(v));
      });
    }
    searchProduct = json['search_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    data['search_product'] = searchProduct;
    return data;
  }
}

class MyOrdersListModelOrders {
  int? productId;
  String? name;
  String? image;
  String? orderDate;
  String? itemStatus;
  dynamic orderId;
  dynamic itemId;
  String? orderCurrency;
  String? template;
  dynamic price;
  bool? requirementForm;

  MyOrdersListModelOrders(
      {this.productId,
      this.name,
      this.image,
      this.orderDate,
      this.itemStatus,
      this.orderId,
      this.itemId,
      this.orderCurrency,
      this.price,
      this.template,
      this.requirementForm});

  MyOrdersListModelOrders.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    image = json['image'];
    orderDate = json['order_date'];
    itemStatus = json['item_status'];
    orderId = json['order_id'];
    itemId = json['item_id'];
    orderCurrency = json['order_currency'];
    template = json['template'];
    price = json['price'];
    requirementForm = json['requirement_form'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['image'] = image;
    data['order_date'] = orderDate;
    data['item_status'] = itemStatus;
    data['order_id'] = orderId;
    data['item_id'] = itemId;
    data['order_currency'] = orderCurrency;
    data['price'] = price;
    data['template'] = template;
    data['requirement_form'] = requirementForm;
    return data;
  }
}

class MyOrdersListModelPagination {
  dynamic currentPage;
  dynamic perPage;
  dynamic totalPages;
  dynamic totalItems;

  MyOrdersListModelPagination(
      {this.currentPage, this.perPage, this.totalPages, this.totalItems});

  MyOrdersListModelPagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['total_pages'] = totalPages;
    data['total_items'] = totalItems;
    return data;
  }
}

class RequirementFormParam {
  String template;
  String id;
  String name;
  RequirementFormParam(
      {required this.id, required this.template, required this.name});
}
