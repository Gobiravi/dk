import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/loading_overlay.dart';
import 'package:dikla_spirit/model/auth/forgot_password_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPassScreen extends HookConsumerWidget {
  ForgotPasswordModelData data;
  ResetPassScreen({super.key, required this.data});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordVisible = ref.watch(resetPasswordVisibilityProvider);
    final confirmPasswordVisible = ref.watch(resetCPasswordVisibilityProvider);
    return Scaffold(
      body: LoadingOverlay(
          child: SafeArea(
        child: SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 26.0.sp, top: 10.sp),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      ref.read(resetPasswordProvider.notifier).state = "";
                      ref.read(resetCPassProvider.notifier).state = "";
                      ref.read(resetPasswordValidProvider.notifier).state =
                          false;
                      ref.read(resetPasswordVisibilityProvider.notifier).state =
                          true;
                      ref.read(resetCPasswordValidProvider.notifier).state =
                          false;
                      ref
                          .read(resetCPasswordVisibilityProvider.notifier)
                          .state = true;

                      context.pop();
                    },
                    child: Container(
                      width: 39.sp,
                      height: 39.sp,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: AppTheme.buttonOutLine),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.keyboard_arrow_left_outlined,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 26.sp),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "DIKLA SPIRIT",
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.56),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Text(
                          'Reset Password ?',
                          style: AppTheme.lightTheme.textTheme.bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 44.sp),
                          child: Text(
                            "Please choose a new password for your account. Make sure it’s secure and easy for you to remember.",
                            textAlign: TextAlign.center,
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ),
                        // Text(
                        //   'Reset Password',
                        //   style: AppTheme.lightTheme.textTheme.labelMedium
                        //       ?.copyWith(
                        //           fontWeight: FontWeight.w400, fontSize: 20.sp),
                        // ),
                        SizedBox(
                          height: 22.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                          child: TextFormField(
                            cursorColor: AppTheme.cursorColor,
                            cursorWidth: 1.0,
                            cursorHeight: 18.h,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Password',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
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
                                      color: AppTheme.strokeColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.primaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.strokeColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.strokeColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.errorBorder, width: 1.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.errorBorder, width: 1.0)),
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
                                      .read(resetPasswordVisibilityProvider
                                          .notifier)
                                      .state = !passwordVisible;
                                },
                              ),
                            ),
                            obscureText: !passwordVisible,
                            onChanged: (value) {
                              ref.read(resetPasswordProvider.notifier).state =
                                  value;

                              // Real-time validation for password
                              final isValidPassword = value.length >=
                                  8; // Example: At least 8 characters
                              ref
                                  .read(resetPasswordValidProvider.notifier)
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
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                          child: TextFormField(
                            cursorColor: AppTheme.cursorColor,
                            cursorWidth: 1.0,
                            cursorHeight: 18.h,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: confirmPasswordVisible
                                      ? SvgPicture.asset(
                                          "${Constants.imagePathAuth}pass_visible.svg")
                                      : SvgPicture.asset(
                                          "${Constants.imagePathAuth}pass_hide.svg"),
                                  onPressed: () {
                                    ref
                                        .read(resetCPasswordVisibilityProvider
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
                                fillColor: AppTheme.appBarAndBottomBarColor),
                            obscureText: !confirmPasswordVisible,
                            onChanged: (value) {
                              ref.read(resetCPassProvider.notifier).state =
                                  value;

                              // Real-time validation for matching passwords
                              final isValidConfirmPassword = value ==
                                  ref.read(
                                      resetPasswordProvider); // Match with password
                              ref
                                  .read(resetCPasswordValidProvider.notifier)
                                  .state = isValidConfirmPassword;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
                              }
                              if (value != ref.read(resetPasswordProvider)) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    data.isForgot!
                        ? Column(
                            children: [
                              ConstantMethods.customDivider(),
                              SizedBox(
                                height: 24.sp,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Already have an account?',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: AppTheme.subTextColor),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: AppTheme.subTextColor),
                                      ),
                                      TextSpan(
                                          text: 'Log In',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              ref
                                                  .read(resetPasswordProvider
                                                      .notifier)
                                                  .state = "";
                                              ref
                                                  .read(resetCPassProvider
                                                      .notifier)
                                                  .state = "";
                                              ref
                                                  .read(
                                                      resetPasswordValidProvider
                                                          .notifier)
                                                  .state = false;
                                              ref
                                                  .read(
                                                      resetPasswordVisibilityProvider
                                                          .notifier)
                                                  .state = true;
                                              ref
                                                  .read(
                                                      resetCPasswordValidProvider
                                                          .notifier)
                                                  .state = false;
                                              ref
                                                  .read(
                                                      resetCPasswordVisibilityProvider
                                                          .notifier)
                                                  .state = true;
                                              context.go("/login");
                                            }),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 24.sp,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    Container(
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
                            final pass = ref.read(resetPasswordProvider);
                            final cPass = ref.read(resetCPassProvider);
                            // final passValid =
                            //     ref.read(resetPasswordValidProvider);
                            // final cPassValid =
                            //     ref.read(resetCPasswordValidProvider);
                            // if (pass.isNotEmpty &&
                            //     cPass.isNotEmpty &&
                            //     passValid &&
                            //     cPassValid) {
                            if (_formKey.currentState!.validate()) {
                              ref.read(isLoadingProvider.notifier).state = true;
                              ref
                                  .read(resetPassApiProvider(
                                          ResetPasswordParams(
                                              newPass: pass,
                                              confirmPass: cPass,
                                              resetKey: data.resetKey ?? "",
                                              userLogin: data.userLogin ?? ""))
                                      .future)
                                  .then(
                                (value) {
                                  if (value.statusCode == 200) {
                                    ConstantMethods.showAlertBottomSheet(
                                        context: context,
                                        title: value.message ?? "",
                                        message:
                                            "Please wait you will be redirect to \nthe login page.",
                                        icon:
                                            "${Constants.imagePathAuth}success_new.svg",
                                        isLoading: true);
                                    Future.delayed(Duration(seconds: 3)).then(
                                      (value) {
                                        if (context.mounted) {
                                          if (data.isForgot!) {
                                            context.go("/login");
                                          } else {
                                            context.pop();
                                          }
                                        }
                                      },
                                    );
                                  } else {
                                    ConstantMethods.showAlertBottomSheet(
                                        context: context,
                                        title: "Please Try Again!",
                                        message: value.message ?? "",
                                        icon:
                                            "${Constants.imagePathAuth}failed_new.svg",
                                        isLoading: true);
                                  }
                                  ref.read(isLoadingProvider.notifier).state =
                                      false;
                                },
                              );
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
                                "Reset Password",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ResetPasswordParams {
  String newPass;
  String confirmPass;
  String resetKey;
  String userLogin;
  ResetPasswordParams(
      {required this.newPass,
      required this.confirmPass,
      required this.resetKey,
      required this.userLogin});
}
