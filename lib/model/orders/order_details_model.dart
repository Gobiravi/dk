// class OrderDetailsModel {
//   bool? status;
//   OrderDetailsModelData? data;
//   String? message;
//   int? statusCode;

//   OrderDetailsModel({this.status, this.data, this.message, this.statusCode});

//   OrderDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null
//         ? OrderDetailsModelData.fromJson(json['data'])
//         : null;
//     message = json['message'];
//     statusCode = json['status_code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = message;
//     data['status_code'] = statusCode;
//     return data;
//   }
// }

// class OrderDetailsModelData {
//   String? name;
//   String? image;
//   dynamic price;
//   dynamic quantity;
//   String? status;
//   int? orderId;
//   String? orderDate;
//   OrderDetailsModelDataOrderActivity? orderActivity;
//   String? totalPrice;
//   String? paymentDetail;
//   OrderDetailsModelDataFormData? formData;
//   String? currency;
//   List<Null>? otherItem;
//   // Null? items;
//   String? shippingCharge;
//   List<OrderDetailsModelDataBreakup>? breakup;
//   String? email;

//   OrderDetailsModelData(
//       {this.name,
//       this.price,
//       this.quantity,
//       this.status,
//       this.orderId,
//       this.orderDate,
//       this.orderActivity,
//       this.totalPrice,
//       this.paymentDetail,
//       // this.deliveryMessage,
//       this.formData,
//       this.currency,
//       this.otherItem,
//       // this.items,
//       this.shippingCharge,
//       this.breakup,
//       this.image,
//       this.email});

//   OrderDetailsModelData.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     image = json['image'];
//     price = json['price'];
//     quantity = json['quantity'];
//     status = json['status'];
//     orderId = json['order_id'];
//     orderDate = json['order_date'];
//     orderActivity = json['order_activity'] != null
//         ? OrderDetailsModelDataOrderActivity.fromJson(json['order_activity'])
//         : null;
//     totalPrice = json['total_price'];
//     paymentDetail = json['payment_detail'];
//     // deliveryMessage = json['delivery_message'];
//     formData = json['form_data'] != null
//         ? OrderDetailsModelDataFormData.fromJson(json['form_data'])
//         : null;
//     currency = json['currency'];
//     if (json['other_item'] != null) {
//       otherItem = <Null>[];
//       json['other_item'].forEach((v) {
//         // otherItem!.add(Null.fromJson(v));
//       });
//     }
//     // items = json['items'];
//     shippingCharge = json['shipping_charge'];
//     if (json['breakup'] != null) {
//       breakup = <OrderDetailsModelDataBreakup>[];
//       json['breakup'].forEach((v) {
//         breakup!.add(OrderDetailsModelDataBreakup.fromJson(v));
//       });
//     }
//     email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['image'] = image;
//     data['price'] = price;
//     data['quantity'] = quantity;
//     data['status'] = status;
//     data['order_id'] = orderId;
//     data['order_date'] = orderDate;
//     if (orderActivity != null) {
//       data['order_activity'] = orderActivity!.toJson();
//     }
//     data['total_price'] = totalPrice;
//     data['payment_detail'] = paymentDetail;
//     // data['delivery_message'] = deliveryMessage;
//     if (formData != null) {
//       data['form_data'] = formData!.toJson();
//     }
//     data['currency'] = currency;
//     // if (otherItem != null) {
//     //   data['other_item'] = otherItem!.map((v) => v.toJson()).toList();
//     // }
//     // data['items'] = items;
//     data['shipping_charge'] = shippingCharge;
//     if (breakup != null) {
//       data['breakup'] = breakup!.map((v) => v.toJson()).toList();
//     }
//     data['email'] = email;
//     return data;
//   }
// }

// class OrderDetailsModelDataOrderActivity {
//   bool? orderStatus;
//   String? orderDate;
//   bool? requirementStatus;
//   String? requirementDate;
//   bool? processingStatus;
//   String? processedDate;
//   bool? completeStatus;
//   String? completedDate;

//   OrderDetailsModelDataOrderActivity(
//       {this.orderStatus,
//       this.orderDate,
//       this.requirementStatus,
//       this.requirementDate,
//       this.processingStatus,
//       this.processedDate,
//       this.completeStatus,
//       this.completedDate});

//   OrderDetailsModelDataOrderActivity.fromJson(Map<String, dynamic> json) {
//     orderStatus = json['order_status'];
//     orderDate = json['order_date'];
//     requirementStatus = json['requirement_status'];
//     requirementDate = json['requirement_date'];
//     processingStatus = json['processing_status'];
//     processedDate = json['processing_date'];
//     completeStatus = json['complete_status'];
//     completedDate = json['complete_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['order_status'] = orderStatus;
//     data['order_date'] = orderDate;
//     data['requirement_status'] = requirementStatus;
//     data['requirement_date'] = requirementDate;
//     data['processing_status'] = processingStatus;
//     data['processing_date'] = processedDate;
//     data['complete_status'] = processingStatus;
//     data['complete_date'] = processedDate;
//     return data;
//   }
// }

