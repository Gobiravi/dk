class UserAppSettingModel {
  UserAppSettingModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  final bool? status;
  final UserAppSettingModelData? data;
  final String? message;
  final int? statusCode;

  factory UserAppSettingModel.fromJson(Map<String, dynamic> json) {
    return UserAppSettingModel(
      status: json["status"],
      data: json["data"] == null
          ? null
          : UserAppSettingModelData.fromJson(json["data"]),
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

class UserAppSettingModelData {
  UserAppSettingModelData({
    required this.language,
    required this.currency,
    required this.country,
  });

  final String? language;
  final String? currency;
  final String? country;

  factory UserAppSettingModelData.fromJson(Map<String, dynamic> json) {
    return UserAppSettingModelData(
      language: json["language"],
      currency: json["currency"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "currency": currency,
        "country": country,
      };

  @override
  String toString() {
    return "$language, $currency, $country, ";
  }
}
