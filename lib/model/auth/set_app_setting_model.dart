class SetAppSettingModel {
  SetAppSettingModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  final bool? status;
  final dynamic data;
  final String? message;
  final int? statusCode;

  factory SetAppSettingModel.fromJson(Map<String, dynamic> json) {
    return SetAppSettingModel(
      status: json["status"],
      data: json["data"],
      message: json["message"],
      statusCode: json["status_code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
        "status_code": statusCode,
      };

  @override
  String toString() {
    return "$status, $data, $message, $statusCode, ";
  }
}