// class OrderDetailsModelDataFormData {
//   String? fullNameCurrentSituation;
//   String? selfPhotoUrl;
//   String? additionalInformation;
//   List<OrderDetailsModelDataIndivisualData>? indivisualData;
//   int? indivisualDataCount;

//   OrderDetailsModelDataFormData(
//       {this.fullNameCurrentSituation,
//       this.selfPhotoUrl,
//       this.additionalInformation,
//       this.indivisualData,
//       this.indivisualDataCount});

//   OrderDetailsModelDataFormData.fromJson(Map<String, dynamic> json) {
//     fullNameCurrentSituation = json['full_name_current_situation'];
//     selfPhotoUrl = json['self_photo_url'];
//     additionalInformation = json['additional_information'];
//     if (json['indivisual_data'] != null) {
//       indivisualData = <OrderDetailsModelDataIndivisualData>[];
//       json['indivisual_data'].forEach((v) {
//         indivisualData!.add(OrderDetailsModelDataIndivisualData.fromJson(v));
//       });
//     }
//     indivisualDataCount = json['indivisual_data_count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['full_name_current_situation'] = fullNameCurrentSituation;
//     data['self_photo_url'] = selfPhotoUrl;
//     data['additional_information'] = additionalInformation;
//     if (indivisualData != null) {
//       data['indivisual_data'] = indivisualData!.map((v) => v.toJson()).toList();
//     }
//     data['indivisual_data_count'] = indivisualDataCount;
//     return data;
//   }
// }

// class OrderDetailsModelDataIndivisualData {
//   String? fullName;
//   String? description;
//   String? imageUrl;

//   OrderDetailsModelDataIndivisualData(
//       {this.fullName, this.description, this.imageUrl});

//   OrderDetailsModelDataIndivisualData.fromJson(Map<String, dynamic> json) {
//     fullName = json['full_name'];
//     description = json['description'];
//     imageUrl = json['image_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['full_name'] = fullName;
//     data['description'] = description;
//     data['image_url'] = imageUrl;
//     return data;
//   }
// }

// class OrderDetailsModelDataBreakup {
//   String? name;
//   dynamic quantity;
//   String? price;

//   OrderDetailsModelDataBreakup({this.name, this.quantity, this.price});

//   OrderDetailsModelDataBreakup.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     quantity = json['quantity'];
//     price = json['price'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['quantity'] = quantity;
//     data['price'] = price;
//     return data;
//   }
// }

class OrderDetailsModel {
  bool? status;
  OrderDetailsModelData? data;
  String? message;
  int? statusCode;

  OrderDetailsModel({this.status, this.data, this.message, this.statusCode});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? OrderDetailsModelData.fromJson(json['data'])
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

class OrderDetailsModelData {
  String? name;
  String? image;
  dynamic price;
  int? quantity;
  dynamic rating;
  dynamic ratingCount;
  int? orderId;
  String? orderDate;
  OrderDetailsModelDataOrderActivity? orderActivity;
  dynamic totalPrice;
  String? paymentDetail;
  DeliveryMessage? deliveryMessage;
  FormData? formData;
  String? currency;
  List<OtherItem>? otherItem;
  String? shippingCharge;
  dynamic template;
  List<Breakup>? breakup;
  String? email;

  OrderDetailsModelData(
      {this.name,
      this.image,
      this.price,
      this.quantity,
      this.rating,
      this.ratingCount,
      this.orderId,
      this.orderDate,
      this.orderActivity,
      this.totalPrice,
      this.paymentDetail,
      this.deliveryMessage,
      this.formData,
      this.currency,
      this.otherItem,
      this.shippingCharge,
      this.template,
      this.breakup,
      this.email});

