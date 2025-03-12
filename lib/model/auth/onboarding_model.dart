class OnboardingModel {
  bool? status;
  OnboardingModelData? data;
  String? message;
  int? statusCode;

  OnboardingModel({this.status, this.data, this.message, this.statusCode});

  OnboardingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? OnboardingModelData.fromJson(json['data'])
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

class OnboardingModelData {
  List<SplashDetails>? splashScreen;

  OnboardingModelData({this.splashScreen});

  OnboardingModelData.fromJson(Map<String, dynamic> json) {
    if (json['splash_screen'] != null) {
      splashScreen = <SplashDetails>[];
      json['splash_screen'].forEach((v) {
        splashScreen!.add(SplashDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (splashScreen != null) {
      data['splash_screen'] = splashScreen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SplashDetails {
  String? logo;
  String? text;

  SplashDetails({this.logo, this.text});

  SplashDetails.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['text'] = text;
    return data;
  }
}
