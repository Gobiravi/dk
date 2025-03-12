import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = DashboardLoading;
  const factory DashboardState.loaded(DashboardModel data) = DashboardLoaded;
  const factory DashboardState.error(String message) = DashboardError;
}
