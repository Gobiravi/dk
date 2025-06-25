import 'dart:io';

import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/auth/login_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/widgets/auth/google_signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginOptionsScreen extends HookConsumerWidget {
  const LoginOptionsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            SizedBox(
              height: 44.sp,
            ),
            Text(
              "DIKLA SPIRIT",
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryColor,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.70),
            ),
            Spacer(),
            // Text(
            //   "Merinda",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Merinda",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   loc.checkMoreReviews,
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Merinda",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            SizedBox(
              height: 8.sp,
            ),
            Text(
              "Create an Account",
              style: AppTheme.lightTheme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            ),
            // SizedBox(
            //   height: 22.sp,
            // ),
            // Text(
            //   "Cosmic Neue",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "ComicNeue",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   loc.checkMoreReviews,
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "ComicNeue",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   "Create an Account",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "ComicNeue",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 22.sp,
            // ),
            // Text(
            //   "AveriaSansLibre",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "AveriaSansLibre",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   loc.checkMoreReviews,
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "AveriaSansLibre",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   "Create an Account",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "AveriaSansLibre",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 22.sp,
            // ),
            // Text(
            //   "Nunito",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Nunito",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   loc.checkMoreReviews,
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Nunito",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   "Create an Account",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Nunito",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 22.sp,
            // ),
            // Text(
            //   "Quicksand",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Quicksand",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   loc.checkMoreReviews,
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Quicksand",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   "Create an Account",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "Quicksand",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 22.sp,
            // ),
            // Text(
            //   "PlaypenSans",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "PlaypenSans",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   loc.checkMoreReviews,
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "PlaypenSans",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            // SizedBox(
            //   height: 8.sp,
            // ),
            // Text(
            //   "Create an Account",
            //   style: TextStyle(
            //       color: AppTheme.primaryColor,
            //       fontFamily: "PlaypenSans",
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.sp),
            //   //  AppTheme.lightTheme.textTheme.bodyLarge
            //   //     ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20.sp),
            // ),
            SizedBox(
              height: 8.sp,
            ),
            Text(
              'Sign up now to get started!',
              style: AppTheme.lightTheme.textTheme.bodySmall
                  ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 26.sp,
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
                            side: BorderSide(color: AppTheme.subTextColor))),
                    onPressed: () {
                      context.go("/login");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "${Constants.imagePathAuth}email.svg",
                          height: 16.sp,
                        ),
                        Text(
                          'Continue with Email',
                          style: AppTheme.lightTheme.textTheme.bodySmall
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
            ),
            SizedBox(
              height: 16.sp,
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
                                  borderRadius: BorderRadius.circular(12.sp),
                                  side: BorderSide(
                                      color: AppTheme.subTextColor))),
                          onPressed: () {
                            ConstantMethods.signInWithFacebook(ref);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "${Constants.imagePathAuth}fb.svg",
                                height: 16.sp,
                              ),
                              Text(
                                'Continue with Facebook',
                                style: AppTheme.lightTheme.textTheme.bodySmall
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
                                  borderRadius: BorderRadius.circular(12.sp),
                                  side: BorderSide(
                                      color: AppTheme.subTextColor))),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "${Constants.imagePathAuth}apple.svg",
                                height: 20.sp,
                              ),
                              Text(
                                'Continue with Apple',
                                style: AppTheme.lightTheme.textTheme.bodySmall
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
                            side: BorderSide(color: AppTheme.subTextColor))),
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
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
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
              height: 32.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 75.0.sp),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'By clicking the Sign Up button, you agree to the',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: ' Term & Condition',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.primaryColor),
                    ),
                    TextSpan(
                      text: ' and',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: ' Privacy Policy.',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.primaryColor),
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
                      text: 'Already have an account?',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppTheme.subTextColor),
                    ),
                    TextSpan(
                      text: ' ',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppTheme.subTextColor),
                    ),
                    TextSpan(
                        text: 'Log In',
                        style:
                            AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go("/login");
                          }),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.sp,
            )
          ],
        ),
      )),
    );
  }

  // void handleSignOut() async {
  //   await GoogleSignInService.signOut();
  //   setState(() {
  //     name = email = avatarUrl = null;
  //   });
  // }
}
