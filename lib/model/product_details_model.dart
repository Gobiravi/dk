import 'package:dikla_spirit/model/dashboard_model.dart';

class ProductDetailsModel {
  ProductDetailsModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  final bool? status;
  final ProductDetailsModelData? data;
  final String? message;
  final int? statusCode;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      status: json["status"],
      data: json["data"] == null
          ? null
          : ProductDetailsModelData.fromJson(json["data"]),
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

class ProductDetailsModelData {
  ProductDetailsModelData(
      {this.productDetail,
      this.provenResult,
      this.relatedProducts,
      this.questionAnswer,
      this.rating,
      this.reviews,
      this.youMayAlsoLikeThis,
      this.currency});

  final ProductDetail? productDetail;
  final List<ProvenResult>? provenResult;
  final List<DashboardModelFastResult>? relatedProducts;
  final List<DashboardModelFastResult>? youMayAlsoLikeThis;
  final List<QuestionAnswer>? questionAnswer;
  final ProductDetailsModelDataRating? rating;
  final List<Review>? reviews;
  final String? currency;

  factory ProductDetailsModelData.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModelData(
      productDetail: json["product_detail"] == null
          ? null
          : ProductDetail.fromJson(json["product_detail"]),
      provenResult: json["proven_result"] == null
          ? []
          : List<ProvenResult>.from(
              json["proven_result"]!.map((x) => ProvenResult.fromJson(x))),
      relatedProducts: json["related_products"] == null
          ? []
          : List<DashboardModelFastResult>.from(json["related_products"]!
              .map((x) => DashboardModelFastResult.fromJson(x))),
      youMayAlsoLikeThis: json["you_may_also_like"] == null
          ? []
          : List<DashboardModelFastResult>.from(json["you_may_also_like"]!
              .map((x) => DashboardModelFastResult.fromJson(x))),
      questionAnswer: json["question_answer"] == null
          ? []
          : List<QuestionAnswer>.from(
              json["question_answer"]!.map((x) => QuestionAnswer.fromJson(x))),
      rating: json["rating"] == null
          ? null
          : ProductDetailsModelDataRating.fromJson(json["rating"]),
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      currency: json["currency"],
    );
  }

  Map<String, dynamic> toJson() => {
        "product_detail": productDetail?.toJson(),
        "proven_result": provenResult?.map((x) => x.toJson()).toList(),
        "related_products": relatedProducts?.map((x) => x.toJson()).toList(),
        "you_may_also_like":
            youMayAlsoLikeThis?.map((x) => x.toJson()).toList(),
        "question_answer": questionAnswer?.map((x) => x.toJson()).toList(),
        "rating": rating?.toJson(),
        "reviews": reviews?.map((x) => x.toJson()).toList(),
        "currency": currency
      };

  @override
  String toString() {
    return "$productDetail, $provenResult, $relatedProducts, $questionAnswer, $rating, $reviews, $currency, $youMayAlsoLikeThis, ";
  }
}

class ProductDetail {
  ProductDetail(
      {this.title,
      this.id,
      this.shortDescription,
      this.rating,
      this.ratingCount,
      this.type,
      this.descriptionQa,
      this.price,
      this.productImage,
      this.productLink,
      this.variations,
      this.stockQuantity,
      this.stockStatus,
      this.isWishlist,
      this.sizeToFit,
      this.suggestedPrice,
      this.template});

  final String? title;
  dynamic id;
  final String? shortDescription;
  final dynamic rating;
  final String? ratingCount;
  final String? type;
  final dynamic template;
  final List<DescriptionQa>? descriptionQa;
  final dynamic price;
  final String? stockStatus;
  final int? stockQuantity;
  final String? productImage;
  final String? productLink;
  final String? sizeToFit;
  final dynamic suggestedPrice;
  final bool? isWishlist;
  final List<Variation>? variations;

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      title: json["title"],
      id: json["id"],
      template: json["template"],
      sizeToFit: json["size_fit"],
      shortDescription: json["short_description"],
      rating: json["rating"],
      ratingCount: json["rating_count"],
      type: json["type"],
      isWishlist: json["is_wishlist"],
      suggestedPrice: json["suggested_price"],
      descriptionQa: json["description_qa"] == null
          ? []
          : List<DescriptionQa>.from(
              json["description_qa"]!.map((x) => DescriptionQa.fromJson(x))),
      price: json["price"],
      stockQuantity: json["stock_quantity"],
      stockStatus: json["stock_status"],
      productImage: json["product_image"],
      productLink: json["product-link"],
      variations: json["variations"] == null
          ? []
          : List<Variation>.from(
              json["variations"]!.map((x) => Variation.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "size_fit": sizeToFit,
        "id": id,
        "template": template,
        "short_description": shortDescription,
        "rating": rating,
        "rating_count": ratingCount,
        "type": type,
        "description_qa": descriptionQa?.map((x) => x.toJson()).toList(),
        "price": price,
        "product_image": productImage,
        "suggested_price": suggestedPrice,
        "producis_wishlist_image": isWishlist,
        "variations": variations?.map((x) => x.toJson()).toList(),
      };

  ProductDetail copyWith(
      {String? title,
      String? id,
      String? shortDescription,
      dynamic rating,
      String? ratingCount,
      String? type,
      dynamic template,
      List<DescriptionQa>? descriptionQa,
      dynamic price,
      String? stockStatus,
      int? stockQuantity,
      String? productImage,
      String? sizeToFit,
      dynamic suggestedPrice,
      bool? isWishlist,
      List<Variation>? variations}) {
    return ProductDetail(
        title: title ?? this.title,
        id: id ?? this.id,
        shortDescription: shortDescription ?? this.shortDescription,
        rating: rating ?? this.rating,
        ratingCount: ratingCount ?? this.ratingCount,
        type: type ?? this.type,
        descriptionQa: descriptionQa ?? this.descriptionQa,
        price: price ?? this.price,
        productImage: productImage ?? this.productImage,
        variations: variations ?? this.variations,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        stockStatus: stockStatus ?? this.stockStatus,
        isWishlist: isWishlist ?? this.isWishlist,
        sizeToFit: sizeToFit ?? this.sizeToFit,
        suggestedPrice: suggestedPrice ?? this.suggestedPrice,
        template: template ?? this.template);
  }

  @override
  String toString() {
    return "$title, $shortDescription, $rating, $ratingCount, $type, $descriptionQa, $price, $variations, $sizeToFit, $template, $isWishlist $id, $suggestedPrice, ";
  }
}

class Variation {
  Variation(
      {this.id,
      this.price,
      this.attributes,
      this.termName,
      this.termDescription,
      this.stockQuantity,
      this.stockStatus,
      this.termImage,
      this.variationImage});

