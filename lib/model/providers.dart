import 'dart:convert';

import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/model/add_to_cart_model.dart';
import 'package:dikla_spirit/model/auth/common_model.dart';
import 'package:dikla_spirit/model/auth/forgot_password_model.dart';
import 'package:dikla_spirit/model/auth/login_model.dart';
import 'package:dikla_spirit/model/auth/onboarding_model.dart';
import 'package:dikla_spirit/model/auth/set_app_setting_model.dart';
import 'package:dikla_spirit/model/auth/signup_model.dart';
import 'package:dikla_spirit/model/auth/user_app_setting_model.dart';
import 'package:dikla_spirit/model/cart_list_model.dart';
import 'package:dikla_spirit/model/check_out/add_ship_addr_model.dart';
import 'package:dikla_spirit/model/check_out/order_summary_model.dart';
import 'package:dikla_spirit/model/check_out/shipping_address_list_model.dart';
import 'package:dikla_spirit/model/help/faq_model.dart';
import 'package:dikla_spirit/model/locale_model.dart';
import 'package:dikla_spirit/model/orders/my_orders_model.dart';
import 'package:dikla_spirit/model/orders/order_details_model.dart';
import 'package:dikla_spirit/model/our_reviews_model.dart';
import 'package:dikla_spirit/model/product_details_model.dart';
import 'package:dikla_spirit/model/profile_model.dart';
import 'package:dikla_spirit/model/shop_list_model.dart';
import 'package:dikla_spirit/model/wishlist_model.dart';
import 'package:dikla_spirit/screens/auth/reset_pass_screen.dart';
import 'package:dikla_spirit/screens/dashboard/notifier/dashboard_notifier.dart';
import 'package:dikla_spirit/screens/dashboard/repository/dashboard_repo.dart';
import 'package:dikla_spirit/screens/auth/app_settings.dart';
import 'package:dikla_spirit/screens/dashboard/state/dashboard_state.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeProvider = Provider((ref) => AppTheme.lightTheme.textTheme);

final changeLocaleProvider = StateNotifierProvider<LocaleModel, Locale>(
  (ref) {
    return LocaleModel(const Locale("en"));
  },
);

final indexOfBottomNavbarProvider = StateProvider<int>((ref) {
  return 0;
});

/// Current Currency Symbol
final currentCurrencySymbolProvider = StateProvider<String>((ref) {
  return "\$";
});

// ================= Login Api Provider ======================
final loginApiProvider =
    FutureProvider.family<LoginModel, LoginParams>((ref, params) async {
  var encodedParam =
      json.encode({"email": params.email, "password": params.password});
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.loginUrl,
      jsonParams: encodedParam,
      method: "POST",
      isRaw: true);
  return LoginModel.fromJson(data);
});
// ==============================================================

// ================= Forgot Password Api Provider ======================
final forgotApiProvider =
    FutureProvider.family<ForgotPasswordModel, ForgotPasswordParams>(
        (ref, params) async {
  var encodedParam = json.encode({"email": params.email, "lang": params.lang});
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.forgotPasswordUrl,
      jsonParams: encodedParam,
      method: "POST",
      isRaw: true);
  return ForgotPasswordModel.fromJson(data);
});
// ==============================================================

// ================= Reset Password Api Provider ======================
final resetPassApiProvider =
    FutureProvider.family<CommonModel, ResetPasswordParams>(
        (ref, params) async {
  var encodedParam = json.encode({
    "new_password": params.newPass,
    "confirm_password": params.confirmPass,
    "reset_key": params.resetKey,
    "user_login": params.userLogin
  });
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.resetPasswordUrl,
      jsonParams: encodedParam,
      method: "POST",
      isRaw: true);
  return CommonModel.fromJson(data);
});
// ==============================================================

// ================= Signup Api Provider ======================
final signupApiProvider =
    FutureProvider.family<SignUpModel, SignupParams>((ref, params) async {
  var encodedParam = json.encode({
    "first_name": params.firstName,
    "last_name": params.lastName,
    "email": params.email,
    "phone_number": params.phone,
    "password": params.password,
    "confirm_password": params.cpassword
  });
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.signUpUrl,
      jsonParams: encodedParam,
      method: "POST",
      isRaw: true);
  return SignUpModel.fromJson(data);
});
// ==============================================================