  OrderDetailsModelData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    orderId = json['order_id'];
    orderDate = json['order_date'];
    orderActivity = json['order_activity'] != null
        ? OrderDetailsModelDataOrderActivity.fromJson(json['order_activity'])
        : null;
    totalPrice = json['total_price'];
    paymentDetail = json['payment_detail'];
    deliveryMessage = json['delivery_message'] != null
        ? DeliveryMessage.fromJson(json['delivery_message'])
        : null;
    formData =
        json['form_data'] != null ? FormData.fromJson(json['form_data']) : null;
    currency = json['currency'];
    if (json['other_item'] != null) {
      otherItem = <OtherItem>[];
      json['other_item'].forEach((v) {
        otherItem!.add(OtherItem.fromJson(v));
      });
    }
    shippingCharge = json['shipping_charge'];
    template = json['template'];
    if (json['breakup'] != null) {
      breakup = <Breakup>[];
      json['breakup'].forEach((v) {
        breakup!.add(Breakup.fromJson(v));
      });
    }
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['quantity'] = quantity;
    data['rating'] = rating;
    data['rating_count'] = ratingCount;
    data['order_id'] = orderId;
    data['order_date'] = orderDate;
    if (orderActivity != null) {
      data['order_activity'] = orderActivity!.toJson();
    }
    data['total_price'] = totalPrice;
    data['payment_detail'] = paymentDetail;
    if (deliveryMessage != null) {
      data['delivery_message'] = deliveryMessage!.toJson();
    }
    if (formData != null) {
      data['form_data'] = formData!.toJson();
    }
    data['currency'] = currency;
    if (otherItem != null) {
      data['other_item'] = otherItem!.map((v) => v.toJson()).toList();
    }
    data['shipping_charge'] = shippingCharge;
    data['template'] = template;
    if (breakup != null) {
      data['breakup'] = breakup!.map((v) => v.toJson()).toList();
    }
    data['email'] = email;
    return data;
  }
}

class OrderDetailsModelDataOrderActivity {
  bool? orderStatus;
  String? orderDate;
  bool? requirementStatus;
  bool? processingStatus;
  bool? completeStatus;
  String? requirementDate;
  String? processingDate;
  String? completeDate;

  OrderDetailsModelDataOrderActivity(
      {this.orderStatus,
      this.orderDate,
      this.requirementStatus,
      this.processingStatus,
      this.completeStatus,
      this.requirementDate,
      this.processingDate,
      this.completeDate});

  OrderDetailsModelDataOrderActivity.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'];
    orderDate = json['order_date'];
    requirementStatus = json['requirement_status'];
    processingStatus = json['processing_status'];
    completeStatus = json['complete_status'];
    requirementDate = json['requirement_date'];
    processingDate = json['processing_date'];
    completeDate = json['complete_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_status'] = orderStatus;
    data['order_date'] = orderDate;
    data['requirement_status'] = requirementStatus;
    data['processing_status'] = processingStatus;
    data['complete_status'] = completeStatus;
    data['requirement_date'] = requirementDate;
    data['processing_date'] = processingDate;
    data['complete_date'] = completeDate;
    return data;
  }
}

class DeliveryMessage {
  String? deliveryMessage;
  String? deliveryImage;

  DeliveryMessage({this.deliveryMessage, this.deliveryImage});

  DeliveryMessage.fromJson(Map<String, dynamic> json) {
    deliveryMessage = json['delivery_message'];
    deliveryImage = json['delivery_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivery_message'] = deliveryMessage;
    data['delivery_image'] = deliveryImage;
    return data;
  }
}

class FormData {
  String? fullNameCurrentSituation;
  String? selfPhotoUrl;
  String? additionalInformation;
  List<IndivisualData>? indivisualData;
  int? indivisualDataCount;

  FormData(
      {this.fullNameCurrentSituation,
      this.selfPhotoUrl,
      this.additionalInformation,
      this.indivisualData,
      this.indivisualDataCount});

  FormData.fromJson(Map<String, dynamic> json) {
    fullNameCurrentSituation = json['full_name_current_situation'];
    selfPhotoUrl = json['self_photo_url'];
    additionalInformation = json['additional_information'];
    if (json['indivisual_data'] != null) {
      indivisualData = <IndivisualData>[];
      json['indivisual_data'].forEach((v) {
        indivisualData!.add(IndivisualData.fromJson(v));
      });
    }
    indivisualDataCount = json['indivisual_data_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name_current_situation'] = fullNameCurrentSituation;
    data['self_photo_url'] = selfPhotoUrl;
    data['additional_information'] = additionalInformation;
    if (indivisualData != null) {
      data['indivisual_data'] = indivisualData!.map((v) => v.toJson()).toList();
    }
    data['indivisual_data_count'] = indivisualDataCount;
    return data;
  }
}

class IndivisualData {
  String? fullName;
  String? description;
  String? imageUrl;

  IndivisualData({this.fullName, this.description, this.imageUrl});

  IndivisualData.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    description = json['description'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['description'] = description;
    data['image_url'] = imageUrl;
    return data;
  }
}

class OtherItem {
  String? name;
  int? quantity;
  dynamic price;
  String? image;

  OtherItem({this.name, this.quantity, this.price});

  OtherItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}

class Breakup {
  String? name;
  int? quantity;
  dynamic price;

  Breakup({this.name, this.quantity, this.price});

  Breakup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
