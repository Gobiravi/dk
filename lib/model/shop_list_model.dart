class ShopListModel {
  ShopListModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  final bool? status;
  final List<ShopListModelDatum> data;
  final String? message;
  final int? statusCode;

  factory ShopListModel.fromJson(Map<String, dynamic> json) {
    return ShopListModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<ShopListModelDatum>.from(
              json["data"]!.map((x) => ShopListModelDatum.fromJson(x))),
      message: json["message"],
      statusCode: json["status_code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
        "message": message,
        "status_code": statusCode,
      };

  @override
  String toString() {
    return "$status, $data, $message, $statusCode, ";
  }
}

class ShopListModelDatum {
  ShopListModelDatum(
      {required this.type,
      required this.title,
      required this.id,
      required this.children,
      required this.image});

  final String? type;
  final String? title;
  final String? id;
  final String? image;
  final List<ShopListModelDatum> children;

  factory ShopListModelDatum.fromJson(Map<String, dynamic> json) {
    return ShopListModelDatum(
      type: json["type"],
      title: json["title"],
      id: json["id"],
      image: json["image"],
      children: json["children"] == null
          ? []
          : List<ShopListModelDatum>.from(
              json["children"]!.map((x) => ShopListModelDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "image": image,
        "id": id,
        "children": children.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$type, $title, $id, $children, $image, ";
  }
}
