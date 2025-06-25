import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/screens/dashboard/repository/dashboard_repo.dart';
import 'package:dikla_spirit/screens/dashboard/state/dashboard_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  final DashboardRepository _repository;

  DashboardNotifier(this._repository) : super(const DashboardState.loading());

  Future<void> fetchDashboardData() async {
    try {
      final checkNetwork = await ConstantMethods.checkNetwork();
      if (!checkNetwork) {
        state = const DashboardState.error("No internet connection");
        return;
      }

      // Load data with token refresh logic
      final data = await _repository.fetchDataWithTokenRefresh();
      state = DashboardState.loaded(data);
    } catch (e) {
      state = DashboardState.error(e.toString());
    }
  }

  uploadFcmToken() {
    _repository.uploadFcmToken();
  }
}
