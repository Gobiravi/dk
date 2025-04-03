import 'package:dikla_spirit/model/providers.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepNotifier extends StateNotifier<int> {
  StepNotifier() : super(1); // Start from step 1

  void updateStep(int step) {
    state = step; // Update the current step
  }
}

// provider for StepNotifier
final stepProvider = StateNotifierProvider<StepNotifier, int>((ref) {
  return StepNotifier();
});

class CountryNotifierAddress extends StateNotifier<CountryCode> {
  CountryNotifierAddress()
      : super(CountryCode(name: "Israel", code: "IL", dialCode: "+972"));

  void updateCountry(CountryCode newCountry) {
    state = newCountry;
  }
}

final countryProviderAddress =
    StateNotifierProvider<CountryNotifierAddress, CountryCode>(
  (ref) => CountryNotifierAddress(),
);

// Providers to track validation state for each form
final virtualFormValidProvider = StateProvider<bool>((ref) {
  return ref.watch(firstNameValidProviderAddress) &&
      ref.watch(lastNameValidProviderAddress) &&
      ref.watch(emailValidProviderAddress) &&
      ref.watch(phoneValidProviderAddress);
});
final physicalFormValidProvider = StateProvider<bool>((ref) {
  return ref.watch(countryRegionValidProvider) &&
      ref.watch(streetAddressValidProvider) &&
      ref.watch(appartmentValidProvider) &&
      ref.watch(postalCodeValidProvider) &&
      ref.watch(townCityValidProvider);
  // ref.watch(phoneValidProviderAddress);
});

//combined provider to check if both forms are valid
final combinedFormsValidProvider = Provider<bool>((ref) {
  final isFirstFormValid = ref.watch(virtualFormValidProvider);
  final isSecondFormValid = ref.watch(physicalFormValidProvider);
  return isFirstFormValid && isSecondFormValid;
});

//Provider for total

final checkoutTotal = StateProvider<String>((ref) => "");
