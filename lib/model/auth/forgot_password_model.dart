class ForgotPasswordModel {
  String? status;
  ForgotPasswordModelData? data;
  String? message;
  int? statusCode;

  ForgotPasswordModel({this.status, this.data, this.message, this.statusCode});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? ForgotPasswordModelData.fromJson(json['data'])
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

class ForgotPasswordModelData {
  String? resetKey;
  String? userLogin;
  bool? isForgot;

  ForgotPasswordModelData({this.resetKey, this.userLogin});

  ForgotPasswordModelData.fromJson(Map<String, dynamic> json) {
    resetKey = json['reset_key'];
    userLogin = json['user_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reset_key'] = resetKey;
    data['user_login'] = userLogin;
    return data;
  }
}

class ForgotPasswordParams {
  String email;
  String lang;
  ForgotPasswordParams({required this.email, required this.lang});
}
