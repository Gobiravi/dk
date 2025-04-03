// class ShopListModel {
//   ShopListModel({
//     required this.status,
//     required this.data,
//     required this.message,
//     required this.statusCode,
//   });

//   final bool? status;
//   final List<ShopListModelDatum> data;
//   final String? message;
//   final int? statusCode;

//   factory ShopListModel.fromJson(Map<String, dynamic> json) {
//     return ShopListModel(
//       status: json["status"],
//       data: json["data"] == null
//           ? []
//           : List<ShopListModelDatum>.from(
//               json["data"]!.map((x) => ShopListModelDatum.fromJson(x))),
//       message: json["message"],
//       statusCode: json["status_code"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data.map((x) => x.toJson()).toList(),
//         "message": message,
//         "status_code": statusCode,
//       };

//   @override
//   String toString() {
//     return "$status, $data, $message, $statusCode, ";
//   }
// }

// class ShopListModelDatum {
//   ShopListModelDatum(
//       {required this.type,
//       required this.title,
//       required this.id,
//       required this.children,
//       required this.image});

//   final String? type;
//   final String? title;
//   final String? id;
//   final String? image;
//   final List<ShopListModelDatum> children;

//   factory ShopListModelDatum.fromJson(Map<String, dynamic> json) {
//     return ShopListModelDatum(
//       type: json["type"],
//       title: json["title"],
//       id: json["id"],
//       image: json["image"],
//       children: json["children"] == null
//           ? []
//           : List<ShopListModelDatum>.from(
//               json["children"]!.map((x) => ShopListModelDatum.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "title": title,
//         "image": image,
//         "id": id,
//         "children": children.map((x) => x.toJson()).toList(),
//       };

//   @override
//   String toString() {
//     return "$type, $title, $id, $children, $image, ";
//   }
// }

import 'package:dikla_spirit/model/dashboard_model.dart';

class ShopListModel {
  bool? status;
  ShopListModelData? data;
  String? message;
  int? statusCode;

  ShopListModel({this.status, this.data, this.message, this.statusCode});

  ShopListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? ShopListModelData.fromJson(json['data']) : null;
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

class ShopListModelData {
  List<ShopListModelMenus>? menus;
  List<DashboardModelFastResult>? bestSelling;

  ShopListModelData({this.menus, this.bestSelling});

  ShopListModelData.fromJson(Map<String, dynamic> json) {
    if (json['menus'] != null) {
      menus = <ShopListModelMenus>[];
      json['menus'].forEach((v) {
        menus!.add(ShopListModelMenus.fromJson(v));
      });
    }
    if (json['best_selling'] != null) {
      bestSelling = <DashboardModelFastResult>[];
      json['best_selling'].forEach((v) {
        bestSelling!.add(DashboardModelFastResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    if (bestSelling != null) {
      data['best_selling'] = bestSelling!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopListModelMenus {
  String? type;
  String? title;
  String? id;
  String? image;
  List<ShopListModelMenusChildren>? children;

  ShopListModelMenus(
      {this.type, this.title, this.id, this.image, this.children});

  ShopListModelMenus.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    id = json['id'];
    image = json['image'];
    if (json['children'] != null) {
      children = <ShopListModelMenusChildren>[];
      json['children'].forEach((v) {
        children!.add(ShopListModelMenusChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['id'] = id;
    data['image'] = image;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopListModelMenusChildren {
  String? type;
  String? title;
  String? id;
  String? image;
  String? icon;

  ShopListModelMenusChildren(
      {this.type, this.title, this.id, this.image, this.icon});

  ShopListModelMenusChildren.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    id = json['id'];
    image = json['image'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['id'] = id;
    data['image'] = image;
    data['icon'] = icon;
    return data;
  }
}