// ================= Refresh Token Api Provider ======================
final refreshTokenApiProvider =
    FutureProvider.family<dynamic, String>((ref, token) async {
  var encodedParam = json.encode({"refresh_token": token});
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.refreshTokenUrl,
      jsonParams: encodedParam,
      method: "POST",
      isRaw: true);
  await SecureStorage.save("refresh_token", data["access_token"]);
  return data;
});
// ==============================================================

// ================= Dashboard Api Provider ======================

// final dashboardApiProvider = FutureProvider<DashboardModel>((ref) async {
//   final repository = ref.watch(dashboardRepositoryProvider);
//   final checkNetwork = await ConstantMethods.checkNetwork();
//   if (!checkNetwork) {
//     return DashboardModel(status: false, message: "No Internet Access");
//   }
//   return await repository.fetchDataWithTokenRefresh();
// });

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository);
});

// ==============================================================

// ================= Shop List Api Provider ======================
final shopListApiProvider = FutureProvider<ShopListModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.shopListUrl,
      useAuth: true);
  return ShopListModel.fromJson(data);
});

// ==============================================================

// ================= Wish List Api Provider ======================
FutureProvider<WishlistModel> wishListApiProvider =
    FutureProvider<WishlistModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.wishListUrl,
      useAuth: true);
  return WishlistModel.fromJson(data);
});
// ==============================================================

// ================= Wish List Api Provider ======================
FutureProvider<CartListModel> myCartApiProvider =
    FutureProvider<CartListModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.myCartListUrl,
      useAuth: true);
  return CartListModel.fromJson(data);
});
// ==============================================================

// // ================= Product Category List Api Provider ======================
// final productListApiProvider =
//     FutureProvider.family<ProductCategoryModel, String>((ref, productId) async {
//   final data = await ApiUtils.makeRequest(
//       Constants.baseUrl + Constants.productListUrl + productId,
//       useAuth: true);
//   return ProductCategoryModel.fromJson(data);
// });
// // ==============================================================

// // ================= Product Category List Api Provider ======================
// final productFilterOptionsApiProvider =
//     FutureProvider.family<ProductFilterOptionsModel, String>(
//         (ref, productId) async {
//   final data = await ApiUtils.makeRequest(
//     Constants.baseUrl + Constants.productFilterOptionsUrl + productId,
//   );
//   return ProductFilterOptionsModel.fromJson(data);
// });

// // ==============================================================

// ================= Product Category List Api Provider ======================
final productDetailsApiProvider =
    FutureProvider.family<ProductDetailsModel, String>((ref, productId) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.productDetailsUrl + productId,
      useAuth: true);
  final productDetail = ProductDetailsModel.fromJson(data);
  if (productDetail.statusCode == 402) {
    await ApiUtils.refreshToken();
    final data = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.productDetailsUrl + productId,
        useAuth: true);
    return ProductDetailsModel.fromJson(data);
  }
  return ProductDetailsModel.fromJson(data);
});

// ==============================================================

// ================= Get User App Setting Details Api Provider ======================
final getAppSettingsApiProvider =
    FutureProvider<UserAppSettingModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.userAppSettingUrl,
      useAuth: true);
  return UserAppSettingModel.fromJson(data);
});

// ==============================================================

// ================= Onboarding Api Provider ======================
final getOnboardingApiProvider = FutureProvider<OnboardingModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.onboardingUrl,
      useAuth: false);
  return OnboardingModel.fromJson(data);
});

// ==============================================================

// ================= Get Expected Date For Channeling Api Provider ======================
final getExpectedDateForChannelingApiProvider =
    FutureProvider.family<CommonModel?, String>((ref, productId) async {
  // Access the product details to check the condition
  final productDetails =
      await ref.watch(productDetailsApiProvider(productId).future);

  final datum = productDetails.data ?? ProductDetailsModelData();

  if (datum.productDetail?.template == 2) {
    final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.expectedDateUrl,
      useAuth: true,
    );
    return CommonModel.fromJson(data);
  }
  return null; // Return null if the condition is not met
});
// ==============================================================

