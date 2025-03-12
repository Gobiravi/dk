import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/screens/product/repository/product_cat_repo.dart';
import 'package:dikla_spirit/screens/product/state/product_cat_list_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCategoryNotifier extends StateNotifier<ProductCategoryState> {
  final ProductCategoryRepository repository;

  ProductCategoryNotifier(this.repository)
      : super(const ProductCategoryState
            .loading()); // Initialize with loading state
  Future<void> fetchProductCategory(String id) async {
    try {
      state = const ProductCategoryState.loading();
      final hasNetwork = await ConstantMethods.checkNetwork();

      if (!hasNetwork) {
        state = const ProductCategoryState.noInternet();
        return;
      }

      final response = await repository.fetchProductCategory(id);

      // Ensure the response is not null
      if (response == null) {
        state = const ProductCategoryState.error(
            "Failed to fetch product category: Response is null");
        return;
      }

      state = ProductCategoryState.loaded(item: response);
    } catch (e, stackTrace) {
      state = ProductCategoryState.error(e.toString());
      debugPrint('Error fetching product category: $e');
      debugPrint(stackTrace.toString());
    }
  }
}

final productCategoryListProvider = Provider<ProductCategoryRepository>((ref) {
  return ProductCategoryRepository();
});

final productCategoryListNotifierProvider = StateNotifierProvider.family<
    ProductCategoryNotifier, ProductCategoryState, String>((ref, id) {
  final repo = ref.watch(productCategoryListProvider);
  return ProductCategoryNotifier(repo);
});
