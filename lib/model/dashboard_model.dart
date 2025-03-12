import 'package:dikla_spirit/model/product_details_model.dart';

class DashboardModel {
  DashboardModel({
    this.status,
    this.data,
    this.message,
    this.statusCode,
  });

  final bool? status;
  final DashboardModelData? data;
  final String? message;
  final int? statusCode;

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      status: json["status"],
      data: json["data"] == null
          ? null
          : DashboardModelData.fromJson(json["data"]),
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

class DashboardModelData {
  DashboardModelData(
      {required this.menu,
      required this.bestSelling,
      required this.topbanner,
      required this.reviews,
      required this.moreFrom,
      required this.fastResult,
      required this.quickSolution,
      required this.currency});

  final List<DashboardModelMenu> menu;
  final List<DashboardModelBestSelling> bestSelling;
  final List<DashboardModeTopbanner> topbanner;
  final List<DashboardModelReview> reviews;
  final List<DashboardModlMoreFrom> moreFrom;
  final List<DashboardModelFastResult> fastResult;
  final List<DashboardModelFastResult> quickSolution;
  final String currency;

  factory DashboardModelData.fromJson(Map<String, dynamic> json) {
    return DashboardModelData(
      menu: json["menu"] == null
          ? []
          : List<DashboardModelMenu>.from(
              json["menu"]!.map((x) => DashboardModelMenu.fromJson(x))),
      bestSelling: json["best_selling"] == null
          ? []
          : List<DashboardModelBestSelling>.from(json["best_selling"]!
              .map((x) => DashboardModelBestSelling.fromJson(x))),
      topbanner: json["topbanner"] == null
          ? []
          : List<DashboardModeTopbanner>.from(json["topbanner"]!
              .map((x) => DashboardModeTopbanner.fromJson(x))),
      reviews: json["reviews"] == null
          ? []
          : List<DashboardModelReview>.from(
              json["reviews"]!.map((x) => DashboardModelReview.fromJson(x))),
      moreFrom: json["more_from"] == null
          ? []
          : List<DashboardModlMoreFrom>.from(
              json["more_from"]!.map((x) => DashboardModlMoreFrom.fromJson(x))),
      fastResult: json["fast_result"] == null
          ? []
          : List<DashboardModelFastResult>.from(json["fast_result"]!
              .map((x) => DashboardModelFastResult.fromJson(x))),
      quickSolution: json["quick_solution"] == null
          ? []
          : List<DashboardModelFastResult>.from(json["quick_solution"]!
              .map((x) => DashboardModelFastResult.fromJson(x))),
      currency: json["currency"],
    );
  }

  Map<String, dynamic> toJson() => {
        "menu": menu.map((x) => x.toJson()).toList(),
        "best_selling": bestSelling.map((x) => x.toJson()).toList(),
        "topbanner": topbanner.map((x) => x.toJson()).toList(),
        "reviews": reviews.map((x) => x.toJson()).toList(),
        "more_from": moreFrom.map((x) => x.toJson()).toList(),
        "fast_result": fastResult.map((x) => x.toJson()).toList(),
        "quick_solution": quickSolution.map((x) => x.toJson()).toList(),
        "currency": currency,
      };

  @override
  String toString() {
    return "$menu, $bestSelling, $topbanner, $reviews, $moreFrom, $fastResult, $quickSolution, $currency, ";
  }
}

class DashboardModelBestSelling {
  DashboardModelBestSelling({
    required this.id,
    required this.title,
    required this.image,
  });

  final int? id;
  final String? title;
  final String? image;