// ================= Set User App Setting Details Api Provider ======================
final setAppSettingsApiProvider =
    FutureProvider.family<SetAppSettingModel, SetAppSettingParams>(
        (ref, params) async {
  var encodedParam = json.encode({
    "lang": params.lang,
    "country": params.country,
    "user_id": params.userId,
    "currency": params.currency,
  });
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.setUserAppSettingUrl,
      method: "POST",
      jsonParams: encodedParam,
      isRaw: true,
      useAuth: true);
  return SetAppSettingModel.fromJson(data);
});

// ==============================================================

// ================= Add To Cart Api Provider ======================
final addToCartApiProvider =
    FutureProvider.family<AddToCartModel, String>((ref, id) async {
  var encodedParam = json.encode({
    "product_id": id,
  });
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.addToCart,
      method: "POST",
      jsonParams: encodedParam,
      isRaw: true,
      useAuth: true);
  return AddToCartModel.fromJson(data);
});

// ==============================================================

// ================= Get Help Center List Api Provider ======================
final getHelpCenterListApiProvider =
    FutureProvider.family<FAQModel, String>((ref, tab) async {
  final hasInternet = await ConstantMethods.checkNetwork();
  if (!hasInternet) {
    throw NetworkException("No Internet Connection");
  }
  try {
    var encodedParam = json.encode({
      "tab": tab,
    });
    final data = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.faqUrl,
        jsonParams: encodedParam,
        isRaw: true,
        useAuth: true);
    return FAQModel.fromJson(data);
  } catch (e) {
    throw Exception("Somthing went wrong $e");
  }
});

// ==============================================================

// ================= Remove From Cart Api Provider ======================
final removeFromCartApiProvider =
    FutureProvider.family<AddToCartModel, String>((ref, id) async {
  var encodedParam = json.encode({
    "cart_item_key": id,
  });
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.removeFromCart,
      method: "POST",
      jsonParams: encodedParam,
      isRaw: true,
      useAuth: true);
  return AddToCartModel.fromJson(data);
});

// ==============================================================

// ================= Shipping Address Api Provider ======================
final getShippingAddressApiProvider =
    FutureProvider.autoDispose<GetShippingAddressModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.shippingAddress,
      method: "GET",
      useAuth: true);
  return GetShippingAddressModel.fromJson(data);
});

// ================= Order Summary Api Provider ======================
final getOrderSummaryApiProvider =
    FutureProvider.autoDispose<OrderSummaryModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.orderSummay,
      method: "GET",
      useAuth: true);
  return OrderSummaryModel.fromJson(data);
});

// ==============================================================

// ================= Get User Profile Api Provider ======================
final getUserProfileApiProvider =
    FutureProvider.autoDispose<ProfileModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.profileUrl,
      method: "GET",
      useAuth: true);
  return ProfileModel.fromJson(data);
});

// ==============================================================

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

// ================= My Order Api Provider ======================
final getMyOrdersApiProvider =
    FutureProvider.autoDispose<MyOrdersListModel>((ref) async {
  final hasInternet = await ConstantMethods.checkNetwork();
  if (!hasInternet) {
    throw NetworkException("No Internet Connection");
  }
  try {
    final data = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.myOrdersUrl,
        method: "GET",
        useAuth: true);
    return MyOrdersListModel.fromJson(data);
  } catch (e) {
    throw Exception("Somthing went wrong $e");
  }
});

// ==============================================================

// ================= Order Detail Api Provider ======================
final orderDetailsApiProvider = FutureProvider.autoDispose
    .family<OrderDetailsModel, String>((ref, itemId) async {
  final hasInternet = await ConstantMethods.checkNetwork();
  if (!hasInternet) {
    throw NetworkException("No Internet Connection");
  }
  try {
    final data = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.ordersDetailsUrl + itemId,
        method: "GET",
        useAuth: true);
    return OrderDetailsModel.fromJson(data);
  } catch (e) {
    throw Exception("Somthing went wrong $e");
  }
});

