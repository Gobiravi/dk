// class OurReviewsModel {
// 	bool? status;
// 	Data? data;
// 	String? message;
// 	int? statusCode;

// 	OurReviewsModel({this.status, this.data, this.message, this.statusCode});

// 	OurReviewsModel.fromJson(Map<String, dynamic> json) {
// 		status = json['status'];
// 		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
// 		message = json['message'];
// 		statusCode = json['status_code'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['status'] = this.status;
// 		if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
// 		data['message'] = this.message;
// 		data['status_code'] = this.statusCode;
// 		return data;
// 	}
// }

// class Data {
// 	Rating? rating;
// 	List<Reviews>? reviews;
// 	Filter? filter;
// 	Pagination? pagination;

// 	Data({this.rating, this.reviews, this.filter, this.pagination});

// 	Data.fromJson(Map<String, dynamic> json) {
// 		rating = json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
// 		if (json['reviews'] != null) {
// 			reviews = <Reviews>[];
// 			json['reviews'].forEach((v) { reviews!.add(new Reviews.fromJson(v)); });
// 		}
// 		filter = json['filter'] != null ? new Filter.fromJson(json['filter']) : null;
// 		pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.rating != null) {
//       data['rating'] = this.rating!.toJson();
//     }
// 		if (this.reviews != null) {
//       data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
//     }
// 		if (this.filter != null) {
//       data['filter'] = this.filter!.toJson();
//     }
// 		if (this.pagination != null) {
//       data['pagination'] = this.pagination!.toJson();
//     }
// 		return data;
// 	}
// }

// class Rating {
// 	String? totalRating;
// 	String? s5Star;
// 	String? s4Star;
// 	String? s3Star;
// 	String? s2Star;
// 	String? s1Star;
// 	String? avgRating;

// 	Rating({this.totalRating, this.s5Star, this.s4Star, this.s3Star, this.s2Star, this.s1Star, this.avgRating});

// 	Rating.fromJson(Map<String, dynamic> json) {
// 		totalRating = json['total_rating'];
// 		s5Star = json['5_star'];
// 		s4Star = json['4_star'];
// 		s3Star = json['3_star'];
// 		s2Star = json['2_star'];
// 		s1Star = json['1_star'];
// 		avgRating = json['avg_rating'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['total_rating'] = this.totalRating;
// 		data['5_star'] = this.s5Star;
// 		data['4_star'] = this.s4Star;
// 		data['3_star'] = this.s3Star;
// 		data['2_star'] = this.s2Star;
// 		data['1_star'] = this.s1Star;
// 		data['avg_rating'] = this.avgRating;
// 		return data;
// 	}
// }

// class Reviews {
// 	String? title;
// 	String? content;
// 	int? rating;
// 	String? productName;
// 	String? productImage;
// 	List<String>? reviewImages;

// 	Reviews({this.title, this.content, this.rating, this.productName, this.productImage, this.reviewImages});

// 	Reviews.fromJson(Map<String, dynamic> json) {
// 		title = json['title'];
// 		content = json['content'];
// 		rating = json['rating'];
// 		productName = json['product_name'];
// 		productImage = json['product_image'];
// 		reviewImages = json['review_images'].cast<String>();
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['title'] = this.title;
// 		data['content'] = this.content;
// 		data['rating'] = this.rating;
// 		data['product_name'] = this.productName;
// 		data['product_image'] = this.productImage;
// 		data['review_images'] = this.reviewImages;
// 		return data;
// 	}
// }

// class Filter {
// 	Category? category;

// 	Filter({this.category});

// 	Filter.fromJson(Map<String, dynamic> json) {
// 		category = json['category'] != null ? new Category.fromJson(json['category']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.category != null) {
//       data['category'] = this.category!.toJson();
//     }
// 		return data;
// 	}
// }

// class Category {
// 	0? 00;
// 	0? 01;
// 	0? 02;
// 	0? 03;
// 	0? 04;
// 	0? 05;
// 	0? 06;
// 	0? 07;
// 	0? 08;
// 	0? 09;
// 	0? 010;
// 	0? 011;
// 	0? 012;
// 	0? 013;
// 	0? 014;
// 	0? 015;
// 	0? 016;
// 	0? 017;
// 	0? 018;
// 	0? 019;
// 	0? 020;
// 	0? 021;
// 	0? 022;
// 	0? 023;
// 	0? 025;

// 	Category({this.00, this.01, this.02, this.03, this.04, this.05, this.06, this.07, this.08, this.09, this.010, this.011, this.012, this.013, this.014, this.015, this.016, this.017, this.018, this.019, this.020, this.021, this.022, this.023, this.025});

