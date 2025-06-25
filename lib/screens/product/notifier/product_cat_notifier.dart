import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/product_cat_model.dart';
import 'package:dikla_spirit/screens/product/repository/product_cat_repo.dart';
import 'package:dikla_spirit/screens/product/state/product_cat_list_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCategoryNotifier extends StateNotifier<ProductCategoryListState> {
  final ProductCategoryRepository repository;

  ProductCategoryNotifier(this.repository)
      : super(const ProductCategoryListState
            .loading()); // Initialize with loading state

  List<DashboardModelFastResult> _allProducts = [];
  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasMore = true;
  Future<void> fetchProductCategory(String categoryId,
      {bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _allProducts.clear();
      _hasMore = true;
      state = const ProductCategoryListState.loading();
    }

    try {
      final result =
          await repository.fetchProductCategory(categoryId, page: _currentPage);
      final products = result.data?.products ?? [];

      if (reset) {
        _allProducts = products;
      } else {
        _allProducts.addAll(products);
      }

      _hasMore = products.isNotEmpty;

      state = ProductCategoryListState.loaded(
        data: result.data!.copyWith(
          products: _allProducts,
        ),
        status: true,
        statusCode: result.statusCode ?? 200,
      );
    } catch (error) {
      state = ProductCategoryListState.error(error.toString());
    }
  }

  Future<void> loadMore(String categoryId) async {
    if (_isFetchingMore || !_hasMore) return;

    _isFetchingMore = true;
    _currentPage++;

    try {
      final data =
          await repository.fetchProductCategory(categoryId, page: _currentPage);
      final newProducts = data.data?.products ?? [];

      if (newProducts.isEmpty) {
        _hasMore = false;
        state = ProductCategoryListState.reachedEnd(_allProducts);
      } else {
        _allProducts.addAll(newProducts);
        state = ProductCategoryListState.loaded(
          data: data.data!.copyWith(products: _allProducts),
          status: true,
          statusCode: 200,
        );
      }
    } catch (error) {
      // Optional: handle or ignore error silently during loadMore
      // You can show a Snackbar or log it
    } finally {
      _isFetchingMore = false;
    }
  }
}

final productCategoryListProvider = Provider<ProductCategoryRepository>((ref) {
  return ProductCategoryRepository();
});

final productCategoryListNotifierProvider = StateNotifierProvider.family<
    ProductCategoryNotifier, ProductCategoryListState, String>((ref, id) {
  final repo = ref.watch(productCategoryListProvider);
  return ProductCategoryNotifier(repo);
});
