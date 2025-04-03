import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/auth/app_settings.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SideMenuScreen extends StatefulHookConsumerWidget {
  const SideMenuScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends ConsumerState<SideMenuScreen> {
  FlCountryCodePicker countryPicker = FlCountryCodePicker(
    title: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select Country',
            style: AppTheme.lightTheme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(selectedCountryProvider);
    final profile = ref.watch(getUserProfileApiProvider);
    final indexOfCurrency = ref.watch(indexOfSelectedCurrency);
    final selectedCurency = ref.watch(currentCurrencySymbolProvider);
    final selectedLang = ref.watch(indexOfSelectedLanguage);
    final appSetting = ref.watch(getAppSettingsApiProvider);
    final localization = AppLocalizations.of(context);
    var userId = "";
    useEffect(
      () {
        appSetting.when(
          data: (data) async {
            Future.microtask(() {
              ref.read(currentCurrencySymbolProvider.notifier).state =
                  CurrencySymbol.fromString(data.data?.currency ?? "").symbol;

              ref.read(indexOfSelectedLanguage.notifier).state =
                  data.data?.language == "en"
                      ? 1
                      : data.data?.language == "ar"
                          ? 0
                          : 2;

              final newCountry = countryPicker.countryCodes.firstWhere(
                (element) =>
                    element.name.toLowerCase() ==
                    data.data?.country?.toLowerCase(),
                orElse: () =>
                    CountryCode(name: "Isreal", code: "", dialCode: ""),
              );

              final currentCountry = ref.read(selectedCountryProvider);

              if (newCountry.name != currentCountry.name) {
                ref.read(selectedCountryProvider.notifier).state = newCountry;
              }
            });

            userId = await SecureStorage.get("user_id") ?? "";
          },
          error: (_, __) => null,
          loading: () => null,
        );

        return null;
      },
    );
    return Scaffold(
      backgroundColor: AppTheme.appBarAndBottomBarColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  height: ScreenUtil().setHeight(180),
                  width: ScreenUtil().screenWidth,
                  decoration: ShapeDecoration(
                    color: AppTheme.strokeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.0.sp, vertical: 12.sp),
                    child: Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: SvgPicture.asset(
                              "${Constants.imagePathHome}menu_close.svg",
                              height: 36.sp,
                            ),
                            onTap: () {
                              // ref
                              //     .read(indexOfBottomNavbarProvider.notifier)
                              //     .state = 0;
                              context.pop();
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16.sp,
                              ),
                              Text("DIKLA SPIRIT",
                                  style: AppTheme
                                      .lightTheme.textTheme.titleLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22.sp,
                                          letterSpacing: -0.66)),
                              SizedBox(
                                height: 16.sp,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.sp,
                                    backgroundColor: AppTheme.pinkDark,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(width: 8.sp),
                                  profile.when(
                                    data: (data) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${localization.hey}, ${data.data?.firstName ?? ""} ${data.data?.lastName ?? ""}",
                                            style: AppTheme.lightTheme.textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontSize: 20.sp,
                                                    color: AppTheme.textColor,
                                                    letterSpacing: -0.60),
                                          ),
                                          Text(localization.welcome,
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                      fontSize: 16.sp,
                                                      color:
                                                          AppTheme.subTextColor,
                                                      letterSpacing: -0.60,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                        ],
                                      );
                                    },
                                    error: (error, stackTrace) => SizedBox(),
                                    loading: () => SizedBox(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Navigation Buttons
                SizedBox(height: 16.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customNavButton(
                      "home.svg",
                      localization.home,
                      onTap: () {
                        context.pop();
                        context.go("/dashboard");
                        ref.read(indexOfBottomNavbarProvider.notifier).state =
                            0;
                      },
                    ),
                    _customNavButton(
                      "order.svg",
                      localization.my_orders,
                      onTap: () {
                        context.pop();
                        context.go("/my_orders");
                      },
                    ),
                    _customNavButton(
                      "support.svg",
                      localization.help_center,
                      onTap: () {
                        context.push("/help_center");
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.sp,
                ),
                // Account Settings Section
                _sectionTitle(localization.myAccount),
                ConstantMethods.sidemenuItem(
                  "${Constants.imagePathMenu}box.svg",
                  localization.shipping_address,
                  onTap: () {
                    context.push("/address_list");
                  },
                ),
                ConstantMethods.customDivider(),
                // ConstantMethods.sidemenuItem(
                //     "${Constants.imagePathMenu}card.svg", "Payment Method"),
                // ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                  "${Constants.imagePathMenu}user.svg",
                  localization.my_profile,
                  onTap: () {
                    context.pushNamed("set_profile_details");
                  },
                ),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                  "${Constants.imagePathMenu}star.svg",
                  localization.my_review,
                  onTap: () {
                    // context.go("/home/our_reviews");
                    context.pushNamed("our_reviews");
                  },
                ),
                ConstantMethods.customDivider(),
                SizedBox(
                  height: 25.sp,
                ),
                // Language & Region Section
                _sectionTitle(localization.language_and_region),
                SizedBox(
                  height: 15.sp,
                ),
                ConstantMethods.sidemenuItem(
                    "${Constants.imagePathMenu}globe.svg",
                    selectedLang == 0
                        ? "עִברִית"
                        : selectedLang == 1
                            ? "English (United State)"
                            : "Español",
                    subtitle: localization.language,
                    subItems: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        trailing: selectedLang == 0
                            ? Icon(
                                Icons.check,
                                color: AppTheme.primaryColor,
                              )
                            : SizedBox(),
                        title: Text(
                          'עִברִית',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          'Hebrew',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppTheme.teritiaryTextColor),
                        ),
                        onTap: () {
                          ref.read(indexOfSelectedLanguage.notifier).state = 0;
                          ref
                              .read(changeLocaleProvider.notifier)
                              .set(Locale("he"));
                          ref
                              .read(setAppSettingsApiProvider(
                                      SetAppSettingParams(
                                          lang: "he", userId: userId))
                                  .future)
                              .then((onValue) {
                            if (context.mounted) {
                              ConstantMethods.showSnackbar(
                                  context, onValue.message ?? "");
                            }
                          });
                        },
                      ),
                      ConstantMethods.customDivider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        trailing: selectedLang == 1
                            ? Icon(
                                Icons.check,
                                color: AppTheme.primaryColor,
                              )
                            : SizedBox(),
                        title: Text(
                          "English (United State)",
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          'English (United State)',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppTheme.teritiaryTextColor),
                        ),
                        onTap: () {
                          ref.read(indexOfSelectedLanguage.notifier).state = 1;
                          ref
                              .read(changeLocaleProvider.notifier)
                              .set(Locale("en"));
                          ref
                              .read(setAppSettingsApiProvider(
                                      SetAppSettingParams(
                                          lang: "en", userId: userId))
                                  .future)
                              .then((onValue) {
                            if (context.mounted) {
                              ConstantMethods.showSnackbar(
                                  context, onValue.message ?? "");
                            }
                          });
                        },
                      ),
                      ConstantMethods.customDivider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        trailing: selectedLang == 2
                            ? Icon(
                                Icons.check,
                                color: AppTheme.primaryColor,
                              )
                            : SizedBox(),
                        title: Text(
                          'Español',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          'Spanish',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppTheme.teritiaryTextColor),
                        ),
                        onTap: () {
                          ref.read(indexOfSelectedLanguage.notifier).state = 2;
                          ref
                              .read(changeLocaleProvider.notifier)
                              .set(Locale("es"));
                          ref
                              .read(setAppSettingsApiProvider(
                                      SetAppSettingParams(
                                          lang: "es", userId: userId))
                                  .future)
                              .then((onValue) {
                            if (context.mounted) {
                              ConstantMethods.showSnackbar(
                                  context, onValue.message ?? "");
                            }
                          });
                        },
                      ),
                    ]),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                    "${Constants.imagePathMenu}currency.svg",
                    "${CurrencySymbol.fromSymbol(selectedCurency).name.toUpperCase()} $selectedCurency",
                    subtitle: localization.currency,
                    subItems: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        leading: SizedBox(
                          width: 32.sp,
                          height: 32.sp,
                          child: SvgPicture.asset(
                            "${Constants.imagePathAppSettings}usd.svg",
                            height: 18.0.sp,
                            width: 18.0.sp,
                            fit: BoxFit.contain,
                          ),
                        ),
                        trailing: indexOfCurrency == 0
                            ? Icon(
                                Icons.check,
                                color: AppTheme.primaryColor,
                              )
                            : SizedBox(),
                        title: Text(
                          "USD",
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(fontSize: 14.sp),
                        ),
                        onTap: () {
                          ref.read(indexOfSelectedCurrency.notifier).state = 0;
                          ref
                              .read(currentCurrencySymbolProvider.notifier)
                              .state = CurrencySymbol.fromString("USD").symbol;
                          ref
                              .read(setAppSettingsApiProvider(
                                      SetAppSettingParams(
                                          currency: "USD", userId: userId))
                                  .future)
                              .then((onValue) {
                            if (context.mounted) {
                              ConstantMethods.showSnackbar(
                                  context, onValue.message ?? "");
                            }
                            return ref.refresh(getAppSettingsApiProvider);
                          });
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        leading: SizedBox(
                          width: 32.sp,
                          height: 32.sp,
                          child: SvgPicture.asset(
                            "${Constants.imagePathAppSettings}shekel.svg",
                            height: 18.0.sp,
                            width: 18.0.sp,
                            fit: BoxFit.contain,
                          ),
                        ),
                        trailing: indexOfCurrency == 1
                            ? Icon(
                                Icons.check,
                                color: AppTheme.primaryColor,
                              )
                            : SizedBox(),
                        title: Text(
                          "Shekel",
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(fontSize: 14.sp),
                        ),
                        onTap: () {
                          ref.read(indexOfSelectedCurrency.notifier).state = 1;
                          ref
                              .read(currentCurrencySymbolProvider.notifier)
                              .state = CurrencySymbol.fromString("ILS").symbol;
                          ref
                              .read(setAppSettingsApiProvider(
                                      SetAppSettingParams(
                                          currency: "ILS", userId: userId))
                                  .future)
                              .then((onValue) {
                            if (context.mounted) {
                              ConstantMethods.showSnackbar(
                                  context, onValue.message ?? "");
                            }
                            return ref.refresh(getAppSettingsApiProvider);
                          });
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        leading: SizedBox(
                          width: 32.sp,
                          height: 32.sp,
                          child: SvgPicture.asset(
                            "${Constants.imagePathAppSettings}rupee.svg",
                            height: 18.0.sp,
                            width: 18.0.sp,
                            fit: BoxFit.contain,
                          ),
                        ),
                        trailing: indexOfCurrency == 2
                            ? Icon(
                                Icons.check,
                                color: AppTheme.primaryColor,
                              )
                            : SizedBox(),
                        title: Text(
                          "Rupee",
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(fontSize: 14.sp),
                        ),
                        onTap: () {
                          ref.read(indexOfSelectedCurrency.notifier).state = 2;
                          ref
                              .read(currentCurrencySymbolProvider.notifier)
                              .state = CurrencySymbol.fromString("INR").symbol;
                          ref
                              .read(setAppSettingsApiProvider(
                                      SetAppSettingParams(
                                          currency: "INR", userId: userId))
                                  .future)
                              .then((onValue) {
                            if (context.mounted) {
                              ConstantMethods.showSnackbar(
                                  context, onValue.message ?? "");
                            }
                            return ref.refresh(getAppSettingsApiProvider);
                          });
                        },
                      ),
                    ]),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                  selectedCountry.flagUri,
                  selectedCountry.name,
                  isCountry: true,
                  package: selectedCountry.flagImagePackage,
                  subtitle: localization.country,
                  onTap: () async {
                    await countryPicker.showPicker(context: context).then(
                      (value) {
                        if (value != null) {
                          ref.read(selectedCountryProvider.notifier).state =
                              value;
                          ref.read(setAppSettingsApiProvider(
                              SetAppSettingParams(
                                  country: value.name, userId: userId)));
                          return ref.refresh(getAppSettingsApiProvider);
                        }
                      },
                    );
                  },
                ),
                ConstantMethods.customDivider(),
                SizedBox(
                  height: 25.sp,
                ),
                // Support Section
                _sectionTitle(localization.support_and_information),
                SizedBox(
                  height: 15.sp,
                ),
                ConstantMethods.sidemenuItem("${Constants.imagePathMenu}qa.svg",
                    localization.quick_qa_with_dikla),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                    "${Constants.imagePathMenu}info.svg",
                    localization.dikla_support_team),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                    "${Constants.imagePathMenu}policy.svg",
                    localization.dikla_promise_of_privacy),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                    "${Constants.imagePathMenu}valid.svg",
                    localization.terms_and_condition),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                    "${Constants.imagePathMenu}qinfo.svg",
                    localization.dikla_my_story),
                ConstantMethods.customDivider(),
                ConstantMethods.sidemenuItem(
                    "${Constants.imagePathMenu}star.svg",
                    localization.dikla_happy_clients),
                ConstantMethods.customDivider(),
                SizedBox(
                  height: 40.sp,
                ),
                // Log Out Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.textColor,
                    foregroundColor: AppTheme.appBarAndBottomBarColor,
                    minimumSize: Size(double.infinity, 50.sp),
                  ),
                  onPressed: () {
                    logout();
                  },
                  child: Text(
                    localization.log_out,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.appBarAndBottomBarColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "${localization.version} 1.0",
                    style: AppTheme.lightTheme.textTheme.bodySmall
                        ?.copyWith(fontSize: 12.sp, letterSpacing: 0.20),
                  ),
                ),
                SizedBox(
                  height: 50.sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    await SecureStorage.clear();
    ProviderContainer container = ProviderContainer();
    print('All data cleared.');
    ref.read(changeLocaleProvider.notifier).set(Locale("en"));
    container.dispose(); // Disposes all providers
    container = ProviderContainer();
    if (mounted) {
      context.go("/login");
    }
  }

  // Custom Widgets
  static Widget _customNavButton(String icon, String title,
      {void Function()? onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: ScreenUtil().screenWidth / 3.5,
            height: ScreenUtil().setHeight(40),
            decoration: ShapeDecoration(
              color: AppTheme.appBarAndBottomBarColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: AppTheme.strokeColor),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Constants.imagePathMenu + icon),
                SizedBox(
                  width: 12.sp,
                ),
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title,
          style: AppTheme.lightTheme.textTheme.labelMedium
              ?.copyWith(fontSize: 13.sp)),
    );
  }
}
