import 'dart:io';

import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/loading_overlay.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/model/auth/login_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String? validatePassword(String? value, WidgetRef ref) {
    if (value == null || value.isEmpty) {
      ref.read(loginPasswordValidProvider.notifier).state = false;
      return 'Password is required';
    }
    if (value.length < 6) {
      ref.read(loginPasswordValidProvider.notifier).state = false;
      return 'Password must be at least 6 characters long';
    }
    ref.read(loginPasswordValidProvider.notifier).state = true;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final passwordVisible = ref.watch(loginpasswordVisibilityProvider);
    final emailProviderValid = ref.watch(loginEmailValidProvider);
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: LoadingOverlay(
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
                    Text('Log into your account',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500)),
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
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  suffixIcon: emailProviderValid
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
                                      borderSide: emailProviderValid
                                          ? BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 1.0)
                                          : BorderSide(
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
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                ref.read(loginEmailProvider.notifier).state =
                                    value;
                                // Update validation state dynamically
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                ref
                                    .read(loginEmailValidProvider.notifier)
                                    .state = emailRegex.hasMatch(value);
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
                                          "${Constants.imagePathAuth}pass_visible.svg",
                                          height: 10.sp,
                                        )
                                      : SvgPicture.asset(
                                          "${Constants.imagePathAuth}pass_hide.svg",
                                          height: 10.sp,
                                        ),
                                  onPressed: () {
                                    ref
                                        .read(loginpasswordVisibilityProvider
                                            .notifier)
                                        .state = !passwordVisible;
                                  },
                                ),
                              ),
                              obscureText: !passwordVisible,
                              onChanged: (value) {
                                ref.read(loginPasswordProvider.notifier).state =
                                    value;

                                // Real-time validation for password
                                final isValidPassword = value.length >=
                                    8; // Example: At least 8 characters
                                ref
                                    .read(loginPasswordValidProvider.notifier)
                                    .state = isValidPassword;
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14.sp,
                    ),
                    InkWell(
                      onTap: () {
                        context.push("/forgotPassword");
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 14.sp),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot password?',
                            textAlign: TextAlign.right,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
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
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                            onPressed: () {},
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
                      padding: EdgeInsets.symmetric(horizontal: 50.0.sp),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'By clicking the Sign Up button, you agree to the',
                              style: TextStyle(
                                color: Color(0xFF393939),
                                fontSize: 14.sp,
                                fontFamily: 'NotoSansHebrew',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' Term & Condition',
                              style: TextStyle(
                                color: Color(0xFFC1768D),
                                fontSize: 14.sp,
                                fontFamily: 'NotoSansHebrew',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' and',
                              style: TextStyle(
                                color: Color(0xFF393939),
                                fontSize: 14,
                                fontFamily: 'NotoSansHebrew',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' Privacy Policy.',
                              style: TextStyle(
                                color: Color(0xFFC1768D),
                                fontSize: 14,
                                fontFamily: 'NotoSansHebrew',
                                fontWeight: FontWeight.w400,
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
                              text: 'Need an Account?',
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
                                text: 'Sign Up',
                                style: AppTheme.lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    resetProviders();
                                    context.go("/signup");
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
                      splashColor: AppTheme.subTextColor.withOpacity(0.5),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final email =
                              ref.read(loginEmailProvider.notifier).state;
                          final password =
                              ref.read(loginPasswordProvider.notifier).state;
                          login(email, password, context);
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
                            "Log In",
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
    ));
  }

  login(String email, String password, BuildContext context) async {
    ref.read(isLoadingProvider.notifier).state = true;

    ref
        .read(loginApiProvider(LoginParams(email, password)).future)
        .then((loginModel) {
      if (loginModel.statusCode == 200) {
        if (loginModel.data != null) {
          saveLoginData(loginModel.data!);
          ConstantMethods.showAlertBottomSheet(
              context: context,
              title: loginModel.message ?? "",
              message: "Please wait you will be redirect to \nthe home page.",
              icon: "${Constants.imagePathAuth}success_new.svg",
              isLoading: true);
          Future.delayed(Duration(seconds: 3)).then(
            (value) async {
              String? isAppSettingsDone =
                  await SecureStorage.get(Constants.isAppSettingsDone);
              resetProviders();
              if (isAppSettingsDone != null &&
                  isAppSettingsDone.toLowerCase() == "true") {
                context.go("/dashboard");
              } else {
                context.go("/appSettings");
              }
            },
          );
        }
        ref.read(isLoadingProvider.notifier).state = false;
      } else {
        ConstantMethods.showAlertBottomSheet(
            context: context,
            title: "Failed",
            message: loginModel.message ?? "",
            isLoading: true,
            icon: "${Constants.imagePathAuth}failed_new.svg");
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }).catchError((error) {
      ConstantMethods.showSnackbar(context, error.toString());
      ref.read(isLoadingProvider.notifier).state = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  resetProviders() {
    ref.read(loginEmailProvider.notifier).state = '';
    ref.read(loginEmailValidProvider.notifier).state = false;
    ref.read(loginPasswordProvider.notifier).state = '';
    ref.read(loginPasswordValidProvider.notifier).state = false;
  }

  void saveLoginData(LoginModelData response) async {
    await SecureStorage.save('token', response.token ?? "");
    await SecureStorage.save('refresh_token', response.refreshToken ?? "");
    await SecureStorage.save('user_id', response.userId.toString());
    if (response.country!.isNotEmpty) {}
    if (response.currency!.isNotEmpty) {
      ref.read(currentCurrencySymbolProvider.notifier).state =
          CurrencySymbol.fromString(response.currency ?? "").symbol;
      await SecureStorage.save(Constants.isAppSettingsDone, "true");
    }
    if (response.language!.isNotEmpty) {
      ref
          .read(changeLocaleProvider.notifier)
          .set(Locale(response.language ?? "en"));
    }
  }
}