// ==============================================================

// ================= Order Detail Api Provider ==================
final ourReviewsApiProvider =
    FutureProvider.autoDispose<OurReviewsModel>((ref) async {
  final hasInternet = await ConstantMethods.checkNetwork();
  if (!hasInternet) {
    throw NetworkException("No Internet Connection");
  }
  try {
    final data = await ApiUtils.makeRequest(
        Constants.baseUrl + Constants.ourReviewsUrl,
        method: "GET",
        useAuth: true);
    return OurReviewsModel.fromJson(data);
  } catch (e) {
    throw Exception("Somthing went wrong $e");
  }
});

// ==============================================================

// ================= Shipping Cart Api Provider ======================
final addShippingAddressApiProvider =
    FutureProvider.family<AddShippingAddressModel, ShippingAddressParam>(
        (ref, param) async {
  var encodedParam = json.encode({
    "first_name": param.firstName,
    "last_name": param.lastName,
    "company": param.address1,
    "address_1": param.address1,
    "address_2": param.address2,
    "city": param.city,
    "state": param.state,
    "postcode": param.postCode,
    "country": param.country,
    "phone": param.phone,
    "default": param.isDefault ?? true
  });

  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.shippingAddress,
      method: "POST",
      jsonParams: encodedParam,
      isRaw: true,
      useAuth: true);
  return AddShippingAddressModel.fromJson(data);
});

// ================= Shipping Cart Api Provider ======================
final putShippingAddressApiProvider =
    FutureProvider.family<AddShippingAddressModel, ShippingAddressParam>(
        (ref, param) async {
  var encodedParam = json.encode({
    "first_name": param.firstName,
    "last_name": param.lastName,
    "company": param.address1,
    "address_1": param.address1,
    "address_2": param.address2,
    "city": param.city,
    "state": param.state,
    "postcode": param.postCode,
    "country": param.country,
    "phone": param.phone,
    "default": param.isDefault ?? true
  });

  final data = await ApiUtils.makeRequest(
      "${Constants.baseUrl}${Constants.shippingAddress}/${param.id}",
      method: "PUT",
      jsonParams: encodedParam,
      isRaw: true,
      useAuth: true);
  return AddShippingAddressModel.fromJson(data);
});

// ==============================================================

// ================= Best Selling PageView Index Provider ======================

final indexOfPageViewInHomeBestSelling = StateProvider<int>((ref) {
  return 0;
});

// ==============================================================

// ================= Country Code Provider ======================

final selectedCountryProvider = StateProvider<CountryCode>((ref) {
  return CountryCode(name: "Israel", code: "IL", dialCode: "972");
});
// ==============================================================

// ================= Country Code Profile Provider ======================

final selectedCountryProviderProfile = StateProvider<CountryCode>((ref) {
  return CountryCode(name: "Israel", code: "IL", dialCode: "972");
});
// ==============================================================

// ================= Best Selling PageView Index Provider ======================

final indexOfOnboarding = StateProvider<int>((ref) {
  return 0;
});

// ==============================================================

// ================= More From Dikla PageView Index Provider ======================

final indexOfPageViewInHomeMoreFrom = StateProvider<int>((ref) {
  return 0;
});

// ==============================================================

// ================= Product Detail Proven Results PageView Index Provider ======================
final indexOfProvenResultInProductDetail = StateProvider<int>((ref) {
  return 0;
});
// ==============================================================

// ================= Product Detail Moon Jewellery PageView Index Provider ======================

final indexOfJewelleryInProductDetail = StateProvider<int>((ref) {
  return 0;
});
// ==============================================================

// ================= Product Detail Moon Jewellery Selected variation Index Provider ======================

final indexOfJewelleryVariationInProductDetail = StateProvider<int>((ref) {
  return 0;
});
// ==============================================================

// ================= Home's Review PageView Provider ======================

final indexOfPageViewInHomeReview = StateProvider<int>((ref) {
  return 0;
});

