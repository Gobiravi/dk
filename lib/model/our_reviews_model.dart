class OurReviewsModel {
  bool? status;
  OurReviewsModelData? data;
  String? message;
  int? statusCode;

  OurReviewsModel({this.status, this.data, this.message, this.statusCode});

  OurReviewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? OurReviewsModelData.fromJson(json['data'])
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

class OurReviewsModelData {
  OurReviewsModelDataRating? rating;
  List<OurReviewsModelDataReviews>? reviews;
  OurReviewsModelDataFilter? filter;
  OurReviewsModelDataPagination? pagination;

  OurReviewsModelData(
      {this.rating, this.reviews, this.filter, this.pagination});

  OurReviewsModelData.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] != null
        ? OurReviewsModelDataRating.fromJson(json['rating'])
        : null;
    if (json['reviews'] != null) {
      reviews = <OurReviewsModelDataReviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(OurReviewsModelDataReviews.fromJson(v));
      });
    }
    filter = json['filter'] != null
        ? OurReviewsModelDataFilter.fromJson(json['filter'])
        : null;
    pagination = json['pagination'] != null
        ? OurReviewsModelDataPagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (filter != null) {
      data['filter'] = filter!.toJson();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class OurReviewsModelDataRating {
  String? totalRating;
  String? s5Star;
  String? s4Star;
  String? s3Star;
  String? s2Star;
  String? s1Star;
  String? avgRating;

  OurReviewsModelDataRating(
      {this.totalRating,
      this.s5Star,
      this.s4Star,
      this.s3Star,
      this.s2Star,
      this.s1Star,
      this.avgRating});

  OurReviewsModelDataRating.fromJson(Map<String, dynamic> json) {
    totalRating = json['total_rating'];
    s5Star = json['5_star'];
    s4Star = json['4_star'];
    s3Star = json['3_star'];
    s2Star = json['2_star'];
    s1Star = json['1_star'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_rating'] = totalRating;
    data['5_star'] = s5Star;
    data['4_star'] = s4Star;
    data['3_star'] = s3Star;
    data['2_star'] = s2Star;
    data['1_star'] = s1Star;
    data['avg_rating'] = avgRating;
    return data;
  }
}

class OurReviewsModelDataReviews {
  String? title;
  String? content;
  int? rating;
  String? productName;
  String? productImage;
  List<String>? reviewImages;

  OurReviewsModelDataReviews(
      {this.title,
      this.content,
      this.rating,
      this.productName,
      this.productImage,
      this.reviewImages});

  OurReviewsModelDataReviews.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    rating = json['rating'];
    productName = json['product_name'];
    productImage = json['product_image'];
    reviewImages = json['review_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['rating'] = rating;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['review_images'] = reviewImages;
    return data;
  }
}

class OurReviewsModelDataFilter {
  List<OurReviewsModelDataCategory>? category;

  OurReviewsModelDataFilter({this.category});

  OurReviewsModelDataFilter.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <OurReviewsModelDataCategory>[];
      json['category'].forEach((v) {
        category!.add(OurReviewsModelDataCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OurReviewsModelDataCategory {
  int? id;
  String? name;

  OurReviewsModelDataCategory({this.id, this.name});

  OurReviewsModelDataCategory.fromJson(Map<String, dynamic> json) {
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

class OurReviewsModelDataPagination {
  int? currentPage;
  int? perPage;
  String? totalReviews;
  int? totalPages;

  OurReviewsModelDataPagination(
      {this.currentPage, this.perPage, this.totalReviews, this.totalPages});

  OurReviewsModelDataPagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalReviews = json['total_reviews'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['total_reviews'] = totalReviews;
    data['total_pages'] = totalPages;
    return data;
  }
}
