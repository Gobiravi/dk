class GetShippingAddressModel {
  bool? status;
  List<GetShippingAddressModelData>? data;
  String? message;
  int? statusCode;

  GetShippingAddressModel(
      {this.status, this.data, this.message, this.statusCode});

  GetShippingAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetShippingAddressModelData>[];
      json['data'].forEach((v) {
        data!.add(GetShippingAddressModelData.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}

class GetShippingAddressModelData {
  int? id;
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? phone;
  dynamic isDefault;

  GetShippingAddressModelData(
      {this.id,
      this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.phone,
      this.isDefault});

  GetShippingAddressModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    phone = json['phone'];
    isDefault = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    data['phone'] = phone;
    data['default'] = isDefault;
    return data;
  }
}

class ShippingAddressParam {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postCode;
  String? country;
  String? phone;
  String? email;
  String? countryCode;
  String? dialCode;
  String? id;
  bool? isDefault;
  ShippingAddressParam(
      {this.firstName,
      this.lastName,
      this.email,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postCode,
      this.country,
      this.phone,
      this.id,
      this.countryCode,
      this.dialCode,
      this.isDefault});
}
