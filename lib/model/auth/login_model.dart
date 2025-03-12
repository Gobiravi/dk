class LoginModel {
  LoginModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  final bool? status;
  final LoginModelData? data;
  final String? message;
  final int? statusCode;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json["status"],
      data: json["data"] == null ? null : LoginModelData.fromJson(json["data"]),
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

class LoginModelData {
  LoginModelData({
    required this.token,
    required this.refreshToken,
    required this.userId,
    required this.language,
    required this.currency,
    required this.country,
  });

  final String? token;
  final String? refreshToken;
  final int? userId;
  final String? language;
  final String? currency;
  final String? country;

  factory LoginModelData.fromJson(Map<String, dynamic> json) {
    return LoginModelData(
      token: json["token"],
      refreshToken: json["refresh_token"],
      userId: json["user_id"],
      language: json["language"],
      currency: json["currency"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "refresh_token": refreshToken,
        "user_id": userId,
        "language": language,
        "currency": currency,
        "country": country,
      };

  @override
  String toString() {
    return "$token, $refreshToken, $userId, $language, $currency, $country, ";
  }
}

class LoginParams {
  String email;
  String password;
  LoginParams(this.email, this.password);
}

class SignupParams {
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  String cpassword;
  SignupParams(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.cpassword,
      required this.password});
}
