class CommonModel {
  dynamic status;
  String? message;
  String? data;
  int? statusCode;

  CommonModel({this.status, this.message, this.statusCode});

  CommonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = data;
    data['status_code'] = statusCode;
    return data;
  }
}