// 	Category.fromJson(Map<String, dynamic> json) {
// 		00 = json['0'] != null ? new 0.fromJson(json['0']) : null;
// 		01 = json['1'] != null ? new 0.fromJson(json['1']) : null;
// 		02 = json['2'] != null ? new 0.fromJson(json['2']) : null;
// 		03 = json['3'] != null ? new 0.fromJson(json['3']) : null;
// 		04 = json['4'] != null ? new 0.fromJson(json['4']) : null;
// 		05 = json['5'] != null ? new 0.fromJson(json['5']) : null;
// 		06 = json['6'] != null ? new 0.fromJson(json['6']) : null;
// 		07 = json['7'] != null ? new 0.fromJson(json['7']) : null;
// 		08 = json['8'] != null ? new 0.fromJson(json['8']) : null;
// 		09 = json['9'] != null ? new 0.fromJson(json['9']) : null;
// 		010 = json['10'] != null ? new 0.fromJson(json['10']) : null;
// 		011 = json['11'] != null ? new 0.fromJson(json['11']) : null;
// 		012 = json['12'] != null ? new 0.fromJson(json['12']) : null;
// 		013 = json['13'] != null ? new 0.fromJson(json['13']) : null;
// 		014 = json['14'] != null ? new 0.fromJson(json['14']) : null;
// 		015 = json['15'] != null ? new 0.fromJson(json['15']) : null;
// 		016 = json['16'] != null ? new 0.fromJson(json['16']) : null;
// 		017 = json['17'] != null ? new 0.fromJson(json['17']) : null;
// 		018 = json['18'] != null ? new 0.fromJson(json['18']) : null;
// 		019 = json['19'] != null ? new 0.fromJson(json['19']) : null;
// 		020 = json['20'] != null ? new 0.fromJson(json['20']) : null;
// 		021 = json['21'] != null ? new 0.fromJson(json['21']) : null;
// 		022 = json['22'] != null ? new 0.fromJson(json['22']) : null;
// 		023 = json['23'] != null ? new 0.fromJson(json['23']) : null;
// 		025 = json['25'] != null ? new 0.fromJson(json['25']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.00 != null) {
//       data['0'] = this.00!.toJson();
//     }
// 		if (this.01 != null) {
//       data['1'] = this.01!.toJson();
//     }
// 		if (this.02 != null) {
//       data['2'] = this.02!.toJson();
//     }
// 		if (this.03 != null) {
//       data['3'] = this.03!.toJson();
//     }
// 		if (this.04 != null) {
//       data['4'] = this.04!.toJson();
//     }
// 		if (this.05 != null) {
//       data['5'] = this.05!.toJson();
//     }
// 		if (this.06 != null) {
//       data['6'] = this.06!.toJson();
//     }
// 		if (this.07 != null) {
//       data['7'] = this.07!.toJson();
//     }
// 		if (this.08 != null) {
//       data['8'] = this.08!.toJson();
//     }
// 		if (this.09 != null) {
//       data['9'] = this.09!.toJson();
//     }
// 		if (this.010 != null) {
//       data['10'] = this.010!.toJson();
//     }
// 		if (this.011 != null) {
//       data['11'] = this.011!.toJson();
//     }
// 		if (this.012 != null) {
//       data['12'] = this.012!.toJson();
//     }
// 		if (this.013 != null) {
//       data['13'] = this.013!.toJson();
//     }
// 		if (this.014 != null) {
//       data['14'] = this.014!.toJson();
//     }
// 		if (this.015 != null) {
//       data['15'] = this.015!.toJson();
//     }
// 		if (this.016 != null) {
//       data['16'] = this.016!.toJson();
//     }
// 		if (this.017 != null) {
//       data['17'] = this.017!.toJson();
//     }
// 		if (this.018 != null) {
//       data['18'] = this.018!.toJson();
//     }
// 		if (this.019 != null) {
//       data['19'] = this.019!.toJson();
//     }
// 		if (this.020 != null) {
//       data['20'] = this.020!.toJson();
//     }
// 		if (this.021 != null) {
//       data['21'] = this.021!.toJson();
//     }
// 		if (this.022 != null) {
//       data['22'] = this.022!.toJson();
//     }
// 		if (this.023 != null) {
//       data['23'] = this.023!.toJson();
//     }
// 		if (this.025 != null) {
//       data['25'] = this.025!.toJson();
//     }
// 		return data;
// 	}
// }

// class 0 {
// 	int? id;
// 	String? name;

// 	0({this.id, this.name});

// 	0.fromJson(Map<String, dynamic> json) {
// 		id = json['id'];
// 		name = json['name'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['id'] = this.id;
// 		data['name'] = this.name;
// 		return data;
// 	}
// }

// class Pagination {
// 	int? currentPage;
// 	int? perPage;
// 	String? totalReviews;
// 	int? totalPages;

// 	Pagination({this.currentPage, this.perPage, this.totalReviews, this.totalPages});

// 	Pagination.fromJson(Map<String, dynamic> json) {
// 		currentPage = json['current_page'];
// 		perPage = json['per_page'];
// 		totalReviews = json['total_reviews'];
// 		totalPages = json['total_pages'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['current_page'] = this.currentPage;
// 		data['per_page'] = this.perPage;
// 		data['total_reviews'] = this.totalReviews;
// 		data['total_pages'] = this.totalPages;
// 		return data;
// 	}
// }

