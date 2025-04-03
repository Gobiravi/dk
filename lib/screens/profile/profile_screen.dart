import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/profile/zodiac_sign_screen.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyProfileScreen extends HookConsumerWidget {
  MyProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final fNameProvider = ref.watch(firstNameProviderProfile);
    final lNameProvider = ref.watch(lastNameProviderProfile);
    final emailProviderValid = ref.watch(emailValidProviderProfile);
    final selectedCountry = ref.watch(selectedCountryProviderProfile);
    final phoneProviderValid = ref.watch(phoneValidProviderProfile);
    final indexOfGender = ref.watch(indexOfGenderProvider);
    final userProfile = ref.watch(getUserProfileApiProvider);
    final fNameController = useTextEditingController();
    final lNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final dobController = useTextEditingController();
    final selectedZodiac = ref.watch(selectedZodiacProvider);

    useEffect(() {
      Future.microtask(() {
        return ref.invalidate(getUserProfileApiProvider); // Force refresh API
      });
      return null;
    }, []);
    // Update controllers when API data is loaded
    useEffect(() {
      userProfile.whenData((profile) {
        // Update only if the new data is different from the current text
        if (fNameController.text.isEmpty ||
            fNameController.text != profile.data?.firstName) {
          fNameController.text = profile.data?.firstName ?? "";
        }
        if (lNameController.text.isEmpty ||
            lNameController.text != profile.data?.lastName) {
          lNameController.text = profile.data?.lastName ?? "";
        }
        if (phoneController.text.isEmpty ||
            phoneController.text != profile.data?.phoneNumber) {
          phoneController.text = profile.data?.phoneNumber ?? "";
        }
        if (emailController.text.isEmpty ||
            emailController.text != profile.data?.email) {
          emailController.text = profile.data?.email ?? "";
        }
        if (dobController.text.isEmpty ||
            dobController.text != profile.data?.dateOfBirth) {
          dobController.text = profile.data?.dateOfBirth ?? "";
        }

        Future.microtask(
          () {
            ref.read(dobProvider.notifier).state =
                profile.data?.dateOfBirth ?? "";
            ref.read(indexOfGenderProvider.notifier).state =
                profile.data?.gender == "male"
                    ? 0
                    : profile.data?.gender == "female"
                        ? 1
                        : 2;
            if (profile.data?.zodiacSign != null &&
                profile.data!.zodiacSign!.isNotEmpty) {
              ref.read(selectedZodiacProvider.notifier).state = ZodiacSignModel(
                  name: profile.data?.zodiacSign ?? "",
                  dateRange: "",
                  imagePath:
                      "${Constants.imagePathZodiacSign}${profile.data?.zodiacSign?.toLowerCase()}.svg");
            }
            ref.read(selectedCountryProviderProfile.notifier).state =
                CountryCode(
                    name: profile.data?.countryName ?? "",
                    code: profile.data?.countryCode ?? "",
                    dialCode: profile.data?.dialCode ?? "");
          },
        );
      });
      return null;
    }, [userProfile.value]);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
          title: Text(
            localization.profile_details,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              fontSize: 17.sp,
              color: AppTheme.textColor,
              letterSpacing: -0.45,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: userProfile.when(
          data: (data) {
            switch (data.status) {
              case true:
                return SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 22.h,
                            ),
                            Text(localization.contact_informatiom,
                                style: AppTheme.lightTheme.textTheme.bodyLarge),
                            SizedBox(
                              height: 19.h,
                            ),
                            Form(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  cursorColor: AppTheme.cursorColor,
                                  cursorWidth: 1.0,
                                  cursorHeight: 18.h,
                                  controller: fNameController,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      label: RichText(
                                        text: TextSpan(
                                          text: 'First Name',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme
                                                      .teritiaryTextColor),
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 11.sp,
                                                      color:
                                                          AppTheme.errorBorder),
                                            ),
                                          ],
                                        ),
                                      ),
                                      suffixIcon:
                                          ref.watch(firstNameValidProviderProfile)
                                              ? Icon(Icons.check,
                                                  color: AppTheme.primaryColor)
                                              : SizedBox(),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: fNameProvider.isNotEmpty
                                                  ? AppTheme.primaryColor
                                                  : AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      errorBorder:
                                          OutlineInputBorder(borderSide: BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                                      errorStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                                      fillColor: AppTheme.appBarAndBottomBarColor),
                                  onChanged: (value) {
                                    ref
                                        .read(firstNameProviderProfile.notifier)
                                        .state = value;
                                    if (value.trim().isNotEmpty) {
                                      ref
                                          .read(firstNameValidProviderProfile
                                              .notifier)
                                          .state = true;
                                    } else {
                                      ref
                                          .read(firstNameValidProviderProfile
                                              .notifier)
                                          .state = false;
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'First name is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  cursorColor: AppTheme.cursorColor,
                                  cursorWidth: 1.0,
                                  cursorHeight: 18.h,
                                  controller: lNameController,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      label: RichText(
                                        text: TextSpan(
                                          text: 'Last Name',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme
                                                      .teritiaryTextColor),
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 11.sp,
                                                      color:
                                                          AppTheme.errorBorder),
                                            ),
                                          ],
                                        ),
                                      ),
                                      suffixIcon:
                                          ref.watch(lastNameValidProviderProfile)
                                              ? Icon(Icons.check,
                                                  color: AppTheme.primaryColor)
                                              : SizedBox(),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lNameProvider.isNotEmpty
                                                  ? AppTheme.primaryColor
                                                  : AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      errorBorder:
                                          OutlineInputBorder(borderSide: BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                                      errorStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                                      fillColor: AppTheme.appBarAndBottomBarColor),
                                  onChanged: (value) {
                                    ref
                                        .read(lastNameProviderProfile.notifier)
                                        .state = value;
                                    // Update validation state dynamically
                                    ref
                                        .read(lastNameValidProviderProfile
                                            .notifier)
                                        .state = value.trim().isNotEmpty;
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Last name is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  enabled: false,
                                  cursorColor: AppTheme.cursorColor,
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  cursorWidth: 1.0,
                                  cursorHeight: 18.h,
                                  controller: emailController,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      label: RichText(
                                        text: TextSpan(
                                          text: 'Email',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme
                                                      .teritiaryTextColor),
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 11.sp,
                                                      color:
                                                          AppTheme.errorBorder),
                                            ),
                                          ],
                                        ),
                                      ),
                                      suffixIcon: ref.watch(emailValidProviderProfile)
                                          ? Icon(Icons.check,
                                              color: AppTheme.primaryColor)
                                          : SizedBox(),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: emailProviderValid
                                                  ? AppTheme.primaryColor
                                                  : AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.errorBorder,
                                              width: 1.0)),
                                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                                      errorStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                                      fillColor: AppTheme.appBarAndBottomBarColor),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    ref
                                        .read(emailProviderProfile.notifier)
                                        .state = value;
                                    // Update validation state dynamically
                                    final emailRegex = RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                    ref
                                        .read(
                                            emailValidProviderProfile.notifier)
                                        .state = emailRegex.hasMatch(value);
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Email is required';
                                    }
                                    final emailRegex = RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Enter a valid email Address';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  cursorColor: AppTheme.cursorColor,
                                  cursorWidth: 1.0,
                                  cursorHeight: 18.h,
                                  controller: phoneController,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      label: RichText(
                                        text: TextSpan(
                                          text: 'Phone',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 11.sp,
                                                      color:
                                                          AppTheme.errorBorder),
                                            ),
                                          ],
                                        ),
                                      ),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.sp, right: 4.sp),
                                        child: InkWell(
                                          onTap: () async {
                                            final code =
                                                await const FlCountryCodePicker()
                                                    .showPicker(
                                              context: context,
                                            );
                                            if (code != null) {
                                              ref
                                                  .read(
                                                      selectedCountryProviderProfile
                                                          .notifier)
                                                  .state = code;
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                selectedCountry.dialCode,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'Noto Sans Hebrew',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.43,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Container(
                                                width: 1.0,
                                                height: 15.h,
                                                color: AppTheme.cursorColor,
                                              ),
                                              SizedBox(
                                                width: 9.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      suffixIcon: phoneProviderValid
                                          ? Icon(Icons.check,
                                              color: AppTheme.primaryColor)
                                          : SizedBox(),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: phoneProviderValid
                                                  ? AppTheme.primaryColor
                                                  : AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.errorBorder,
                                              width: 1.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.errorBorder,
                                              width: 1.0)),
                                      errorStyle: AppTheme
                                          .lightTheme.textTheme.bodyLarge
                                          ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                                      fillColor: AppTheme.appBarAndBottomBarColor),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    ref
                                        .read(phoneProviderProfile.notifier)
                                        .state = value;
                                    // Update validation state dynamically
                                    final phoneRegex = RegExp(
                                        r'^\d{10}$'); // Example: 10-digit phone number
                                    ref
                                        .read(
                                            phoneValidProviderProfile.notifier)
                                        .state = phoneRegex.hasMatch(value);
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Phone number is required';
                                    }
                                    final phoneRegex = RegExp(r'^\d{10}$');
                                    if (!phoneRegex.hasMatch(value)) {
                                      return 'Enter a valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Text(localization.personal_informatiom,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyLarge),
                                SizedBox(
                                  height: 16.h,
                                ),
                                dobField(ref, context),
                                SizedBox(
                                  height: 26.h,
                                ),
                                Text(
                                  'Gender',
                                  style: AppTheme
                                      .lightTheme.textTheme.headlineLarge
                                      ?.copyWith(
                                          fontSize: 15.sp,
                                          color: AppTheme.subTextColor),
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        ref
                                            .read(
                                                indexOfGenderProvider.notifier)
                                            .state = 0;
                                      },
                                      child: Container(
                                        height: 36.h,
                                        decoration: ShapeDecoration(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: indexOfGender == 0
                                                    ? AppTheme.primaryColor
                                                    : AppTheme.strokeColor),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18.0.w),
                                            child: Text(
                                              'Male',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                      fontSize: 15.sp,
                                                      color: indexOfGender == 0
                                                          ? AppTheme
                                                              .primaryColor
                                                          : AppTheme
                                                              .subTextColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 9.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ref
                                            .read(
                                                indexOfGenderProvider.notifier)
                                            .state = 1;
                                      },
                                      child: Container(
                                        // width: 72.90,
                                        height: 36.h,
                                        decoration: ShapeDecoration(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: indexOfGender == 1
                                                    ? AppTheme.primaryColor
                                                    : AppTheme.strokeColor),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18.0.w),
                                            child: Text(
                                              'Female',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                      fontSize: 15.sp,
                                                      color: indexOfGender == 1
                                                          ? AppTheme
                                                              .primaryColor
                                                          : AppTheme
                                                              .subTextColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 9.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ref
                                            .read(
                                                indexOfGenderProvider.notifier)
                                            .state = 2;
                                      },
                                      child: Container(
                                        // width: 72.90,
                                        height: 36.h,
                                        decoration: ShapeDecoration(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: indexOfGender == 2
                                                    ? AppTheme.primaryColor
                                                    : AppTheme.strokeColor),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18.0.w),
                                            child: Text(
                                              'Other',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: indexOfGender == 2
                                                          ? AppTheme
                                                              .primaryColor
                                                          : AppTheme
                                                              .subTextColor,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Text(
                                  'Zodiac Sign',
                                  style: AppTheme
                                      .lightTheme.textTheme.headlineLarge
                                      ?.copyWith(
                                          fontSize: 15.sp,
                                          color: AppTheme.subTextColor),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    context.push("/zodiac_screen");
                                  },
                                  child: Container(
                                    width: ScreenUtil().screenWidth,
                                    height: 50.h,
                                    decoration: ShapeDecoration(
                                      color: AppTheme.appBarAndBottomBarColor,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1,
                                            color: AppTheme.strokeColor),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Click to select your Zodiac Sign',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.lightTheme
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                fontSize: 15.sp,
                                                color: AppTheme.textColor,
                                              )),
                                          Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: AppTheme.subTextColor,
                                            size: 16.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                selectedZodiac != null
                                    ? Container(
                                        width: ScreenUtil().screenWidth,
                                        decoration: ShapeDecoration(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              color: AppTheme.strokeColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.w,
                                              top: 18.h,
                                              right: 16.w,
                                              bottom: 22.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 68.w,
                                                    height: 73.h,
                                                    decoration: ShapeDecoration(
                                                      color: AppTheme
                                                          .appBarAndBottomBarColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          width: 1,
                                                          color: AppTheme
                                                              .strokeColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.r),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        selectedZodiac
                                                            .imagePath,
                                                        height: 44.h,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 17.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(selectedZodiac.name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: AppTheme
                                                              .lightTheme
                                                              .textTheme
                                                              .labelMedium
                                                              ?.copyWith(
                                                                  color: AppTheme
                                                                      .subTextColor)),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                                .screenWidth *
                                                            0.5,
                                                        child: Text(
                                                          data.data
                                                                  ?.todayHoroscope ??
                                                              'Today is a great day for new beginnings. Your innovative ideas will be well-received.',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTheme
                                                              .lightTheme
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  color: AppTheme
                                                                      .textColor,
                                                                  fontSize:
                                                                      11.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 31.h,
                                ),
                                Container(
                                  width: ScreenUtil().screenWidth,
                                  decoration: ShapeDecoration(
                                    color: AppTheme.appBarAndBottomBarColor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: AppTheme.strokeColor),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password',
                                          style: AppTheme
                                              .lightTheme.textTheme.labelMedium
                                              ?.copyWith(
                                                  fontSize: 15.sp,
                                                  color: AppTheme.subTextColor),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                            'Follow the prompts to update your credentials securely.',
                                            style: AppTheme.lightTheme.textTheme
                                                .bodySmall),
                                        SizedBox(
                                          height: 17.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context.push("/forgotPassword",
                                                extra: false);
                                          },
                                          child: Text(
                                            'Change Password',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color:
                                                        AppTheme.primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Container(
                                  width: ScreenUtil().screenWidth,
                                  decoration: ShapeDecoration(
                                    color: AppTheme.appBarAndBottomBarColor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: AppTheme.strokeColor),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Delete Account',
                                          style: AppTheme
                                              .lightTheme.textTheme.labelMedium
                                              ?.copyWith(
                                                  fontSize: 15.sp,
                                                  color: AppTheme.subTextColor),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                            'NOTE: Account will NOT BE RECOVERABLE once deleted',
                                            style: AppTheme.lightTheme.textTheme
                                                .bodySmall),
                                        SizedBox(
                                          height: 17.h,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            'Confirm',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color:
                                                        AppTheme.primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 28.h,
                                ),
                              ],
                            )),
                            SizedBox(
                              height: 40.h,
                            )
                          ],
                        ),
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(updateProfileApiProvider(
                                        UpdateProfileParams(
                                            firstName: fNameController.text,
                                            lastName: lNameController.text,
                                            phone: phoneController.text,
                                            dob: dobController.text,
                                            countryName: selectedCountry.name,
                                            countryCode: selectedCountry.code,
                                            dialCode: selectedCountry.dialCode,
                                            zodiac: selectedZodiac?.name ?? "",
                                            gender: indexOfGender == 0
                                                ? "male"
                                                : indexOfGender == 1
                                                    ? "female"
                                                    : "other"))
                                    .future)
                                .then((onValue) async {
                              if (context.mounted) {
                                if (onValue.statusCode != 402) {
                                  if (onValue.status!) {
                                    context.pop();
                                    ConstantMethods.showSnackbar(
                                      context,
                                      onValue.message ?? "",
                                    );
                                  } else {
                                    ConstantMethods.showSnackbar(
                                        context, onValue.message ?? "",
                                        isFalse: true);
                                  }
                                } else {
                                  await ApiUtils.refreshToken();
                                  ConstantMethods.showSnackbar(
                                      context, "please try again",
                                      isFalse: true);
                                }
                              }
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
                                    localization.save_changes,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: AppTheme
                                                .appBarAndBottomBarColor,
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
                );
              case false:
                if (data.statusCode == 402) {
                  refreshApi(ref);
                }
                return ConstantMethods.buildErrorUI(
                  ref,
                  onPressed: () {
                    refreshApi(ref);
                  },
                );
              default:
                return SizedBox();
            }
          },
          error: (error, stackTrace) {
            return ConstantMethods.buildErrorUI(
              ref,
              onPressed: () {
                refreshApi(ref);
              },
            );
          },
          loading: () {
            final spinkit = SpinKitPumpingHeart(
              color: AppTheme.appBarAndBottomBarColor,
              size: ScreenUtil().setHeight(50),
            );
            return Center(child: spinkit);
          },
        ));
  }

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(getUserProfileApiProvider);
  }

  Widget dobField(WidgetRef ref, BuildContext context) {
    final selectedDOB = ref.watch(dobProvider);
    return TextFormField(
      readOnly: true,
      cursorColor: AppTheme.cursorColor,
      cursorWidth: 1.0,
      cursorHeight: 18.h,
      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: 'Date of Birth',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: '*',
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: 11.sp,
                  color: AppTheme.errorBorder,
                ),
              ),
            ],
          ),
        ),
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.textColor,
          size: 16.h,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.strokeColor, width: 1.0),
          borderRadius: BorderRadius.circular(8.sp),
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(8.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.strokeColor, width: 1.0),
          borderRadius: BorderRadius.circular(8.sp),
        ),
        fillColor: AppTheme.appBarAndBottomBarColor,
      ),
      controller: TextEditingController(text: selectedDOB ?? ""),
      onTap: () async {
        FocusScope.of(context).unfocus();
        final pickedDate = await _showDatePicker(context, ref);
        if (pickedDate != null) {
          ref.read(dobProvider.notifier).state =
              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        }
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Date of Birth is required';
        }
        return null;
      },
    );
  }

  final dobProvider = StateProvider<String?>((ref) => null);

  /// Function to show Cupertino-style spinning wheel date picker inside a modal
  Future<DateTime?> _showDatePicker(BuildContext context, WidgetRef ref) async {
    DateTime selectedDate = DateTime.now().subtract(Duration(days: 365 * 18));
    DateTime? pickedDate = selectedDate;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext builder) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header with title and close button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.transparent),
                      onPressed: () {},
                    ),
                    Text(
                      'Set Date of Birth',
                      style: AppTheme.lightTheme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.close_outlined, color: AppTheme.textColor),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),

              /// Date Picker
              SizedBox(
                height: 220.h,
                width: ScreenUtil().screenWidth,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  itemExtent: 50.h,
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1930),
                  onDateTimeChanged: (DateTime date) {
                    pickedDate = date;
                  },
                ),
              ),

              SizedBox(
                height: 38.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),

              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    minimumSize: Size(double.infinity, 44.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    ref.read(dobProvider.notifier).state =
                        "${pickedDate!.day} ${pickedDate!.month} ${pickedDate!.year}";
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return pickedDate;
  }
}

final indexOfGenderProvider = StateProvider<int>((ref) {
  return 4;
});
