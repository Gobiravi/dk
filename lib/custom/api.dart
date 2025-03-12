import 'dart:convert';

import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dio/dio.dart';

class ApiUtils {
  static Future<dynamic> makeRequest(
    String url, {
    Map<String, dynamic>? params,
    String? method,
    String? jsonParams,
    bool isRaw = false,
    bool useAuth = false,
  }) async {
    final dio = Dio();
    // dio.options.connectTimeout = Duration(seconds: 20);
    // dio.options.receiveTimeout = Duration(seconds: 10);

    final headers = <String, String>{};

    if (useAuth) {
      String token = await SecureStorage.get("token") ?? "";
      headers['Authorization'] = "Bearer $token";
    }
    // Apply headers to Dio options
    dio.options.headers = headers;
    try {
      Response response;
      if (method == 'POST') {
        response = await dio.post(url, data: isRaw ? jsonParams : params);
      } else {
        response = await dio.get(url, queryParameters: params);
      }
      if (response.statusCode != 402) {
        return response.data;
      } else {
        refreshToken().then((onValue) async {
          if (useAuth) {
            String token = await SecureStorage.get("token") ?? "";
            headers['Authorization'] = "Bearer $token";
          }
          dio.options.headers = headers;
          if (method == 'POST') {
            response = await dio.post(url, data: isRaw ? jsonParams : params);
          } else {
            response = await dio.get(url, queryParameters: params);
          }
        });
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error appropriately, such as displaying an error message to the user
      throw Exception('An error occurred: $e');
    }
  }

  static Future<void> refreshToken() async {
    final dio = Dio();
    final refreshToken = await SecureStorage.get("refresh_token") ?? "";
    if (refreshToken.isEmpty) {
      throw Exception("Refresh token is missing");
    }

    final encodedParam = json.encode({"refresh_token": refreshToken});
    try {
      final response = await dio.post(
        "${Constants.baseUrl}refresh-token",
        data: encodedParam,
      );
      await SecureStorage.save("token", response.data["access_token"]);
    } catch (error) {
      throw Exception('Failed to refresh token: ${error.toString()}');
    }
  }
}
