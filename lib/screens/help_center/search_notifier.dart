import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchNotifierHelp extends StateNotifier<String> {
  SearchNotifierHelp() : super('');

  void updateSearch(String value) {
    state = value;
  }

  void clearSearch() {
    state = '';
  }
}

final searchProviderHelp =
    StateNotifierProvider<SearchNotifierHelp, String>((ref) {
  return SearchNotifierHelp();
});
