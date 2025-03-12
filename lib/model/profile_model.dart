class ProfileModel {
  bool? status;
  ProfileModelData? data;
  String? message;
  int? statusCode;

  ProfileModel({this.status, this.data, this.message, this.statusCode});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? ProfileModelData.fromJson(json['data']) : null;
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

class ProfileModelData {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? zodiacSign;
  String? todayHoroscope;

  ProfileModelData(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.dateOfBirth,
      this.gender,
      this.zodiacSign,
      this.todayHoroscope});

  ProfileModelData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    zodiacSign = json['zodiac_sign'];
    todayHoroscope = json['today_horoscope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['zodiac_sign'] = zodiacSign;
    data['today_horoscope'] = todayHoroscope;
    return data;
  }
}