// class Category {
// 	0? 00;
// 	0? 01;
// 	0? 02;
// 	0? 03;
// 	0? 04;
// 	0? 05;
// 	0? 06;
// 	0? 07;
// 	0? 08;
// 	0? 09;
// 	0? 010;
// 	0? 011;
// 	0? 012;
// 	0? 013;
// 	0? 014;
// 	0? 015;
// 	0? 016;
// 	0? 017;
// 	0? 018;
// 	0? 019;
// 	0? 020;
// 	0? 021;
// 	0? 022;
// 	0? 023;
// 	0? 025;

// 	Category({this.00, this.01, this.02, this.03, this.04, this.05, this.06, this.07, this.08, this.09, this.010, this.011, this.012, this.013, this.014, this.015, this.016, this.017, this.018, this.019, this.020, this.021, this.022, this.023, this.025});

// 	Category.fromJson(Map<String, dynamic> json) {
// 		00 = json['0'] != null ? new 0.fromJson(json['0']) : null;
// 		01 = json['1'] != null ? new 0.fromJson(json['1']) : null;
// 		02 = json['2'] != null ? new 0.fromJson(json['2']) : null;
// 		03 = json['3'] != null ? new 0.fromJson(json['3']) : null;
// 		04 = json['4'] != null ? new 0.fromJson(json['4']) : null;
// 		05 = json['5'] != null ? new 0.fromJson(json['5']) : null;
// 		06 = json['6'] != null ? new 0.fromJson(json['6']) : null;
// 		07 = json['7'] != null ? new 0.fromJson(json['7']) : null;
// 		08 = json['8'] != null ? new 0.fromJson(json['8']) : null;
// 		09 = json['9'] != null ? new 0.fromJson(json['9']) : null;
// 		010 = json['10'] != null ? new 0.fromJson(json['10']) : null;
// 		011 = json['11'] != null ? new 0.fromJson(json['11']) : null;
// 		012 = json['12'] != null ? new 0.fromJson(json['12']) : null;
// 		013 = json['13'] != null ? new 0.fromJson(json['13']) : null;
// 		014 = json['14'] != null ? new 0.fromJson(json['14']) : null;
// 		015 = json['15'] != null ? new 0.fromJson(json['15']) : null;
// 		016 = json['16'] != null ? new 0.fromJson(json['16']) : null;
// 		017 = json['17'] != null ? new 0.fromJson(json['17']) : null;
// 		018 = json['18'] != null ? new 0.fromJson(json['18']) : null;
// 		019 = json['19'] != null ? new 0.fromJson(json['19']) : null;
// 		020 = json['20'] != null ? new 0.fromJson(json['20']) : null;
// 		021 = json['21'] != null ? new 0.fromJson(json['21']) : null;
// 		022 = json['22'] != null ? new 0.fromJson(json['22']) : null;
// 		023 = json['23'] != null ? new 0.fromJson(json['23']) : null;
// 		025 = json['25'] != null ? new 0.fromJson(json['25']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.00 != null) {
//       data['0'] = this.00!.toJson();
//     }
// 		if (this.01 != null) {
//       data['1'] = this.01!.toJson();
//     }
// 		if (this.02 != null) {
//       data['2'] = this.02!.toJson();
//     }
// 		if (this.03 != null) {
//       data['3'] = this.03!.toJson();
//     }
// 		if (this.04 != null) {
//       data['4'] = this.04!.toJson();
//     }
// 		if (this.05 != null) {
//       data['5'] = this.05!.toJson();
//     }
// 		if (this.06 != null) {
//       data['6'] = this.06!.toJson();
//     }
// 		if (this.07 != null) {
//       data['7'] = this.07!.toJson();
//     }
// 		if (this.08 != null) {
//       data['8'] = this.08!.toJson();
//     }
// 		if (this.09 != null) {
//       data['9'] = this.09!.toJson();
//     }
// 		if (this.010 != null) {
//       data['10'] = this.010!.toJson();
//     }
// 		if (this.011 != null) {
//       data['11'] = this.011!.toJson();
//     }
// 		if (this.012 != null) {
//       data['12'] = this.012!.toJson();
//     }
// 		if (this.013 != null) {
//       data['13'] = this.013!.toJson();
//     }
// 		if (this.014 != null) {
//       data['14'] = this.014!.toJson();
//     }
// 		if (this.015 != null) {
//       data['15'] = this.015!.toJson();
//     }
// 		if (this.016 != null) {
//       data['16'] = this.016!.toJson();
//     }
// 		if (this.017 != null) {
//       data['17'] = this.017!.toJson();
//     }
// 		if (this.018 != null) {
//       data['18'] = this.018!.toJson();
//     }
// 		if (this.019 != null) {
//       data['19'] = this.019!.toJson();
//     }
// 		if (this.020 != null) {
//       data['20'] = this.020!.toJson();
//     }
// 		if (this.021 != null) {
//       data['21'] = this.021!.toJson();
//     }
// 		if (this.022 != null) {
//       data['22'] = this.022!.toJson();
//     }
// 		if (this.023 != null) {
//       data['23'] = this.023!.toJson();
//     }
// 		if (this.025 != null) {
//       data['25'] = this.025!.toJson();
//     }
// 		return data;
// 	}
// }