  final int? id;
  final dynamic price;
  final List<dynamic>? attributes;
  final String? termName;
  final String? termDescription;
  final List<String>? variationImage;
  final String? stockStatus;
  final dynamic stockQuantity;
  final String? termImage;

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json["id"],
      price: json["price"],
      attributes: json["attributes"] == null
          ? []
          : List<dynamic>.from(json["attributes"]!.map((x) => x)),
      termName: json["term_name"],
      termDescription: json["term_description"],
      variationImage: json["variation_image"] == null
          ? []
          : List<String>.from(json["variation_image"]!.map((x) => x)),
      stockStatus: json["stock_status"],
      stockQuantity: json["stock_quantity"],
      termImage: json["term_image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "attributes": attributes?.map((x) => x).toList(),
        "term_name": termName,
        "term_description": termDescription,
        "variation_image": variationImage?.map((x) => x).toList(),
        "stock_status": stockStatus,
        "stock_quantity": stockQuantity,
        "term_image": termImage,
      };

  @override
  String toString() {
    return "$id, $price, $attributes, $termName, $termDescription, $termImage, $stockQuantity, $stockStatus, $variationImage,";
  }
}

class QuestionAnswer {
  QuestionAnswer({
    required this.question,
    required this.answer,
  });

  final String? question;
  final String? answer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
      question: json["question"],
      answer: json["answer"],
    );
  }

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };

  @override
  String toString() {
    return "$question, $answer, ";
  }
}

class DescriptionQa {
  DescriptionQa({
    required this.question,
    required this.value,
  });

  final String? question;
  final String? value;

  factory DescriptionQa.fromJson(Map<String, dynamic> json) {
    return DescriptionQa(
      question: json["question"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "question": question,
        "value": value,
      };

  @override
  String toString() {
    return "$question, $value, ";
  }
}

class ProvenResult {
  ProvenResult({
    required this.percentage,
    required this.result,
  });

  final dynamic percentage;
  final String? result;

  factory ProvenResult.fromJson(Map<String, dynamic> json) {
    return ProvenResult(
      percentage: json["percentage"],
      result: json["result"],
    );
  }

  Map<String, dynamic> toJson() => {
        "percentage": percentage,
        "result": result,
      };

  @override
  String toString() {
    return "$percentage, $result, ";
  }
}

class ProductDetailsModelDataRating {
  ProductDetailsModelDataRating({
    required this.totalRating,
    required this.the5Star,
    required this.the4Star,
    required this.the3Star,
    required this.the2Star,
    required this.the1Star,
    required this.avgRating,
  });

  final String? totalRating;
  final String? the5Star;
  final String? the4Star;
  final String? the3Star;
  final String? the2Star;
  final String? the1Star;
  final String? avgRating;

  factory ProductDetailsModelDataRating.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModelDataRating(
      totalRating: json["total_rating"],
      the5Star: json["5_star"],
      the4Star: json["4_star"],
      the3Star: json["3_star"],
      the2Star: json["2_star"],
      the1Star: json["1_star"],
      avgRating: json["avg_rating"],
    );
  }

  Map<String, dynamic> toJson() => {
        "total_rating": totalRating,
        "5_star": the5Star,
        "4_star": the4Star,
        "3_star": the3Star,
        "2_star": the2Star,
        "1_star": the1Star,
        "avg_rating": avgRating,
      };

  @override
  String toString() {
    return "$totalRating, $the5Star, $the4Star, $the3Star, $the2Star, $the1Star, $avgRating, ";
  }
}

class Review {
  Review({
    required this.title,
    required this.content,
    required this.rating,
  });

  final String? title;
  final String? content;
  final dynamic rating;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      title: json["title"],
      content: json["content"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "rating": rating,
      };

  @override
  String toString() {
    return "$title, $content, $rating, ";
  }
}
