import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/product_cat_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_cat_list_state.freezed.dart';

@freezed
class ProductCategoryState with _$ProductCategoryState {
  const factory ProductCategoryState.loading() = ProductCategoryStateLoading;
  const factory ProductCategoryState.loaded({
    required ProductCategoryModel item,
  }) = ProductCategoryStateLoaded;
  const factory ProductCategoryState.error(String message) =
      ProductCategoryStateError;
  const factory ProductCategoryState.noInternet() = NoInternetState;
  const factory ProductCategoryState.paginating({
    required List<DashboardModelFastResult> items,
  }) = PaginatingState;
  const factory ProductCategoryState.reachedEnd({
    required List<DashboardModelFastResult> items,
  }) = ReachedEndState;
}
