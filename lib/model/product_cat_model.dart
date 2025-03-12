import 'package:dikla_spirit/model/dashboard_model.dart';

class ProductCategoryModel {
  ProductCategoryModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  final bool? status;
  final ProductCategoryModelData? data;
  final String? message;
  final int? statusCode;

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      status: json["status"],
      data: json["data"] == null
          ? null
          : ProductCategoryModelData.fromJson(json["data"]),
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

class ProductCategoryModelData {
  ProductCategoryModelData({
    required this.products,
    required this.pagination,
    required this.categoryBanner,
  });

  final List<DashboardModelFastResult> products;
  final CategoryProductPagination? pagination;
  final String? categoryBanner;

  factory ProductCategoryModelData.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModelData(
      products: json["products"] == null
          ? []
          : List<DashboardModelFastResult>.from(json["products"]!
              .map((x) => DashboardModelFastResult.fromJson(x))),
      pagination: json["pagination"] == null
          ? null
          : CategoryProductPagination.fromJson(json["pagination"]),
      categoryBanner: json["category_banner"],
    );
  }

  Map<String, dynamic> toJson() => {
        "products": products.map((x) => x.toJson()).toList(),
        "pagination": pagination?.toJson(),
        "category_banner": categoryBanner,
      };

  @override
  String toString() {
    return "$products, $pagination, $categoryBanner, ";
  }
}

class CategoryProductPagination {
  CategoryProductPagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalProducts,
    required this.perPage,
  });

  final int? currentPage;
  final int? totalPages;
  final int? totalProducts;
  final int? perPage;

  factory CategoryProductPagination.fromJson(Map<String, dynamic> json) {
    return CategoryProductPagination(
      currentPage: json["current_page"],
      totalPages: json["total_pages"],
      totalProducts: json["total_products"],
      perPage: json["per_page"],
    );
  }

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_pages": totalPages,
        "total_products": totalProducts,
        "per_page": perPage,
      };

  @override
  String toString() {
    return "$currentPage, $totalPages, $totalProducts, $perPage, ";
  }
}

// class ProductCategoryModelDataProduct {
//   ProductCategoryModelDataProduct(
//       {required this.title,
//       required this.price,
//       required this.image,
//       required this.type,
//       required this.rating,
//       required this.ratingCount,
//       this.id});

//   final String? title;
//   final dynamic price;
//   final String? image;
//   final String? type;
//   final String? rating;
//   final String? ratingCount;
//   final dynamic id;

//   factory ProductCategoryModelDataProduct.fromJson(Map<String, dynamic> json) {
//     return ProductCategoryModelDataProduct(
//       title: json["title"],
//       price: json["price"],
//       image: json["image"],
//       type: json["type"],
//       rating: json["rating"],
//       ratingCount: json["rating_count"],
//       id: json["id"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "price": price,
//         "image": image,
//         "type": type,
//         "rating": rating,
//         "rating_count": ratingCount,
//         "id": id,
//       };

//   @override
//   String toString() {
//     return "$title, $price, $image, $type, $rating, $ratingCount, $id,";
//   }
// }
