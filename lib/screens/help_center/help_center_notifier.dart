import 'dart:convert';

import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/help/faq_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/help_center/help_center_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HelpCenterNotifier
    extends StateNotifier<AsyncValue<List<FaqItemListModelData>>> {
  HelpCenterNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  List<FaqItemListModelData>? _cachedCategories;

  Future<void> fetchHelpCenterCategories() async {
    try {
      final hasInternet = await ConstantMethods.checkNetwork();
      if (!hasInternet) throw NetworkException("No Internet Connection");

      final response = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.faqUrl,
        jsonParams: json.encode({}),
        isRaw: true,
        useAuth: true,
      );

      final parsedData = FaqItemListModel.fromJson(response);
      _cachedCategories = parsedData.data; // Cache the data

      state = AsyncValue.data(parsedData.data ?? []);

      // Fetch first category details automatically
      if (parsedData.data!.isNotEmpty) {
        ref
            .read(helpCenterDetailsProvider.notifier)
            .fetchCategoryDetails(parsedData.data?.first.key ?? "");
        ref.read(selectedFaqKey.notifier).state =
            parsedData.data?.first.key ?? "";
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  List<FaqItemListModelData>? getCachedCategories() => _cachedCategories;
}

// Provider for HelpCenter List
final helpCenterProvider = StateNotifierProvider<HelpCenterNotifier,
    AsyncValue<List<FaqItemListModelData>>>(
  (ref) => HelpCenterNotifier(ref),
);

class HelpCenterDetailsNotifier extends StateNotifier<AsyncValue<FAQModel?>> {
  HelpCenterDetailsNotifier() : super(const AsyncValue.loading());

  Future<void> fetchCategoryDetails(String tab) async {
    try {
      final hasInternet = await ConstantMethods.checkNetwork();
      if (!hasInternet) throw NetworkException("No Internet Connection");

      final response = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.faqUrl,
        params: {"tab": tab},
        isRaw: false,
        useAuth: true,
      );

      final faqData = FAQModel.fromJson(response);
      state = AsyncValue.data(faqData);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Provider for HelpCenter Details
final helpCenterDetailsProvider =
    StateNotifierProvider<HelpCenterDetailsNotifier, AsyncValue<FAQModel?>>(
  (ref) => HelpCenterDetailsNotifier(),
);
