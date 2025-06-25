import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/model/add_to_cart_model.dart';
// import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/auth/login_model.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/orders/my_orders_model.dart';
import 'package:dikla_spirit/model/product_details_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/model/wishlist_model.dart';
import 'package:dikla_spirit/screens/orders/my_orders_screen.dart';
import 'package:dikla_spirit/screens/product/product_details_screen.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/auth/google_signin.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Constants {
  static String baseUrl = "https://diklaspirit.bee1.cloud//wp-json/ds/v1/";
  static String loginUrl = "login";
  static String socialLoginUrl = "social-login";
  static String fcmTokenUrl = "save-fcm-token";
  static String onboardingUrl = "splash-screen";
  static String signUpUrl = "signup";
  static String forgotPasswordUrl = "forgot-password";
  static String resetPasswordUrl = "reset-password";
  static String refreshTokenUrl = "refresh-token";
  static String homeUrl = "home";
  static String shopListUrl = "shop";
  static String wishListUrl = "wishlist";
  static String expectedDateUrl = "expected-date";
  static String myCartListUrl = "cart";
  static String productListUrl = "products-by-category/";
  static String productFilterOptionsUrl = "filter-by-category/";
  static String productDetailsUrl = "product/";
  static String notifyMe = "notify-me/";
  static String userAppSettingUrl = "user-app-setting";
  static String setUserAppSettingUrl = "update-basic";
  static String addToWishList = "add-wishlist";
  static String moveToWishList = "move-to-wishlist";
  static String addToCart = "add-to-cart";
  static String removeFromCart = "remove-from-cart";
  static String updateProfileUrl = "profile";
  static String faqUrl = "faq";
  static String helpQuestionsUrl = "help-questions";
  static String shippingAddress = "shipping-addresses";
  static String orderSummay = "checkout-details";
  static String checkout = "checkout";
  static String myOrdersUrl = "my-orders";
  static String searchUrl = "search?search=";
  static String searcBghUrl = "search-screen";
  static String ourReviewsUrl = "reviews";
  static String profileUrl = "profile";
  static String ordersDetailsUrl = "order-detail-by-item/";
  static String submitRequestUrl = "help";
  static String horoscopeApiUrl = "get-horoscope";
  static String zodiacCompApiUrl = "get-zodiac-comp";
  static String addReviewUrl = "add-review";

  // ================= Secure Storage Keys ========================
  static String isAppSettingsDone = "isAppSettingDone";
  static String isOnboardingDone = "isAppSettingDone";
  // ==============================================================

  // static void showCustomSnackbar(BuildContext context, String message,
  //     {Duration duration = const Duration(seconds: 3)}) {
  //   ProviderScope.containerOf(context)
  //       .read(snackbarProvider.notifier)
  //       .showSnackbar(message, duration: duration);
  // }

// =================== Image Path ===================
  static String imagePathHome = "assets/images/home/";
  static String imagePath = "assets/images/";
  static String imagePathAppBar = "assets/images/app_bar/";
  static String imagePathProducts = "assets/images/products/";
  static String imagePathMenu = "assets/images/menu/";
  static String imagePathAuth = "assets/images/auth/";
  static String imagePathAppSettings = "assets/images/app_setting/";
  static String imagePathCheckOut = "assets/images/check_out/";
  static String imagePathOrders = "assets/images/orders/";
  static String imagePathHelp = "assets/images/help/";
  static String imagePathZodiacSign = "assets/images/zodiac/";
  static String imagePathHoroscope = "assets/images/horoscope/";
// ==================================================
}

