class ProductFilterOptionsModel {
  ProductFilterOptionsModel({
    this.status,
    this.data,
    this.message,
    this.statusCode,
  });

  final bool? status;
  final ProductFilterOptionsModelData? data;
  final String? message;
  final int? statusCode;

  factory ProductFilterOptionsModel.fromJson(Map<String, dynamic> json) {
    return ProductFilterOptionsModel(
      status: json["status"],
      data: json["data"] == null
          ? null
          : ProductFilterOptionsModelData.fromJson(json["data"]),
      message: json["message"],
      statusCode: json["status_code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
        "status_code": statusCode,
      };

  @override
  String toString() {
    return "$status, $data, $message, $statusCode, ";
  }
}

class ProductFilterOptionsModelData {
  ProductFilterOptionsModelData({
    required this.categories,
    required this.price,
  });

  final List<ProductFilterOptionsModelDataCategory> categories;
  final int? price;

  factory ProductFilterOptionsModelData.fromJson(Map<String, dynamic> json) {
    return ProductFilterOptionsModelData(
      categories: json["categories"] == null
          ? []
          : List<ProductFilterOptionsModelDataCategory>.from(json["categories"]!
              .map((x) => ProductFilterOptionsModelDataCategory.fromJson(x))),
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "categories": categories.map((x) => x.toJson()).toList(),
        "price": price,
      };

  @override
  String toString() {
    return "$categories, $price, ";
  }
}

class ProductFilterOptionsModelDataCategory {
  ProductFilterOptionsModelDataCategory(
      {required this.id, required this.name, this.isSelected});

  final int? id;
  final String? name;
  bool? isSelected;

  factory ProductFilterOptionsModelDataCategory.fromJson(
      Map<String, dynamic> json) {
    return ProductFilterOptionsModelDataCategory(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return "$id, $name, ";
  }
}
