import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/product_cat_model.dart';
import 'package:dikla_spirit/model/product_filter_opt_model.dart';
import 'package:dio/dio.dart';

class ProductCategoryRepository {
  Future<ProductCategoryModel> fetchProductCategory(String id,
      {List<String>? filteredIds,
      String? minPrice,
      String? maxPrice,
      int? page}) async {
    // Initialize query parameters
    final queryParams = <String, String>{};

    // Add filters if provided
    if (filteredIds != null && filteredIds.isNotEmpty) {
      queryParams["category[]"] = filteredIds.join(',');
    }
    if (minPrice != null && minPrice.isNotEmpty) {
      queryParams["min_price"] = minPrice;
    }
    if (maxPrice != null && maxPrice.isNotEmpty) {
      queryParams["max_price"] = maxPrice;
    }
    if (page != null) {
      queryParams["page"] = page.toString();
    }
    try {
      final data = await ApiUtils.makeRequest(
          "${Constants.baseUrl}${Constants.productListUrl}$id",
          useAuth: true,
          params: queryParams.isNotEmpty ? queryParams : {});
      return ProductCategoryModel.fromJson(data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 402) {
        // If status is 402, refresh the token
        await ApiUtils.refreshToken();
        // Retry the request with a refreshed token
        final data = await ApiUtils.makeRequest(
          Constants.baseUrl + Constants.productListUrl + id,
          useAuth: true,
        );
        return ProductCategoryModel.fromJson(data);
      } else {
        // Rethrow other errors
        rethrow;
      }
    } catch (error) {
      // Handle other errors
      throw Exception('Failed to fetch product category: $error');
    }
  }

  Future<ProductFilterOptionsModel> fetchProductFilterOptions(String id) async {
    final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.productFilterOptionsUrl + id,
    );
    return ProductFilterOptionsModel.fromJson(data);
  }
}
