class SignUpModel {
  SignUpModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  final bool? status;
  final SignUpModelData? data;
  final String? message;
  final int? statusCode;

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      status: json["status"],
      data:
          json["data"] == null ? null : SignUpModelData.fromJson(json["data"]),
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

class SignUpModelData {
  SignUpModelData({
    required this.userId,
  });

  final int? userId;

  factory SignUpModelData.fromJson(Map<String, dynamic> json) {
    return SignUpModelData(
      userId: json["user_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };

  @override
  String toString() {
    return "$userId, ";
  }
}