class ConstantMethods {
  static void showSnackbar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2), bool? isFalse = false}) {
    final snackBar = SnackBar(
      backgroundColor: isFalse! ? Color(0xE5E05B51) : AppTheme.subTextColor,
      content: Text(
        message,
        style: AppTheme.lightTheme.textTheme.bodyLarge
            ?.copyWith(color: AppTheme.appBarAndBottomBarColor),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget customDivider({double? width}) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: width ?? 0.7,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: AppTheme.strokeColor,
          ),
        ),
      ),
    );
  }

  static void saveLoginData(LoginModelData response, WidgetRef ref) async {
    await SecureStorage.save('token', response.token ?? "");
    await SecureStorage.save('refresh_token', response.refreshToken ?? "");
    await SecureStorage.save('user_id', response.userId.toString());
    // if (response.country!.isNotEmpty) {}
    if (response.currency != null && response.currency!.isNotEmpty) {
      ref.read(currentCurrencySymbolProvider.notifier).state =
          CurrencySymbol.fromString(response.currency ?? "").symbol;
      await SecureStorage.save(Constants.isAppSettingsDone, "true");
    } else {
      ref.read(currentCurrencySymbolProvider.notifier).state = "\$";
    }
    if (response.language != null && response.language!.isNotEmpty) {
      ref
          .read(changeLocaleProvider.notifier)
          .set(Locale(response.language ?? "en"));
    } else {
      ref.read(changeLocaleProvider.notifier).set(Locale("en"));
    }
  }

  static void googleSignIn(WidgetRef ref) async {
    final user = await GoogleSignInService.signIn();
    if (user != null) {
      ref
          .read(socialLoginApiProvider(SocialLoginParams(user.email, user.id))
              .future)
          .then((loginModel) {
        if (loginModel.statusCode == 200) {
          if (loginModel.data != null) {
            ConstantMethods.saveLoginData(loginModel.data!, ref);
            ConstantMethods.showAlertBottomSheet(
                context: ref.context,
                title: loginModel.message ?? "",
                message: "Please wait you will be redirect to \nthe home page.",
                icon: "${Constants.imagePathAuth}success_new.svg",
                isLoading: true);
            Future.delayed(Duration(seconds: 3)).then(
              (value) async {
                ///Enable this to Change language
                String? isAppSettingsDone =
                    await SecureStorage.get(Constants.isAppSettingsDone);

                if (isAppSettingsDone != null &&
                    isAppSettingsDone.toLowerCase() == "true") {
                  ref.context.go("/dashboard");
                } else {
                  ref.context.go("/appSettings");
                }
              },
            );
          }
          ref.read(isLoadingProvider.notifier).state = false;
        } else {
          ConstantMethods.showAlertBottomSheet(
              context: ref.context,
              title: "Failed",
              message: loginModel.message ?? "",
              isLoading: true,
              icon: "${Constants.imagePathAuth}failed_new.svg");
          ref.read(isLoadingProvider.notifier).state = false;
        }
      }).catchError((error) {
        ConstantMethods.showSnackbar(ref.context, error.toString());
        ref.read(isLoadingProvider.notifier).state = false;
      });
      print(user.displayName);
      print(user.email);
      print(user.photoUrl);
    }
  }

  static Future<void> signInWithFacebook(WidgetRef ref) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        print("🟢 Facebook Login Success:");
        print("👤 Name: ${userData['name']}");
        print("📧 Email: ${userData['email']}");
        print("🆔 ID: ${userData['id']}");
        print("🖼️ Picture: ${userData['picture']['data']['url']}");
        ref
            .read(socialLoginApiProvider(
                    SocialLoginParams(userData['email'], userData['id']))
                .future)
            .then((loginModel) {
          if (loginModel.statusCode == 200) {
            if (loginModel.data != null) {
              ConstantMethods.saveLoginData(loginModel.data!, ref);
              ConstantMethods.showAlertBottomSheet(
                  context: ref.context,
                  title: loginModel.message ?? "",
                  message:
                      "Please wait you will be redirect to \nthe home page.",
                  icon: "${Constants.imagePathAuth}success_new.svg",
                  isLoading: true);
              Future.delayed(Duration(seconds: 3)).then(
                (value) async {
                  ///Enable this to Change language
                  String? isAppSettingsDone =
                      await SecureStorage.get(Constants.isAppSettingsDone);

                  if (isAppSettingsDone != null &&
                      isAppSettingsDone.toLowerCase() == "true") {
                    ref.context.go("/dashboard");
                  } else {
                    ref.context.go("/appSettings");
                  }
                },
              );
            }
            ref.read(isLoadingProvider.notifier).state = false;
          } else {
            ConstantMethods.showAlertBottomSheet(
                context: ref.context,
                title: "Failed",
                message: loginModel.message ?? "",
                isLoading: true,
                icon: "${Constants.imagePathAuth}failed_new.svg");
            ref.read(isLoadingProvider.notifier).state = false;
          }
        }).catchError((error) {
          ConstantMethods.showSnackbar(ref.context, error.toString());
          ref.read(isLoadingProvider.notifier).state = false;
        });
      } else {
        print("🔴 Facebook Login Failed: ${result.message}");
        ConstantMethods.showSnackbar(ref.context, "Facebook Login Failed");
      }
    } catch (e) {
      ConstantMethods.showSnackbar(ref.context, "Facebook Login Failed");
      print("❌ Facebook Login Exception: $e");
    }
  }

  static void wishlistPopUP(BuildContext context,
      AsyncValue<WishlistModel> wishlistData, String? currency) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Consumer(
              builder: (context, ref, child) {
                final wishlistData = ref.watch(wishListApiProvider);

                return Container(
                    decoration: BoxDecoration(
                        color: AppTheme.appBarAndBottomBarColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0.r),
                            topRight: Radius.circular(12.0.r))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.transparent,
                                )),
                            Text(
                              'Favorites',
                              style: AppTheme.lightTheme.textTheme.bodyLarge,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: AppTheme.textColor,
                                ))
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recently Added',
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(fontSize: 14.sp),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                  context.push("/wishlist");
                                },
                                child: Text(
                                  'View All',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(color: AppTheme.primaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: SizedBox(
                            // height: ScreenUtil().screenHeight / 3.7,
                            child: wishlistData.when(
                              data: (data) {
                                switch (data.status) {
                                  case true:
                                    Future.microtask(
                                      () {
                                        ref
                                            .read(wishlistProvider.notifier)
                                            .initializeWishList(
                                                data.data?.wishlist ?? []);
                                        // currency = CurrencySymbol.fromString(
                                        //     data.data?.currency ?? "USD");
                                      },
                                    );
                                    return data.data?.wishlist != null
                                        ? ListView.builder(
                                            itemCount:
                                                data.data?.wishlist!.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 16.0.sp,
                                                        left: 14.sp,
                                                        right: 14.sp),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          12)),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: data
                                                                        .data
                                                                        ?.wishlist![
                                                                            index]
                                                                        .image ??
                                                                    "",
                                                                height:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            50),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 14.sp,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: ScreenUtil()
                                                                          .screenWidth *
                                                                      0.5,
                                                                  child: Text(
                                                                    data.data?.wishlist![index]
                                                                            .title ??
                                                                        "",
                                                                    style: AppTheme
                                                                        .lightTheme
                                                                        .textTheme
                                                                        .bodySmall,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 4.sp,
                                                                ),
                                                                Text(
                                                                  "$currency ${data.data?.wishlist![index].price.toString() ?? ""}",
                                                                  style: AppTheme
                                                                      .lightTheme
                                                                      .textTheme
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  ConstantMethods.toggleWishlist(
                                                                      WishListType
                                                                          .wishList,
                                                                      ref,
                                                                      index:
                                                                          index);
                                                                },
                                                                icon: SvgPicture
                                                                    .asset(
                                                                        "assets/images/remove_from_list.svg")),
                                                            IconButton(
                                                                onPressed: () {
                                                                  if (data
                                                                          .data!
                                                                          .wishlist?[
                                                                              index]
                                                                          .type ==
                                                                      "variable") {
                                                                    if (data.data!.wishlist?[index].variation !=
                                                                            null &&
                                                                        data
                                                                            .data!
                                                                            .wishlist![index]
                                                                            .variation!
                                                                            .isNotEmpty) {
                                                                      showVariation(
                                                                          context,
                                                                          data.data!.wishlist?[index].variation ??
                                                                              [],
                                                                          data.data!.wishlist?[index].template == 3
                                                                              ? "Select Color"
                                                                              : "Strength level to choose form",
                                                                          data.data!.wishlist?[index].template ??
                                                                              0,
                                                                          data.data!.wishlist?[index].title ??
                                                                              "",
                                                                          currency ??
                                                                              "",
                                                                          data.data!.wishlist?[index].id.toString() ??
                                                                              "");
                                                                    }
                                                                  } else {
                                                                    ref
                                                                        .refresh(addToCartApiProvider(AddtoCartParam(productId: data.data!.wishlist?[index].id.toString() ?? "0"))
                                                                            .future)
                                                                        .then(
                                                                            (value) {
                                                                      if (value
                                                                          .status!) {
                                                                        ConstantMethods.showSnackbar(
                                                                            context,
                                                                            "${data.data?.wishlist?[index].title} Added To Bag");
                                                                        ref.watch(wishlistProvider.notifier).removeFromWishlist(
                                                                            index);
                                                                      } else {
                                                                        ConstantMethods.showSnackbar(
                                                                            context,
                                                                            value.message ??
                                                                                "");
                                                                      }
                                                                    });
                                                                  }
                                                                },
                                                                icon: SvgPicture
                                                                    .asset(
                                                                        "assets/images/move_to_cart.svg"))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.3,
                                                  ),
                                                  SizedBox(
                                                    height: 12.sp,
                                                  )
                                                ],
                                              );
                                            },
                                          )
                                        : Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.0.sp),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 14.sp,
                                                ),
                                                SvgPicture.asset(
                                                  "${Constants.imagePath}wishlist.svg",
                                                  height: 24.sp,
                                                ),
                                                SizedBox(
                                                  height: 14.sp,
                                                ),
                                                Text(
                                                  'Nothing Saved...',
                                                  style: AppTheme.lightTheme
                                                      .textTheme.headlineLarge
                                                      ?.copyWith(
                                                          fontSize: 18.sp),
                                                ),
                                                SizedBox(
                                                  height: 11.sp,
                                                ),
                                                Text(
                                                  '... no worries. Join to start saving, or sign in to see what you’ve already saved. Exploring made way easy.',
                                                  textAlign: TextAlign.center,
                                                  style: AppTheme.lightTheme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          fontSize: 14.sp),
                                                ),
                                                SizedBox(
                                                  height: 24.sp,
                                                ),
                                                Container(
                                                  width: ScreenUtil()
                                                      .setWidth(150),
                                                  height: ScreenUtil()
                                                      .setHeight(36),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 24,
                                                      vertical: 9),
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF393939),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                  ),
                                                  child: Text(
                                                    'Start Exploring',
                                                    textAlign: TextAlign.center,
                                                    style: AppTheme.lightTheme
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
                                                            color: AppTheme
                                                                .appBarAndBottomBarColor,
                                                            fontSize: 14.sp),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50.sp,
                                                ),
                                              ],
                                            ),
                                          );
                                  case false:
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0.sp),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 14.sp,
                                          ),
                                          Text(
                                            'Nothing Saved...',
                                            style: AppTheme.lightTheme.textTheme
                                                .headlineLarge
                                                ?.copyWith(fontSize: 18.sp),
                                          ),
                                          SizedBox(
                                            height: 11.sp,
                                          ),
                                          Text(
                                            '... no worries. Join to start saving, or sign in to see what you’ve already saved. Exploring made way easy.',
                                            textAlign: TextAlign.center,
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    );
                                  default:
                                    return SizedBox();
                                }
                              },
                              error: (error, stackTrace) {
                                print(
                                    "Shop List Error: ${stackTrace.toString()}");
                                return;
                              },
                              loading: () {
                                final spinkit = SpinKitPumpingHeart(
                                  color: AppTheme.appBarAndBottomBarColor,
                                  size: ScreenUtil().setHeight(50),
                                );
                                return Center(child: spinkit);
                              },
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            );
          },
        );
      },
    );
  }

  static void showAlertBottomSheet(
      {required BuildContext context,
      required String title,
      required String message,
      required String icon,
      bool isLoading = false}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().setHeight(260.sp),
          // margin: EdgeInsets.symmetric(horizontal: 16.0.sp),
          padding: EdgeInsets.only(
            top: 16.0.sp,
          ),
          decoration: BoxDecoration(
            color: AppTheme.appBarAndBottomBarColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0.sp),
                topRight: Radius.circular(16.0.sp)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 33.sp,
              ),
              SvgPicture.asset(
                icon,
                height: 50.sp,
              ),
              // Icon(
              //   icon,
              //   color: iconColor,
              //   size: 44.0.sp,
              // ),
              SizedBox(height: 16.0.sp),
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.labelMedium
                    ?.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 16.0.sp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                child: Text(message,
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        fontSize: 14.sp, color: AppTheme.subTextColor)),
              ),
              SizedBox(height: 12.0.sp),
              Spacer(),
              isLoading
                  ? SizedBox(
                      height: 25.sp,
                      width: 25.sp,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.subTextColor),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 12.0.sp),
            ],
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 3)).then((onValue) {
      // if (mounted) {
      context.pop();
      // }
    });
  }

  static Widget buildErrorUI(WidgetRef ref, {void Function()? onPressed}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120.h,
            width: 120.h,
            decoration: ShapeDecoration(
              color: AppTheme.appBarAndBottomBarColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Center(
              child: SvgPicture.asset(
                "${Constants.imagePath}warning.svg",
                fit: BoxFit.contain,
                height: 38.h,
                width: 42.w,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Oops!',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.subTextColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Sorry, we can’t load this \npage right now.',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodySmall
                ?.copyWith(fontSize: 14.sp, letterSpacing: 0.20.sp),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.subTextColor,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: AppTheme.lightTheme.textTheme.labelMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> downloadFileToDevice(
      String url, String fileName, BuildContext context) async {
    try {
      // Request storage permission for Android
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          print("Storage permission denied");
          openAppSettings();
          return;
        }
      }

      // Get device directory
      final dir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      final filePath = "${dir!.path}/$fileName";

      final dio = Dio();
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
                "Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );
      if (context.mounted) {
        showSnackbar(context, "File Downloaded Successfully: $filePath");
      }
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, "Download Failed");
      }
    }
  }

  static Widget sidemenuItem(
    String icon,
    String title, {
    String? subtitle,
    void Function()? onTap,
    bool isCountry = false,
    String? package,
    Widget? trailing,
    List<Widget>? subItems,
    ValueNotifier<bool>? isExpandedNotifier,
  }) {
    final isExpandable = subItems != null && subItems.isNotEmpty;
    final expansionNotifier = isExpandedNotifier ?? ValueNotifier<bool>(false);

    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: 4.sp, horizontal: 10.sp),
          dense: true,
          leading: SizedBox(
            width: 32.sp,
            height: 32.sp,
            child: isCountry
                ? ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                    child: Image.asset(
                      icon,
                      package: package,
                      height: 24.sp,
                      width: 24.sp,
                      fit: BoxFit.cover,
                    ),
                  )
                : SvgPicture.asset(
                    icon,
                    height: 24.sp,
                    width: 24.sp,
                    fit: BoxFit.contain,
                  ),
          ),
          title: Text(
            title,
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp),
          ),
          subtitle: subtitle != null
              ? Text(subtitle, style: AppTheme.lightTheme.textTheme.bodySmall)
              : null,
          trailing: isExpandable
              ? ValueListenableBuilder<bool>(
                  valueListenable: expansionNotifier,
                  builder: (context, isExpanded, _) {
                    return Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.arrow_forward_ios,
                      size: 18.sp,
                    );
                  },
                )
              : trailing ?? Icon(Icons.arrow_forward_ios, size: 18.sp),
          onTap: () {
            if (isExpandable) {
              expansionNotifier.value =
                  !expansionNotifier.value; // Toggle expansion
            } else {
              onTap?.call(); // Navigate if no sub-items
            }
          },
        ),

        // Expanded sub-items
        if (isExpandable)
          ValueListenableBuilder<bool>(
            valueListenable: expansionNotifier,
            builder: (context, isExpanded, _) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: isExpanded
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 10.sp), // Indent sub-items
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: subItems.map((subItem) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.sp),
                              child: subItem,
                            );
                          }).toList(),
                        ),
                      )
                    : SizedBox.shrink(),
              );
            },
          ),
      ],
    );
  }

  static Widget noDataWidget({
    bool isButtonNeeded = false,
    String? title,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
      child: Column(
        children: [
          SizedBox(
            height: 14.sp,
          ),
          SvgPicture.asset(
            "${Constants.imagePath}wishlist.svg",
            height: 24.sp,
          ),
          SizedBox(
            height: 14.sp,
          ),
          Text(
            title ?? 'Nothing Saved...',
            style: AppTheme.lightTheme.textTheme.headlineLarge
                ?.copyWith(fontSize: 18.sp),
          ),
          SizedBox(
            height: 11.sp,
          ),
          Text(
            '... no worries. Join to start saving, or sign in to see what you’ve already saved. Exploring made way easy.',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodySmall
                ?.copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 24.sp,
          ),
          isButtonNeeded
              ? Container(
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(36),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
                  decoration: ShapeDecoration(
                    color: Color(0xFF393939),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Start Exploring',
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.appBarAndBottomBarColor,
                        fontSize: 14.sp),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 50.sp,
          ),
        ],
      ),
    );
  }

  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }

  static void toggleWishlist(WishListType listType, WidgetRef ref,
      {int? index}) async {
    // Get the current item
    final dynamic updatedItem = listType == WishListType.quick
        ? ref.read(wishlistProvider).quickSolutions[index!]
        : listType == WishListType.youMayLikeThis
            ? ref.read(wishlistProvider).youMayAlsoLikeThisInWishList
            : listType == WishListType.favToExploreInCart
                ? ref.read(wishlistProvider).favToExploreInCart[index!]
                : listType == WishListType.favToExploreInWishList
                    ? ref.read(wishlistProvider).favToExploreInWishList[index!]
                    : listType == WishListType.productDetailFastResult
                        ? ref
                            .read(wishlistProvider)
                            .productDetailFastResult[index!]
                        : listType == WishListType.productDetailYouMayLikeThis
                            ? ref
                                .watch(wishlistProvider)
                                .productDetailYouMayLikeThis[index!]
                            : listType == WishListType.wishList
                                ? ref.watch(wishlistProvider).wishlist[index!]
                                : listType == WishListType.productDetail
                                    ? ref.read(wishlistProvider).productDetails
                                    : listType == WishListType.productCatList
                                        ? ref
                                            .read(wishlistProvider)
                                            .productCatList[index!]
                                        : listType ==
                                                WishListType
                                                    .searchRecentPurchase
                                            ? ref
                                                .read(wishlistProvider)
                                                .searchRecentPurchase[index!]
                                            : listType ==
                                                    WishListType
                                                        .shopBestSellingWishlist
                                                ? ref
                                                        .read(wishlistProvider)
                                                        .shopBestSellingWishlist[
                                                    index!]
                                                : ref
                                                    .read(wishlistProvider)
                                                    .fastResults[index!];

    if (index != null) {
      if (listType == WishListType.wishList) {
        ref.read(wishlistProvider.notifier).removeFromWishlist(index);
      } else {
        ref
            .read(wishlistProvider.notifier)
            .toggleWishlist(listType, index: index);
      }
    } else {
      ref.read(wishlistProvider.notifier).toggleWishlist(listType);
    }

    try {
      var encodedParam = '';
      // if (listType == WishListType.productDetail) {
      //   encodedParam = json.encode({
      //     "product_id": updatedItem.id.toString(),
      //   });
      // } else {
      encodedParam = json.encode({
        "product_id": updatedItem.id.toString(),
      });
      // }
      final data = await ApiUtils.makeRequest(
          Constants.baseUrl + Constants.addToWishList,
          method: "POST",
          jsonParams: encodedParam,
          isRaw: true,
          useAuth: true);

      if (data["status"]) {
        var fastResults = DashboardModelFastResult.fromJson(data["data"]);

        if (index != null) {
          ref
              .read(wishlistProvider.notifier)
              .updateItem(listType, fastResults, index: index);
        } else {
          ref.read(wishlistProvider.notifier).updateItem(listType, fastResults);
        }
        if (ref.context.mounted) {
          ConstantMethods.showSnackbar(ref.context, data["message"] ?? "");
        }
        ref.invalidate(wishListApiProvider);
      } else {
        if (data["status_code"] == 402) {
          await ApiUtils.refreshToken().then((onValue) {
            toggleWishlist(listType, ref, index: index);
          });
          return;
        }
        // Revert if API failed
        ref.invalidate(wishListApiProvider);
      }
    } catch (e) {
      throw ErrorDescription("Something Went Wrong, Please Try Again.");
    }
  }

  static void showFeedbackPopup(
      BuildContext context, MyOrdersListModelOrders data) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FeedbackPopup(data: data);
      },
    );
  }

  static void showVariation(
      BuildContext context,
      List<Variation> variation,
      String title,
      int template,
      String itemTitle,
      String currency,
      String productId) {
    // final localization = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: AppTheme.appBarAndBottomBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final selectedVariation = ref.watch(selectedVariationOfWishList);
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close,
                              color: Colors.transparent,
                            )),
                        Text(
                          title,
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(selectedVariationOfWishList.notifier)
                                  .state = Variation();
                              context.pop();
                            },
                            icon: SvgPicture.asset(
                              "${Constants.imagePath}close_variation.svg",
                              height: 11.sp,
                            )),
                      ],
                    ),
                    const Divider(),
                    SizedBox(height: 20.sp),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.sp),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: variation.map((variation) {
                          return InkWell(
                            onTap: () {
                              ref
                                  .watch(selectedVariationOfWishList.notifier)
                                  .state = variation;
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0.sp),
                              decoration: ShapeDecoration(
                                color: AppTheme.appBarAndBottomBarColor,
                                shape: RoundedRectangleBorder(
                                  side: ref
                                              .watch(
                                                  selectedVariationOfWishList)
                                              .id ==
                                          variation.id
                                      ? BorderSide(
                                          width: 0.8, color: AppTheme.textColor)
                                      : BorderSide(
                                          width: 0.8,
                                          color: AppTheme.strokeColor),
                                  borderRadius: BorderRadius.circular(3.sp),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: AppTheme.textColor.withOpacity(0.1),
                                  )
                                ],
                              ),
                              child: Text(
                                variation.termName ?? "",
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(fontSize: 14.sp),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 14.sp),

                    // Price
                    if (selectedVariation.price != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        child: Text(
                          '$currency ${selectedVariation.price}',
                          style: AppTheme.lightTheme.textTheme.titleSmall,
                        ),
                      ),

                    // Expected Day
                    if (template == 2)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        child: Column(
                          children: [
                            SizedBox(height: 8.sp),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Expected Day',
                                    style: AppTheme
                                        .lightTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' : 30.12.2024',
                                    style: AppTheme
                                        .lightTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppTheme.subTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.sp),
                          ],
                        ),
                      ),

                    SizedBox(height: 20.sp),

                    // Add to Bag Button
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (selectedVariation.id == null) {
                            showDialog(
                              useSafeArea: true,
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                    "Kindly, Select a Variant To Continue.",
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium,
                                  ),
                                );
                              },
                            );
                          } else {
                            ref.watch(isLoadingProvider.notifier).state = true;
                            ref
                                .refresh(addToCartApiProvider(AddtoCartParam(
                                        productId: productId,
                                        variationId:
                                            selectedVariation.id.toString()))
                                    .future)
                                .then((onValue) {
                              ref.watch(isLoadingProvider.notifier).state =
                                  false;
                              if (onValue.status!) {
                                context.pop();
                                if (context.mounted) {
                                  ConstantMethods.showSnackbar(
                                      context, onValue.message ?? "");
                                  ref.refresh(myCartApiProvider);
                                }
                              } else {
                                ConstantMethods.showSnackbar(
                                    context, onValue.message ?? "");
                              }
                            });
                          }
                        },
                        child: Container(
                          width: ScreenUtil().screenWidth * 0.9,
                          height: 36.sp,
                          decoration: ShapeDecoration(
                            color: AppTheme.subTextColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppTheme.subTextColor),
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final loading = ref.watch(isLoadingProvider);
                              return loading
                                  ? Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "Add to Bag",
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall
                                            ?.copyWith(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.sp),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // static void showVariation(BuildContext context, List<Variation> variation,
  //     String title, int template, String itemTitle) {
  //   final localization = AppLocalizations.of(context);
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return Consumer(
  //         builder: (context, ref, child) {
  //           final selectedVariation = ref.watch(selectedVariationOfWishList);
  //           return DraggableScrollableSheet(
  //             expand: false,
  //             initialChildSize: 0.3,
  //             minChildSize: 0.3,
  //             maxChildSize: 0.9,
  //             builder: (context, scrollController) {
  //               return Container(
  //                 decoration: const BoxDecoration(
  //                     color: AppTheme.appBarAndBottomBarColor,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(12.0),
  //                         topRight: Radius.circular(12.0))),
  //                 child: SingleChildScrollView(
  //                   controller: scrollController,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // Close button & title
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           IconButton(
  //                               onPressed: () {},
  //                               icon: const Icon(
  //                                 Icons.close,
  //                                 color: Colors.transparent,
  //                               )),
  //                           Text(
  //                             title,
  //                             style: AppTheme.lightTheme.textTheme.labelMedium
  //                                 ?.copyWith(
  //                                     color: AppTheme.primaryColor,
  //                                     fontWeight: FontWeight.w500),
  //                           ),
  //                           IconButton(
  //                               onPressed: () {
  //                                 ref
  //                                     .read(
  //                                         selectedVariationOfWishList.notifier)
  //                                     .state = Variation();
  //                                 context.pop();
  //                               },
  //                               icon: SvgPicture.asset(
  //                                 "${Constants.imagePath}close_variation.svg",
  //                                 height: 11.sp,
  //                               ))
  //                         ],
  //                       ),
  //                       Divider(),
  //                       SizedBox(height: 28.sp),

  //                       // Variation Selection
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 18.sp),
  //                         child: Wrap(
  //                           spacing: 8.0,
  //                           runSpacing: 8.0,
  //                           children: variation.map((variation) {
  //                             return InkWell(
  //                               onTap: () {
  //                                 ref
  //                                     .watch(
  //                                         selectedVariationOfWishList.notifier)
  //                                     .state = variation;
  //                               },
  //                               child: Container(
  //                                 padding: EdgeInsets.all(8.0.sp),
  //                                 decoration: ShapeDecoration(
  //                                     color: AppTheme.appBarAndBottomBarColor,
  //                                     shape: RoundedRectangleBorder(
  //                                       side: ref
  //                                                   .watch(
  //                                                       selectedVariationOfWishList)
  //                                                   .id ==
  //                                               variation.id
  //                                           ? BorderSide(
  //                                               width: 0.8,
  //                                               color: AppTheme.textColor)
  //                                           : BorderSide(
  //                                               width: 0.8,
  //                                               color: AppTheme.strokeColor),
  //                                       borderRadius:
  //                                           BorderRadius.circular(3.sp),
  //                                     ),
  //                                     shadows: [
  //                                       BoxShadow(
  //                                         color: AppTheme.textColor
  //                                             .withOpacity(0.1),
  //                                       )
  //                                     ]),
  //                                 child: Text(
  //                                   variation.termName ?? "",
  //                                   style: AppTheme
  //                                       .lightTheme.textTheme.bodySmall
  //                                       ?.copyWith(fontSize: 14.sp),
  //                                 ),
  //                               ),
  //                             );
  //                           }).toList(),
  //                         ),
  //                       ),
  //                       SizedBox(height: 14.sp),

  //                       // Price
  //                       if (selectedVariation.price != null)
  //                         Padding(
  //                           padding: EdgeInsets.symmetric(horizontal: 19.sp),
  //                           child: Text(
  //                             '\$ ${selectedVariation.price}',
  //                             style: AppTheme.lightTheme.textTheme.titleSmall,
  //                           ),
  //                         ),

  //                       // Expected Day
  //                       if (template == 3)
  //                         Padding(
  //                           padding: EdgeInsets.symmetric(horizontal: 18.sp),
  //                           child: Column(
  //                             children: [
  //                               SizedBox(height: 8.sp),
  //                               Text.rich(
  //                                 TextSpan(
  //                                   children: [
  //                                     TextSpan(
  //                                       text: 'Expected Day',
  //                                       style: AppTheme
  //                                           .lightTheme.textTheme.titleSmall
  //                                           ?.copyWith(
  //                                               color: AppTheme.primaryColor,
  //                                               fontWeight: FontWeight.w500,
  //                                               fontSize: 12.sp),
  //                                     ),
  //                                     TextSpan(
  //                                       text: ' : 30.12.2024',
  //                                       style: AppTheme
  //                                           .lightTheme.textTheme.titleSmall
  //                                           ?.copyWith(
  //                                               color: AppTheme.subTextColor,
  //                                               fontWeight: FontWeight.w500,
  //                                               fontSize: 12.sp),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               SizedBox(height: 8.sp),
  //                             ],
  //                           ),
  //                         ),

  //                       SizedBox(height: 20.sp),

  //                       // Add to Bag Button
  //                       Center(
  //                         child: InkWell(
  //                           onTap: () {
  //                             if (selectedVariation.id == null) {
  //                               showDialog(
  //                                 useSafeArea: true,
  //                                 barrierDismissible: true,
  //                                 context: context,
  //                                 builder: (context) {
  //                                   return AlertDialog(
  //                                     content: Text(
  //                                       "Kindly, Select a Variant To Continue.",
  //                                       style: AppTheme
  //                                           .lightTheme.textTheme.bodyMedium,
  //                                     ),
  //                                   );
  //                                 },
  //                               );
  //                             } else {
  //                               ref.watch(isLoadingProvider.notifier).state =
  //                                   true;
  //                               ref
  //                                   .refresh(addToCartApiProvider(
  //                                           selectedVariation.id.toString())
  //                                       .future)
  //                                   .then((onValue) {
  //                                 if (onValue.status!) {
  //                                   ref
  //                                       .watch(isLoadingProvider.notifier)
  //                                       .state = false;
  //                                   context.pop();
  //                                   if (context.mounted) {
  //                                     ConstantMethods.showSnackbar(
  //                                         context, onValue.message ?? "");

  //                                     ref.refresh(myCartApiProvider);
  //                                   }
  //                                 } else {
  //                                   ref
  //                                       .watch(isLoadingProvider.notifier)
  //                                       .state = false;
  //                                   ConstantMethods.showSnackbar(
  //                                       context, onValue.message ?? "");
  //                                 }
  //                               });
  //                             }
  //                           },
  //                           child: Container(
  //                               width: ScreenUtil().screenWidth * 0.9,
  //                               height: 36.sp,
  //                               decoration: ShapeDecoration(
  //                                 color: AppTheme.subTextColor,
  //                                 shape: RoundedRectangleBorder(
  //                                   side: BorderSide(
  //                                       width: 1, color: AppTheme.subTextColor),
  //                                   borderRadius: BorderRadius.circular(8.sp),
  //                                 ),
  //                               ),
  //                               child: Consumer(
  //                                 builder: (context, ref, child) {
  //                                   final loading =
  //                                       ref.watch(isLoadingProvider);
  //                                   return loading
  //                                       ? Padding(
  //                                           padding: EdgeInsets.all(8.0.sp),
  //                                           child: Center(
  //                                             child: CircularProgressIndicator(
  //                                               color: AppTheme
  //                                                   .appBarAndBottomBarColor,
  //                                             ),
  //                                           ),
  //                                         )
  //                                       : Center(
  //                                           child: Text(
  //                                             "Add to Bag",
  //                                             style: AppTheme.lightTheme
  //                                                 .textTheme.bodySmall
  //                                                 ?.copyWith(
  //                                                     color: AppTheme
  //                                                         .appBarAndBottomBarColor,
  //                                                     fontSize: 14.sp),
  //                                           ),
  //                                         );
  //                                 },
  //                               )),
  //                         ),
  //                       ),
  //                       SizedBox(height: 20.sp),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // static void showVariation(BuildContext context, List<Variation> variation,
  //     String title, int template, String itemTitle) {
  //   final localization = AppLocalizations.of(context);
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return Consumer(
  //         builder: (context, ref, child) {
  //           final selectedVariation = ref.watch(selectedVariationOfWishList);
  //           return Container(
  //             decoration: const BoxDecoration(
  //                 color: AppTheme.appBarAndBottomBarColor,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(12.0),
  //                     topRight: Radius.circular(12.0))),
  //             // height: template == 3
  //             //     ? ScreenUtil().setHeight(280)
  //             //     : ScreenUtil().setHeight(250),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     IconButton(
  //                         onPressed: () {},
  //                         icon: const Icon(
  //                           Icons.close,
  //                           color: Colors.transparent,
  //                         )),
  //                     Text(
  //                       title,
  //                       style: AppTheme.lightTheme.textTheme.labelMedium
  //                           ?.copyWith(
  //                               color: AppTheme.primaryColor,
  //                               fontWeight: FontWeight.w500),
  //                     ),
  //                     IconButton(
  //                         onPressed: () {
  //                           ref
  //                               .read(selectedVariationOfWishList.notifier)
  //                               .state = Variation();
  //                           context.pop();
  //                         },
  //                         icon: SvgPicture.asset(
  //                           "${Constants.imagePath}close_variation.svg",
  //                           height: 11.sp,
  //                         ))
  //                   ],
  //                 ),
  //                 Divider(),
  //                 SizedBox(
  //                   height: 28.sp,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 18.sp),
  //                   child: Wrap(
  //                     spacing: 8.0, // Adjust the spacing between the items
  //                     runSpacing: 8.0, // Adjust the spacing between the rows
  //                     children: variation.map((variation) {
  //                       return InkWell(
  //                         onTap: () {
  //                           ref
  //                               .watch(selectedVariationOfWishList.notifier)
  //                               .state = variation;
  //                         },
  //                         child: Container(
  //                           padding: EdgeInsets.all(8.0.sp),
  //                           decoration: ShapeDecoration(
  //                               color: AppTheme.appBarAndBottomBarColor,
  //                               shape: RoundedRectangleBorder(
  //                                 side: ref
  //                                             .watch(
  //                                                 selectedVariationOfWishList)
  //                                             .id ==
  //                                         variation.id
  //                                     ? BorderSide(
  //                                         width: 0.8, color: AppTheme.textColor)
  //                                     : BorderSide(
  //                                         width: 0.8,
  //                                         color: AppTheme.strokeColor),
  //                                 borderRadius: BorderRadius.circular(3.sp),
  //                               ),
  //                               shadows: [
  //                                 BoxShadow(
  //                                   color: AppTheme.textColor.withOpacity(0.1),
  //                                 )
  //                               ]),
  //                           child: Text(
  //                             variation.termName ??
  //                                 "", // Assuming `name` is a property of `variation`
  //                             style: AppTheme.lightTheme.textTheme.bodySmall
  //                                 ?.copyWith(fontSize: 14.sp), // Text style
  //                           ),
  //                         ),
  //                       );
  //                     }).toList(), // Convert the Iterable to a List
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 14.sp,
  //                 ),
  //                 selectedVariation.price != null
  //                     ? Align(
  //                         alignment: Alignment.centerLeft,
  //                         child: Padding(
  //                           padding: EdgeInsets.symmetric(horizontal: 19.sp),
  //                           child: Text(
  //                             '\$ ${selectedVariation.price}',
  //                             style: AppTheme.lightTheme.textTheme.titleSmall,
  //                           ),
  //                         ),
  //                       )
  //                     : SizedBox(),
  //                 Visibility(
  //                   visible: template == 3,
  //                   child: Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 18.sp),
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 8.sp,
  //                           ),
  //                           Text.rich(
  //                             TextSpan(
  //                               children: [
  //                                 TextSpan(
  //                                   text: 'Expected Day',
  //                                   style: AppTheme
  //                                       .lightTheme.textTheme.titleSmall
  //                                       ?.copyWith(
  //                                           color: AppTheme.primaryColor,
  //                                           fontWeight: FontWeight.w500,
  //                                           fontSize: 12.sp),
  //                                 ),
  //                                 TextSpan(
  //                                   text: ' : 30.12.2024',
  //                                   style: AppTheme
  //                                       .lightTheme.textTheme.titleSmall
  //                                       ?.copyWith(
  //                                           color: AppTheme.subTextColor,
  //                                           fontWeight: FontWeight.w500,
  //                                           fontSize: 12.sp),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 8.sp,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 20.sp,
  //                 ),
  //                 Center(
  //                   child: InkWell(
  //                     onTap: () {
  //                       if (selectedVariation.id == null) {
  //                         showDialog(
  //                           useSafeArea: true,
  //                           barrierDismissible: true,
  //                           context: context,
  //                           builder: (context) {
  //                             return Container(
  //                               height: ScreenUtil().screenHeight,
  //                               width: ScreenUtil().screenWidth,
  //                               child: FittedBox(
  //                                 child: Card(
  //                                     margin: EdgeInsets.all(20.sp),
  //                                     child: Padding(
  //                                       padding: EdgeInsets.all(20.0.sp),
  //                                       child: Text(
  //                                         "Kindly, Select a Varient To Continue.",
  //                                         style: AppTheme
  //                                             .lightTheme.textTheme.bodyMedium,
  //                                       ),
  //                                     )),
  //                               ),
  //                             );
  //                           },
  //                         );
  //                       } else {
  //                         ref.watch(isLoadingProvider.notifier).state = true;
  //                         ref
  //                             .refresh(addToCartApiProvider(
  //                                     selectedVariation.id.toString())
  //                                 .future)
  //                             .then((onValue) {
  //                           if (onValue.status!) {
  //                             ref.watch(isLoadingProvider.notifier).state =
  //                                 false;
  //                             context.pop();
  //                             if (context.mounted) {
  //                               ConstantMethods.showSnackbar(
  //                                   context, onValue.message ?? "");

  //                               ref.refresh(myCartApiProvider);
  //                             }
  //                             // ConstantMethods.showAlertBottomSheet(
  //                             //     context: context,
  //                             //     title: title,
  //                             //     message: onValue.message ?? "",
  //                             //     icon:
  //                             //         "${Constants.imagePathAuth}success_new.svg");
  //                           } else {
  //                             ref.watch(isLoadingProvider.notifier).state =
  //                                 false;
  //                             ConstantMethods.showSnackbar(
  //                                 context, onValue.message ?? "");
  //                           }
  //                         });
  //                       }
  //                     },
  //                     child: Container(
  //                         width: ScreenUtil().screenWidth * 0.9,
  //                         height: 36.sp,
  //                         decoration: ShapeDecoration(
  //                           color: AppTheme.subTextColor,
  //                           shape: RoundedRectangleBorder(
  //                             side: BorderSide(
  //                                 width: 1, color: AppTheme.subTextColor),
  //                             borderRadius: BorderRadius.circular(8.sp),
  //                           ),
  //                         ),
  //                         child: Consumer(
  //                           builder: (context, ref, child) {
  //                             final loading = ref.watch(isLoadingProvider);
  //                             return loading
  //                                 ? SizedBox(
  //                                     height: 20.sp,
  //                                     // width: 40.sp,
  //                                     child: Padding(
  //                                       padding: EdgeInsets.all(8.0.sp),
  //                                       child: Center(
  //                                         child: CircularProgressIndicator(
  //                                           color: AppTheme
  //                                               .appBarAndBottomBarColor,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   )
  //                                 : Center(
  //                                     child: Text(
  //                                       "Add to Bag",
  //                                       style: AppTheme
  //                                           .lightTheme.textTheme.bodySmall
  //                                           ?.copyWith(
  //                                               color: AppTheme
  //                                                   .appBarAndBottomBarColor,
  //                                               fontSize: 14.sp),
  //                                     ),
  //                                   );
  //                           },
  //                         )),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}

// Wishlisting Types
enum WishListType {
  quick,
  fast,
  youMayLikeThis,
  favToExploreInWishList,
  favToExploreInCart,
  productCatList,
  productDetail,
  productDetailFastResult,
  productDetailYouMayLikeThis,
  wishList,
  searchRecentPurchase,
  shopBestSellingWishlist
}

enum Currency {
  usd, // US Dollar
  ils, // Shekal
  inr, // Indian Rupee
}

// Extension to map enum values to currency symbols
extension CurrencySymbol on Currency {
  String get symbol {
    switch (this) {
      case Currency.usd:
        return '\$'; // Dollar
      case Currency.inr:
        return '₹'; // Rupee
      case Currency.ils:
        return '₪';
      default:
        return '₪'; // Fallback for unsupported currencies
    }
  }

  // Parse a string to a Currency enum
  static Currency fromString(String currencyString) {
    switch (currencyString.toLowerCase()) {
      case 'usd':
        return Currency.usd;
      case 'inr':
        return Currency.inr;
      case 'ils':
        return Currency.ils;
      default:
        return Currency.ils; // Fallback for unsupported currencies
    }
  }

  /// Parse a currency symbol to a Currency enum
  static Currency fromSymbol(String currencySymbol) {
    switch (currencySymbol) {
      case '\$':
        return Currency.usd;
      case '₹':
        return Currency.inr;
      case '₪':
        return Currency.ils;
      default:
        throw ArgumentError('Invalid currency symbol: $currencySymbol');
    }
  }
}

class FeedbackPopup extends StatefulWidget {
  final MyOrdersListModelOrders data;

  const FeedbackPopup({super.key, required this.data});

  @override
  State<FeedbackPopup> createState() => _FeedbackPopupState();
}

class _FeedbackPopupState extends State<FeedbackPopup> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.appBarAndBottomBarColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.close, color: Colors.transparent),
                      ),
                      Text(
                        'Feedback & Review',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                        onPressed: () => context.pop(),
                        icon:
                            const Icon(Icons.close, color: AppTheme.textColor),
                      ),
                    ],
                  ),
                  const Divider(),

                  /// Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.only(top: 20.0.sp, bottom: 16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProductInfo(widget.data),
                          SizedBox(height: 26.h),
                          const Divider(),
                          SizedBox(height: 14.h),
                          _buildRatingSection(),
                          SizedBox(height: 26.h),
                          const Divider(),
                          SizedBox(height: 14.h),
                          _buildReviewTitleInput(),
                          SizedBox(height: 20.h),
                          const Divider(),
                          SizedBox(height: 17.h),
                          _buildImagesInput(),
                          const Divider(),
                          SizedBox(height: 17.h),
                          _buildReviewInput(),
                          SizedBox(height: 36.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 26.w),
                            child: InkWell(
                              onTap: () {
                                // ref.read(addReviewApiProvider(AddReviewParams(desc: )));
                              },
                              child: Container(
                                height: 34.h,
                                decoration: ShapeDecoration(
                                  color: AppTheme.subTextColor,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: AppTheme.subTextColor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Submit Review',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme
                                                .appBarAndBottomBarColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildProductInfo(MyOrdersListModelOrders data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.sp),
            child: CachedNetworkImage(
              imageUrl: data.image ?? "",
              height: 72.sp,
              width: 72.sp,
            ),
          ),
          SizedBox(width: 12.sp),
          SizedBox(
            width: ScreenUtil().setWidth(200),
            child: Text(
              data.name ?? "",
              style: AppTheme.lightTheme.textTheme.bodySmall
                  ?.copyWith(fontSize: 14.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How would you rate this product?',
            style: AppTheme.lightTheme.textTheme.bodyMedium
                ?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 16.h),
          RatingStars(
            value: rating,
            onValueChanged: (v) => setState(() => rating = v),
            starBuilder: (index, color) {
              bool isFilled = index < rating;
              return isFilled
                  ? SvgPicture.asset("${Constants.imagePath}star.svg")
                  : SvgPicture.asset(
                      "${Constants.imagePathOrders}star_outlined.svg");
            },
            starCount: 5,
            starSize: 18.sp,
            starSpacing: 2,
            valueLabelVisibility: false,
            animationDuration: const Duration(milliseconds: 1000),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTitleInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Title',
            style: AppTheme.lightTheme.textTheme.bodyMedium
                ?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 14.h),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            decoration: _inputDecoration(),
            keyboardType: TextInputType.text,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildReviewInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write Review',
            style: AppTheme.lightTheme.textTheme.bodyMedium
                ?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 14.h),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            decoration: _inputDecoration(
              label: 'Start Writing Here...',
              contentPadding: EdgeInsets.symmetric(
                vertical: 30.h,
                horizontal: 12.w,
              ),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildImagesInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Share Photos Now!',
            style: AppTheme.lightTheme.textTheme.bodyMedium
                ?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'Capture and add your product experiences with photos',
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(color: AppTheme.teritiaryTextColor),
          ),
          SizedBox(height: 14.h),
          InkWell(
            onTap: () async {
              await Permission.camera.onDeniedCallback(() {
                openAppSettings();
              }).onGrantedCallback(() {
                print("granted");
              }).onPermanentlyDeniedCallback(() {
                // openAppSettings();
                print("onPermanentlyDeniedCallback");
              }).onRestrictedCallback(() {
                // openAppSettings();
                print("onRestrictedCallback");
              }).onLimitedCallback(() {
                print("onLimitedCallback");
              }).onProvisionalCallback(() {
                print("onProvisionalCallback");
              }).request();
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(6.r),
              dashPattern: [4, 2],
              strokeWidth: 1,
              color: AppTheme.primaryColor,
              child: Container(
                width: ScreenUtil().screenWidth,
                height: 83.h,
                decoration: BoxDecoration(
                  color: const Color(0x89FFEFF7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "${Constants.imagePath}upload.svg",
                      height: 32.h,
                      width: 32.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? label,
    EdgeInsets? contentPadding,
  }) {
    return InputDecoration(
      label: label != null
          ? Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall
                  ?.copyWith(color: const Color(0xFF7F7F7F)),
            )
          : null,
      contentPadding: contentPadding ?? EdgeInsets.all(12.sp),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.strokeColor),
        borderRadius: BorderRadius.circular(6.sp),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.primaryColor),
        borderRadius: BorderRadius.circular(6.sp),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.strokeColor),
        borderRadius: BorderRadius.circular(6.sp),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.strokeColor),
        borderRadius: BorderRadius.circular(6.sp),
      ),
      errorStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
        color: AppTheme.errorBorder,
        fontSize: 11.sp,
      ),
      fillColor: AppTheme.appBarAndBottomBarColor,
      filled: true,
    );
  }
}

class FeedbackRatingNotifier extends StateNotifier<double> {
  FeedbackRatingNotifier() : super(0.0);

  void updateRating(double newRating) {
    state = newRating;
  }
}

final feedbackRatingProvider =
    StateNotifierProvider<FeedbackRatingNotifier, double>((ref) {
  return FeedbackRatingNotifier();
});
