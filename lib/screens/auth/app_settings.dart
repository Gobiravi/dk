import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/loading_overlay.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppSettingsScreen extends StatefulHookConsumerWidget {
  const AppSettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppSettingsScreenState();
}

class _AppSettingsScreenState extends ConsumerState<AppSettingsScreen> {
  // late AsyncValue<UserAppSettingModel> userAppSetting;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // userAppSetting = ref.watch(appSettingsApiProvider);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    // final loc = ref.watch(changeLocaleProvider);
    final indexOfCurrency = ref.watch(indexOfSelectedCurrency);
    final indexOfLanguage = ref.watch(indexOfSelectedLanguage);
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          child: SizedBox(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.sp),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 46.sp,
                        ),
                        Text(
                          localization.personalize_your_experience,
                          style: AppTheme.lightTheme.textTheme.bodyLarge
                              ?.copyWith(
                                  fontSize: 20.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8.0.sp,
                        ),
                        Text(
                          localization.confirm_preferences,
                          textAlign: TextAlign.center,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 40.sp,
                        ),
                        // // Language Container
                        // Container(
                        //   width: ScreenUtil().screenWidth,
                        //   // height: ScreenUtil().setHeight(224),
                        //   decoration: ShapeDecoration(
                        //     color: AppTheme.appBarAndBottomBarColor,
                        //     shape: RoundedRectangleBorder(
                        //       side: BorderSide(
                        //           width: 1, color: AppTheme.strokeColor),
                        //       borderRadius: BorderRadius.circular(10.sp),
                        //     ),
                        //   ),
                        //   child: Padding(
                        //     padding: EdgeInsets.only(
                        //         left: 16.0.sp,
                        //         right: 16.sp,
                        //         top: 21.sp,
                        //         bottom: 30.sp),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           localization.choose_language,
                        //           style: AppTheme
                        //               .lightTheme.textTheme.labelMedium
                        //               ?.copyWith(fontWeight: FontWeight.w600),
                        //         ),
                        //         ConstantMethods.sidemenuItem(
                        //             "${Constants.imagePathAppSettings}israel.svg",
                        //             "עִברִית",
                        //             subtitle: "Hebrew", onTap: () {
                        //           ref
                        //               .read(indexOfSelectedLanguage.notifier)
                        //               .state = 0;
                        //           // ref
                        //           //     .read(changeLocaleProvider.notifier)
                        //           //     .set(Locale("he"));
                        //         },
                        //             trailing: indexOfLanguage == 0
                        //                 ? Icon(
                        //                     Icons.check,
                        //                     color: AppTheme.primaryColor,
                        //                   )
                        //                 : SizedBox()),
                        //         ConstantMethods.customDivider(),
                        //         // SizedBox(
                        //         //   height: 8.sp,
                        //         // ),
                        //         ConstantMethods.sidemenuItem(
                        //             "${Constants.imagePathAppSettings}us.svg",
                        //             "English (United State)",
                        //             subtitle: "English (United State)",
                        //             onTap: () {
                        //           // ref
                        //           //     .read(changeLocaleProvider.notifier)
                        //           //     .set(Locale("en"));
                        //           ref
                        //               .read(indexOfSelectedLanguage.notifier)
                        //               .state = 1;
                        //         },
                        //             trailing: indexOfLanguage == 1
                        //                 ? Icon(
                        //                     Icons.check,
                        //                     color: AppTheme.primaryColor,
                        //                   )
                        //                 : SizedBox()),
                        //         ConstantMethods.customDivider(),
                        //         // SizedBox(
                        //         //   height: 8.sp,
                        //         // ),
                        //         ConstantMethods.sidemenuItem(
                        //             "${Constants.imagePathAppSettings}spain.svg",
                        //             "Español",
                        //             subtitle: "Spanish", onTap: () {
                        //           ref
                        //               .read(indexOfSelectedLanguage.notifier)
                        //               .state = 2;
                        //         },
                        //             trailing: indexOfLanguage == 2
                        //                 ? Icon(
                        //                     Icons.check,
                        //                     color: AppTheme.primaryColor,
                        //                   )
                        //                 : SizedBox()),
                        //         ConstantMethods.customDivider()
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 14.sp,
                        // ),
                        // Currency Container
                        Container(
                          width: ScreenUtil().screenWidth,
                          decoration: ShapeDecoration(
                            color: AppTheme.appBarAndBottomBarColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppTheme.strokeColor),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0.sp,
                                right: 16.sp,
                                top: 21.sp,
                                bottom: 30.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localization.select_currency,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                ConstantMethods.sidemenuItem(
                                    "${Constants.imagePathAppSettings}usd.svg",
                                    "USD", onTap: () {
                                  ref
                                      .read(indexOfSelectedCurrency.notifier)
                                      .state = 0;
                                  // ref
                                  //     .read(changeLocaleProvider.notifier)
                                  //     .set(Locale("he"));
                                },
                                    trailing: indexOfCurrency == 0
                                        ? Icon(
                                            Icons.check,
                                            color: AppTheme.primaryColor,
                                          )
                                        : SizedBox()),
                                ConstantMethods.customDivider(),
                                ConstantMethods.sidemenuItem(
                                    "${Constants.imagePathAppSettings}shekel.svg",
                                    "Shekel", onTap: () {
                                  // ref
                                  //     .read(changeLocaleProvider.notifier)
                                  //     .set(Locale("en"));
                                  ref
                                      .read(indexOfSelectedCurrency.notifier)
                                      .state = 1;
                                },
                                    trailing: indexOfCurrency == 1
                                        ? Icon(
                                            Icons.check,
                                            color: AppTheme.primaryColor,
                                          )
                                        : SizedBox()),
                                ConstantMethods.customDivider(),
                                ConstantMethods.sidemenuItem(
                                    "${Constants.imagePathAppSettings}rupee.svg",
                                    "Rupee", onTap: () {
                                  ref
                                      .read(indexOfSelectedCurrency.notifier)
                                      .state = 2;
                                },
                                    trailing: indexOfCurrency == 2
                                        ? Icon(
                                            Icons.check,
                                            color: AppTheme.primaryColor,
                                          )
                                        : SizedBox()),
                                ConstantMethods.customDivider()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80.sp,
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      String userId = await SecureStorage.get("user_id") ?? "";

                      ref
                          .read(setAppSettingsApiProvider(SetAppSettingParams(
                                  country: "Israel",
                                  currency: indexOfCurrency == 0
                                      ? "USD"
                                      : indexOfCurrency == 1
                                          ? "ILS"
                                          : "INR",
                                  lang: "en",
                                  // indexOfLanguage == 1
                                  //     ? "en"
                                  //     : indexOfLanguage == 0
                                  //         ? "he"
                                  //         : "es",
                                  userId: userId))
                              .future)
                          .then(
                        (model) {
                          if (model.statusCode == 200) {
                            // if (model.data != null) {
                            ConstantMethods.showAlertBottomSheet(
                                context: context,
                                title: model.message ?? "",
                                message:
                                    "Please wait you will be redirect to \nthe home page.",
                                icon:
                                    "${Constants.imagePathAuth}success_new.svg",
                                isLoading: true);
                            Future.delayed(Duration(seconds: 3)).then(
                              (value) async {
                                await SecureStorage.save(
                                    Constants.isAppSettingsDone, "true");
                                ref
                                    .read(changeLocaleProvider.notifier)
                                    .set(Locale("en"
                                        // indexOfLanguage == 1
                                        //   ? "en"
                                        //   : indexOfLanguage == 0
                                        //       ? "he"
                                        //       : "es"
                                        ));
                                context.go("/dashboard");
                              },
                            );
                            // }
                            ref.read(isLoadingProvider.notifier).state = false;
                          } else {
                            ConstantMethods.showAlertBottomSheet(
                                context: context,
                                title: "Failed",
                                message: model.message ?? "",
                                icon:
                                    "${Constants.imagePathAuth}failed_new.svg");
                            ref.read(isLoadingProvider.notifier).state = false;
                          }
                        },
                      ).catchError((onError) {
                        ConstantMethods.showSnackbar(
                            context, onError.toString());
                        ref.read(isLoadingProvider.notifier).state = false;
                      });
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(60.sp),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Center(
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
                          child: Center(
                            child: Text(
                              localization.save_preferences,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                      color: AppTheme.appBarAndBottomBarColor,
                                      fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final indexOfSelectedLanguage = StateProvider<int>((ref) {
  return 1;
});

final indexOfSelectedCurrency = StateProvider<int>((ref) {
  return 0;
});

class SetAppSettingParams {
  String? lang;
  String? currency;
  String? country;
  String? userId;
  SetAppSettingParams({this.lang, this.country, this.currency, this.userId});
}
