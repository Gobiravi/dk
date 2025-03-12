import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/loading_overlay.dart';
import 'package:dikla_spirit/model/auth/forgot_password_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailProviderValid = ref.watch(forgotEmailValidProvider);
    return Scaffold(
      body: LoadingOverlay(
          child: SafeArea(
        child: SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 26.0.sp, top: 30.sp),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      ref.read(forgotEmailValidProvider.notifier).state = false;
                      ref.read(forgotEmailProvider.notifier).state = "";
                      context.go("/login");
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
                padding: EdgeInsets.only(top: 46.sp),
                child: Align(
                  alignment: Alignment.topCenter,
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
                        'Forgot Password ?',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 46.sp),
                        child: Text(
                          "No worries! Just enter the email address associated with your account, and we'll send you a link to reset your password.",
                          textAlign: TextAlign.center,
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(letterSpacing: 0.20, fontSize: 14.sp),
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //   child: Text(
                      //     'Don’t worry! It happens. Please enter the email associated with your account.',
                      //     textAlign: TextAlign.center,
                      //     style: AppTheme.lightTheme.textTheme.bodySmall
                      //         ?.copyWith(
                      //             fontWeight: FontWeight.w400, fontSize: 14.sp),
                      //   ),
                      // ),
                      SizedBox(
                        height: 38.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.sp),
                        child: TextFormField(
                          cursorColor: AppTheme.cursorColor,
                          cursorWidth: 1.0,
                          cursorHeight: 18.h,
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: 'Email',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
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
                                      color: AppTheme.strokeColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.primaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: emailProviderValid
                                      ? BorderSide(
                                          color: AppTheme.primaryColor,
                                          width: 1.0)
                                      : BorderSide(
                                          color: AppTheme.strokeColor,
                                          width: 1.0),
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
                              fillColor: AppTheme.appBarAndBottomBarColor),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            ref.read(forgotEmailProvider.notifier).state =
                                value;
                            // Update validation state dynamically
                            final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                            ref.read(forgotEmailValidProvider.notifier).state =
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
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                              text: 'Remember Password?',
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
                                  fontSize: 14.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ref
                                        .read(forgotEmailValidProvider.notifier)
                                        .state = false;
                                    ref
                                        .read(forgotEmailProvider.notifier)
                                        .state = "";
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
                            if (emailProviderValid) {
                              ref.read(isLoadingProvider.notifier).state = true;
                              final email =
                                  ref.read(forgotEmailProvider.notifier).state;
                              ref
                                  .read(forgotApiProvider(ForgotPasswordParams(
                                          email: email, lang: "en"))
                                      .future)
                                  .then(
                                (value) {
                                  if (value.status == "success") {
                                    ConstantMethods.showAlertBottomSheet(
                                        context: context,
                                        title: "Password Restoration",
                                        message:
                                            "We’ve sent the password reset instruction to your email address if it’s linked to your Dikla Spirit account.",
                                        icon:
                                            "${Constants.imagePathAuth}success_new.svg",
                                        isLoading: true);
                                    Future.delayed(Duration(seconds: 3)).then(
                                      (value1) {
                                        context.push("/resetPassword",
                                            extra: value.data);
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
                                "Send",
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