// ==============================================================

// ================= Home's scaffold key Provider ======================

final scaffoldKeyProvider = Provider<GlobalKey<ScaffoldState>>((ref) {
  return GlobalKey<ScaffoldState>();
});

// ==============================================================

/// Providers for each field
final firstNameProvider = StateProvider<String>((ref) => '');
final firstNameProviderAddress = StateProvider<String>((ref) => '');
final lastNameProvider = StateProvider<String>((ref) => '');
final lastNameProviderAddress = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final emailProviderAddress = StateProvider<String>((ref) => '');
final loginEmailProvider = StateProvider<String>((ref) => '');
final forgotEmailProvider = StateProvider<String>((ref) => '');
final phoneProvider = StateProvider<String>((ref) => '');
final phoneProviderAddress = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final resetPasswordProvider = StateProvider<String>((ref) => '');
final resetCPassProvider = StateProvider<String>((ref) => '');
final loginPasswordProvider = StateProvider<String>((ref) => '');
final confirmPasswordProvider = StateProvider<String>((ref) => '');

/// Providers for visibility toggling
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final loginpasswordVisibilityProvider = StateProvider<bool>((ref) => false);
final confirmPasswordVisibilityProvider = StateProvider<bool>((ref) => false);
final resetPasswordVisibilityProvider = StateProvider<bool>((ref) => false);
final resetCPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

/// Field validation providers
final firstNameValidProvider = StateProvider<bool>((ref) => false);
final firstNameValidProviderAddress = StateProvider<bool>((ref) => false);
final lastNameValidProvider = StateProvider<bool>((ref) => false);
final lastNameValidProviderAddress = StateProvider<bool>((ref) => false);
final emailValidProvider = StateProvider<bool>((ref) => false);
final emailValidProviderAddress = StateProvider<bool>((ref) => false);
final loginEmailValidProvider = StateProvider<bool>((ref) => false);
final forgotEmailValidProvider = StateProvider<bool>((ref) => false);
final phoneValidProvider = StateProvider<bool>((ref) => false);
final phoneValidProviderAddress = StateProvider<bool>((ref) => false);
final passwordValidProvider = StateProvider<bool>((ref) => false);
final loginPasswordValidProvider = StateProvider<bool>((ref) => false);
final resetPasswordValidProvider = StateProvider<bool>((ref) => false);
final resetCPasswordValidProvider = StateProvider<bool>((ref) => false);
final confirmPasswordValidProvider = StateProvider<bool>((ref) => false);

///Shipping Address Validation
final countryRegionProvider = StateProvider<String>((ref) => "");
final countryRegionValidProvider = StateProvider<bool>((ref) => false);
final streetAddressProvider = StateProvider<String>((ref) => "");
final streetAddressValidProvider = StateProvider<bool>((ref) => false);
final appartmentProvider = StateProvider<String>((ref) => "");
final appartmentValidProvider = StateProvider<bool>((ref) => false);
final postalCodeProvider = StateProvider<String>((ref) => "");
final postalCodeValidProvider = StateProvider<bool>((ref) => false);
final townCityProvider = StateProvider<String>((ref) => "");
final townCityValidProvider = StateProvider<bool>((ref) => false);
final shippingPhoneProvider = StateProvider<String>((ref) => "");
final shippingPhoneValidProvider = StateProvider<bool>((ref) => false);

/// Loading provider
final isLoadingProvider = StateProvider<bool>((ref) => false);

/// Profile Screen Validation
final firstNameValidProviderProfile = StateProvider<bool>((ref) => false);
final lastNameValidProviderProfile = StateProvider<bool>((ref) => false);
final emailValidProviderProfile = StateProvider<bool>((ref) => false);
final firstNameProviderProfile = StateProvider<String>((ref) => '');
final lastNameProviderProfile = StateProvider<String>((ref) => '');
final emailProviderProfile = StateProvider<String>((ref) => '');
final phoneProviderProfile = StateProvider<String>((ref) => '');
final phoneValidProviderProfile = StateProvider<bool>((ref) => false);
