import 'dart:convert';

import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/model/auth/common_model.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardModel> fetchDataWithTokenRefresh() async {
    final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.homeUrl,
      useAuth: true,
    );

    var dashboardModel = DashboardModel.fromJson(data);

    // Token refresh
    if (dashboardModel.statusCode == 402) {
      await ApiUtils.refreshToken();
      final refreshedData = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.homeUrl,
        useAuth: true,
      );
      dashboardModel = DashboardModel.fromJson(refreshedData);
    }

    return dashboardModel;
  }

  uploadFcmToken() async {
    final token = await SecureStorage.get("fcmToken");
    var encodedParam = json.encode({
      "fcm_token": token,
    });
    final data = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.fcmTokenUrl,
        jsonParams: encodedParam,
        method: "POST",
        useAuth: true,
        isRaw: true);
    return CommonModel.fromJson(data);
  }
}
