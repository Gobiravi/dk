import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/product_cat_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_cat_list_state.freezed.dart';

@freezed
class ProductCategoryListState with _$ProductCategoryListState {
  const factory ProductCategoryListState.loading() = _Loading;
  const factory ProductCategoryListState.loaded({
    required ProductCategoryModelData data,
    required bool status,
    required int statusCode,
  }) = _Loaded;
  const factory ProductCategoryListState.error(String error) = _Error;
  const factory ProductCategoryListState.noInternet() = _NoInternet;
  const factory ProductCategoryListState.reachedEnd(
      List<DashboardModelFastResult> items) = _ReachedEnd;
}
