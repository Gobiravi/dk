import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/model/search/search_bg_model.dart';
import 'package:dikla_spirit/widgets/search_widget/search_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchProvider =
    StateNotifierProvider<SearchNotifier, List<SearchModelData>>((ref) {
  return SearchNotifier();
});

final searchBgApiProvider = FutureProvider<SearchBgModel>((ref) async {
  final hasInternet = await ConstantMethods.checkNetwork();
  if (!hasInternet) {
    throw NetworkException("No Internet Connection");
  }
  try {
    final data = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.searcBghUrl,
        method: "GET",
        useAuth: true);
    final datum = SearchBgModel.fromJson(data);
    if (datum.statusCode == 402) {
      await ApiUtils.refreshToken();
    }
    return datum;
  } catch (e) {
    throw Exception("Somthing went wrong $e");
  }
});

class SearchNotifier extends StateNotifier<List<SearchModelData>> {
  SearchNotifier() : super([]);

  void search(String query) async {
    if (query.isEmpty) {
      state = [];
    } else {
      state = await makeAsearch(query);
    }
  }

  Future<List<SearchModelData>> makeAsearch(String query) async {
    final hasInternet = await ConstantMethods.checkNetwork();
    if (!hasInternet) {
      throw NetworkException("No Internet Connection");
    }
    try {
      final data = await ApiUtils.makeRequest(
          Constants.baseUrl + Constants.searchUrl + query,
          method: "GET",
          useAuth: true);
      final datum = SearchModel.fromJson(data);
      if (datum.statusCode == 402) {
        await ApiUtils.refreshToken();
        makeAsearch(query);
      }
      return datum.data ?? [];
    } catch (e) {
      throw Exception("Somthing went wrong $e");
    }
  }

  void clearSearch() {
    state = [];
  }
}
