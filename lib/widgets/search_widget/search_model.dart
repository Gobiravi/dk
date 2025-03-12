class SearchModel {
  bool? status;
  List<SearchModelData>? data;
  String? message;
  int? statusCode;
  SearchModelPagination? pagination;

  SearchModel(
      {this.status, this.data, this.message, this.statusCode, this.pagination});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SearchModelData>[];
      json['data'].forEach((v) {
        data!.add(SearchModelData.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['status_code'];
    pagination = json['pagination'] != null
        ? SearchModelPagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status_code'] = statusCode;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class SearchModelData {
  int? id;
  String? title;
  String? productImage;

  SearchModelData({this.id, this.title, this.productImage});

  SearchModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['product_image'] = productImage;
    return data;
  }
}

class SearchModelPagination {
  int? currentPage;
  int? perPage;
  int? totalPages;
  int? totalItems;

  SearchModelPagination(
      {this.currentPage, this.perPage, this.totalPages, this.totalItems});

  SearchModelPagination.fromJson(Map<String, dynamic> json) {
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