  factory DashboardModelBestSelling.fromJson(Map<String, dynamic> json) {
    return DashboardModelBestSelling(
      id: json["id"],
      title: json["title"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };

  @override
  String toString() {
    return "$id, $title, $image, ";
  }
}

class DashboardModelFastResult {
  DashboardModelFastResult(
      {this.id,
      this.title,
      this.image,
      this.rating,
      this.ratingCount,
      this.symbol,
      this.price,
      this.isWishlist,
      this.template,
      this.type,
      this.variation});

  final dynamic id;
  final String? title;
  final String? image;
  final String? rating;
  final String? ratingCount;
  final String? symbol;
  final dynamic price;
  final int? template;
  final String? type;
  bool? isWishlist;
  List<Variation>? variation;

  factory DashboardModelFastResult.fromJson(Map<String, dynamic> json) {
    return DashboardModelFastResult(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      rating: json["rating"],
      ratingCount: json["rating_count"],
      symbol: json["symbol"],
      type: json["type"],
      template: json["template"],
      price: json["price"],
      isWishlist: json["is_wishlist"],
      variation: json["variations"] == null
          ? []
          : List<Variation>.from(
              json["variations"]!.map((x) => Variation.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "rating": rating,
        "type": type,
        "rating_count": ratingCount,
        "symbol": symbol,
        "template": template,
        "price": price,
        "is_wishlist": isWishlist,
        "variations": variation?.map((x) => x.toJson()).toList(),
      };

  /// The `copyWith` method for creating a copy of the object with updated fields
  DashboardModelFastResult copyWith({
    int? id,
    String? title,
    String? image,
    String? rating,
    String? ratingCount,
    String? symbol,
    dynamic price,
    int? template,
    String? type,
    bool? isWishlist,
    List<Variation>? variation,
  }) {
    return DashboardModelFastResult(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        ratingCount: ratingCount ?? this.ratingCount,
        symbol: symbol ?? this.symbol,
        template: template ?? this.template,
        type: type ?? this.type,
        price: price ?? this.price,
        isWishlist: isWishlist ?? this.isWishlist,
        variation: variation ?? this.variation);
  }

  @override
  String toString() {
    return "$id, $title, $image, $rating, $ratingCount, $symbol, $price, $isWishlist, $variation, ";
  }
}

class DashboardModelMenu {
  DashboardModelMenu({
    required this.type,
    required this.title,
    required this.id,
  });

  final String? type;
  final String? title;
  final String? id;

  factory DashboardModelMenu.fromJson(Map<String, dynamic> json) {
    return DashboardModelMenu(
      type: json["type"],
      title: json["title"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "id": id,
      };

  @override
  String toString() {
    return "$type, $title, $id, ";
  }
}

class DashboardModlMoreFrom {
  DashboardModlMoreFrom(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.redirect});

  final String? imageUrl;
  final String? title;
  final String? description;
  final dynamic redirect;

  factory DashboardModlMoreFrom.fromJson(Map<String, dynamic> json) {
    return DashboardModlMoreFrom(
      imageUrl: json["image_url"],
      title: json["title"],
      description: json["description"],
      redirect: json["redirect"],
    );
  }

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "title": title,
        "description": description,
        "redirect": redirect,
      };

  @override
  String toString() {
    return "$imageUrl, $title, $description, $redirect, ";
  }
}

class DashboardModelReview {
  DashboardModelReview({
    required this.id,
    required this.review,
    required this.rating,
    required this.image,
  });

  final dynamic id;
  final String? review;
  final dynamic rating;
  final String? image;

  factory DashboardModelReview.fromJson(Map<String, dynamic> json) {
    return DashboardModelReview(
      id: json["id"],
      review: json["review"],
      rating: json["rating"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "rating": rating,
        "image": image,
      };

  @override
  String toString() {
    return "$id, $review, $rating, $image, ";
  }
}

class DashboardModeTopbanner {
  DashboardModeTopbanner(
      {required this.imageUrl,
      required this.heading,
      required this.content,
      required this.redirect});

  final String? imageUrl;
  final String? heading;
  final String? content;
  final String? redirect;

  factory DashboardModeTopbanner.fromJson(Map<String, dynamic> json) {
    return DashboardModeTopbanner(
      imageUrl: json["image_url"],
      heading: json["heading"],
      content: json["content"],
      redirect: json["redirect"],
    );
  }

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "heading": heading,
        "content": content,
        "redirect": redirect,
      };

  @override
  String toString() {
    return "$imageUrl, $heading, $content, $redirect ";
  }
}
