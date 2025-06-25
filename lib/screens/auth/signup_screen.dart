import 'dart:io';

import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/loading_overlay.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/model/auth/login_model.dart';
import 'package:dikla_spirit/model/auth/signup_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupScreen extends StatefulHookConsumerWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final passwordVisible = ref.watch(passwordVisibilityProvider);
    final confirmPasswordVisible = ref.watch(confirmPasswordVisibilityProvider);
    final fNameProvider = ref.watch(firstNameProvider);
    final lNameProvider = ref.watch(lastNameProvider);
    final emailProviderValid = ref.watch(emailValidProvider);
    final phoneProviderValid = ref.watch(phoneValidProvider);
    return Scaffold(
      body: LoadingOverlay(
          child: SafeArea(
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 26.sp,
                    ),
                    Text(
                      'DIKLA SPIRIT',
                      textAlign: TextAlign.center,
                      style: AppTheme.lightTheme.textTheme.titleLarge
                          ?.copyWith(letterSpacing: -0.56),
                    ),
                    SizedBox(
                      height: 16.sp,
                    ),
                    Text(
                      'Create an Account',
                      style: AppTheme.lightTheme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Text(
                      'Let’s get you started on your journey of \nlove, magic, and blessings.',
                      textAlign: TextAlign.center,
                      style: AppTheme.lightTheme.textTheme.bodySmall
                          ?.copyWith(letterSpacing: 0.20, fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
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
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '*',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  fontSize: 11.sp,
                                                  color: AppTheme.errorBorder),
                                        ),
                                      ],
                                    ),
                                  ),
                                  suffixIcon: ref.watch(firstNameValidProvider)
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
                                      ?.copyWith(
                                          color: AppTheme.errorBorder,
                                          fontSize: 11.sp),
                                  fillColor: AppTheme.appBarAndBottomBarColor),
                              onChanged: (value) {
                                ref.read(firstNameProvider.notifier).state =
                                    value;
                                if (value.trim().isNotEmpty) {
                                  ref
                                      .read(firstNameValidProvider.notifier)
                                      .state = true;
                                } else {
                                  ref
                                      .read(firstNameValidProvider.notifier)
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
                            SizedBox(height: 16.0),
                            TextFormField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
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
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '*',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  fontSize: 11.sp,
                                                  color: AppTheme.errorBorder),
                                        ),
                                      ],
                                    ),
                                  ),
                                  suffixIcon: ref.watch(lastNameValidProvider)
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
                                      ?.copyWith(
                                          color: AppTheme.errorBorder,
                                          fontSize: 11.sp),
                                  fillColor: AppTheme.appBarAndBottomBarColor),
                              onChanged: (value) {
                                ref.read(lastNameProvider.notifier).state =
                                    value;
                                // Update validation state dynamically
                                ref.read(lastNameValidProvider.notifier).state =
                                    value.trim().isNotEmpty;
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Last name is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
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
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '*',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  fontSize: 11.sp,
                                                  color: AppTheme.errorBorder),
                                        ),
                                      ],
                                    ),
                                  ),
                                  suffixIcon: ref.watch(emailValidProvider)
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
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.errorBorder,
                                          width: 1.0)),
                                  errorStyle: AppTheme
                                      .lightTheme.textTheme.bodyLarge
                                      ?.copyWith(
                                          color: AppTheme.errorBorder,
                                          fontSize: 11.sp),
                                  fillColor: AppTheme.appBarAndBottomBarColor),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                ref.read(emailProvider.notifier).state = value;
                                // Update validation state dynamically
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                ref.read(emailValidProvider.notifier).state =
                                    emailRegex.hasMatch(value);
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email is required';
                                }
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Phone Number',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '*',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  fontSize: 11.sp,
                                                  color: AppTheme.errorBorder),
                                        ),
                                      ],
                                    ),
                                  ),
                                  suffixIcon: ref.watch(phoneValidProvider)
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
                                      ?.copyWith(
                                          color: AppTheme.errorBorder,
                                          fontSize: 11.sp),
                                  fillColor: AppTheme.appBarAndBottomBarColor),
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                ref.read(phoneProvider.notifier).state = value;
                                // Update validation state dynamically
                                final phoneRegex = RegExp(
                                    r'^\d{10}$'); // Example: 10-digit phone number
                                ref.read(phoneValidProvider.notifier).state =
                                    phoneRegex.hasMatch(value);
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
                            SizedBox(height: 16.0),
                            TextFormField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Password',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontSize: 11.sp,
                                                color: AppTheme.errorBorder),
                                      ),
                                    ],
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
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
                                    ?.copyWith(
                                        color: AppTheme.errorBorder,
                                        fontSize: 11.sp),
                                fillColor: AppTheme.appBarAndBottomBarColor,
                                suffixIcon: IconButton(
                                  icon: passwordVisible
                                      ? SvgPicture.asset(
                                          "${Constants.imagePathAuth}pass_visible.svg")
                                      : SvgPicture.asset(
                                          "${Constants.imagePathAuth}pass_hide.svg"),
                                  onPressed: () {
                                    ref
                                        .read(
                                            passwordVisibilityProvider.notifier)
                                        .state = !passwordVisible;
                                  },
                                ),
                              ),
                              obscureText: !passwordVisible,
                              onChanged: (value) {
                                ref.read(passwordProvider.notifier).state =
                                    value;

                                // Real-time validation for password
                                final isValidPassword = value.length >=
                                    8; // Example: At least 8 characters
                                ref.read(passwordValidProvider.notifier).state =
                                    isValidPassword;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: confirmPasswordVisible
                                        ? SvgPicture.asset(
                                            "${Constants.imagePathAuth}pass_visible.svg")
                                        : SvgPicture.asset(
                                            "${Constants.imagePathAuth}pass_hide.svg"),
                                    onPressed: () {
                                      ref
                                          .read(
                                              confirmPasswordVisibilityProvider
                                                  .notifier)
                                          .state = !confirmPasswordVisible;
                                    },
                                  ),
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Confirm Password',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '*',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  fontSize: 11.sp,
                                                  color: AppTheme.errorBorder),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                          color: AppTheme.strokeColor,
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
                                      ?.copyWith(
                                          color: AppTheme.errorBorder,
                                          fontSize: 11.sp),
                                  fillColor: AppTheme.appBarAndBottomBarColor),
                              obscureText: !confirmPasswordVisible,
                              onChanged: (value) {
                                ref
                                    .read(confirmPasswordProvider.notifier)
                                    .state = value;

                                // Real-time validation for matching passwords
                                final isValidConfirmPassword = value ==
                                    ref.read(
                                        passwordProvider); // Match with password
                                ref
                                    .read(confirmPasswordValidProvider.notifier)
                                    .state = isValidConfirmPassword;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Password is required';
                                }
                                if (value != ref.read(passwordProvider)) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              height: 1.sp,
                              color: AppTheme.strokeColor,
                            ),
                          ),
                          SizedBox(
                            width: 16.sp,
                          ),
                          Text(
                            'Or Register with',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 16.sp,
                          ),
                          Flexible(
                            child: Container(
                              height: 1.sp,
                              color: AppTheme.strokeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Platform.isAndroid
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                            child: SizedBox(
                              height: 44.sp,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 1.0,
                                      backgroundColor: AppTheme.appBgColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.sp),
                                          side: BorderSide(
                                              color: AppTheme.subTextColor))),
                                  onPressed: () {
                                    ConstantMethods.signInWithFacebook(ref);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        "${Constants.imagePathAuth}fb.svg",
                                        height: 16.sp,
                                      ),
                                      Text(
                                        'Continue with Facebook',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall
                                            ?.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppTheme.socialTextColor,
                                                letterSpacing: 0.20),
                                      ),
                                      SizedBox(
                                        width: 16.sp,
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                            child: SizedBox(
                              height: 44.sp,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 1.0,
                                      backgroundColor: AppTheme.appBgColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.sp),
                                          side: BorderSide(
                                              color: AppTheme.subTextColor))),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        "${Constants.imagePathAuth}apple.svg",
                                        height: 20.sp,
                                      ),
                                      Text(
                                        'Continue with Apple',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall
                                            ?.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppTheme.socialTextColor,
                                                letterSpacing: 0.20),
                                      ),
                                      SizedBox(
                                        height: 20.sp,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                    SizedBox(
                      height: 16.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                      child: SizedBox(
                        height: 44.sp,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 1.0,
                                backgroundColor: AppTheme.appBgColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.sp),
                                    side: BorderSide(
                                        color: AppTheme.subTextColor))),
                            onPressed: () {
                              ConstantMethods.googleSignIn(ref);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  "${Constants.imagePathAuth}google.svg",
                                  height: 18.sp,
                                ),
                                Text(
                                  'Continue with Google',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.socialTextColor,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                                SizedBox(
                                  height: 18.sp,
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 28.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 75.0.sp),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'By clicking the Sign Up button, you agree to the',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: ' Term & Condition',
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            TextSpan(
                              text: ' and',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: ' Privacy Policy.',
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.sp,
                    ),
                    ConstantMethods.customDivider(),
                    SizedBox(
                      height: 24.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already Have Account?',
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: AppTheme.subTextColor),
                            ),
                            TextSpan(
                              text: ' ',
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: AppTheme.subTextColor),
                            ),
                            TextSpan(
                                text: 'Log In',
                                style: AppTheme.lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    resetProviders();
                                    context.go("/login");
                                  }),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 88.sp,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: ScreenUtil().screenWidth,
                  height: 67.sp,
                  decoration: ShapeDecoration(
                    color: AppTheme.appBarAndBottomBarColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.sp),
                        topRight: Radius.circular(12.sp),
                      ),
                    ),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _submitForm(context, ref);
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
                        child: Center(
                          child: Text(
                            "Sign up",
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
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submitForm(BuildContext context, WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      ref.read(isLoadingProvider.notifier).state = true;
      final firstName = ref.read(firstNameProvider);
      final lastName = ref.read(lastNameProvider);
      final email = ref.read(emailProvider);
      final phone = ref.read(phoneProvider);
      final password = ref.read(passwordProvider);
      final cpassword = ref.read(confirmPasswordProvider);

      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Email: $email');
      print('Phone: $phone');
      print('Phone: $password');
      print('Phone: $cpassword');

      ref
          .read(signupApiProvider(SignupParams(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  phone: phone,
                  cpassword: cpassword,
                  password: password))
              .future)
          .then((signUpModel) {
        if (signUpModel.status == true) {
          if (signUpModel.data != null) {
            saveSignUpData(signUpModel.data!);
            ConstantMethods.showAlertBottomSheet(
                context: context,
                title: signUpModel.message ?? "",
                message:
                    "Please wait you will be redirect to \nthe login page.",
                icon: "${Constants.imagePathAuth}success.svg",
                isLoading: true);
            Future.delayed(Duration(seconds: 3)).then(
              (value) {
                resetProviders();
                context.go("/login");
              },
            );
          }
          ref.read(isLoadingProvider.notifier).state = false;
        } else {
          ConstantMethods.showAlertBottomSheet(
              context: context,
              title: "Registration Failed",
              message: signUpModel.message ?? "",
              icon: "${Constants.imagePathAuth}failed_new.svg",
              isLoading: true);
          ref.read(isLoadingProvider.notifier).state = false;
        }
      }).catchError((error) {
        ConstantMethods.showSnackbar(context, error.toString());
        ref.read(isLoadingProvider.notifier).state = false;
      });
    }
  }

  resetProviders() {
    ref.read(firstNameProvider.notifier).state = '';
    ref.read(firstNameValidProvider.notifier).state = false;
    ref.read(lastNameProvider.notifier).state = '';
    ref.read(lastNameValidProvider.notifier).state = false;
    ref.read(passwordProvider.notifier).state = '';
    ref.read(passwordValidProvider.notifier).state = false;
    ref.read(emailProvider.notifier).state = '';
    ref.read(emailValidProvider.notifier).state = false;
    ref.read(phoneProvider.notifier).state = '';
    ref.read(phoneValidProvider.notifier).state = false;
  }

  saveSignUpData(SignUpModelData response) async {
    await SecureStorage.save('user_id', response.userId.toString());
  }
}
