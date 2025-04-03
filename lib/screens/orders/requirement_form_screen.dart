import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/orders/my_orders_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RequirementFormScreen extends HookConsumerWidget {
  final RequirementFormParam param;
  const RequirementFormScreen({super.key, required this.param});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ScreenUtil().screenWidth,
            height: 58.h + kToolbarHeight,
            decoration: ShapeDecoration(
              color: AppTheme.appBarAndBottomBarColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.20.w,
                  color: const Color(0xFFD1D1D1),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: SafeArea(
                child: Row(
                  children: [
                    InkWell(
                      child: SvgPicture.asset(
                          "${Constants.imagePathAppBar}back.svg"),
                      onTap: () {
                        if (GoRouter.of(context).canPop()) {
                          context.pop();
                        }
                      },
                    ),
                    SizedBox(width: 8.75.w),
                    Text(
                      'Requirement Form',
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(
                              color: AppTheme.textColor, fontSize: 17.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 21.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Requirement Form - ${param.name ?? ""}',
                  style: AppTheme.lightTheme.textTheme.bodyLarge
                      ?.copyWith(fontSize: 19.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please fill the form below, which helps Dikla to work on service in an accurate & efficient way',
                  style: AppTheme.lightTheme.textTheme.bodySmall
                      ?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    padding:
                        EdgeInsets.only(left: 14.w, right: 14.w, top: 28.h),
                    decoration: ShapeDecoration(
                      color: AppTheme.appBarAndBottomBarColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: AppTheme.strokeColor,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        param.template != "blessing"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                'Full Name and Current Situation',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodyMedium
                                                ?.copyWith(fontSize: 14.sp)),
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: const Color(0xFFFF4B55),
                                            fontSize: 12,
                                            fontFamily: 'Noto Sans Hebrew',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                      'Please provide your full name and details about your current situation. It is crucial for me to understand exactly what is happening so I can assist you in the best possible way.',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodyMedium
                                          ?.copyWith(fontSize: 10.sp)),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: AppTheme.cursorColor,
                                    cursorWidth: 1.0,
                                    cursorHeight: 18.h,
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Enter Full Name',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10.sp),
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
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      ref
                                          .read(fullNameProviderForm.notifier)
                                          .state = value;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: AppTheme.cursorColor,
                                    cursorWidth: 1.0,
                                    cursorHeight: 18.h,
                                    maxLines: 3,
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.h, horizontal: 12.w),
                                        label: Text(
                                          'Enter Current Situation',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10.sp),
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
                                        errorStyle:
                                            AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                                        fillColor: AppTheme.appBarAndBottomBarColor),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      ref
                                          .read(currentSituationProviderForm
                                              .notifier)
                                          .state = value;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Current Situation is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  ConstantMethods.customDivider(width: 0.40.sp),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'A Clear Photo of Your Face',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodyMedium
                                                ?.copyWith(fontSize: 14.sp)),
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: const Color(0xFFFF4B55),
                                            fontSize: 12,
                                            fontFamily: 'Noto Sans Hebrew',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                      'Please attach a clear photo of your face. The photo should ideally be taken with your face directly facing the camera. This is important for the Channeling to work in the best possible manner.',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodyMedium
                                          ?.copyWith(fontSize: 10.sp)),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(6.r),
                                    dashPattern: [4, 2],
                                    strokeWidth: 1,
                                    color: AppTheme.primaryColor,
                                    child: Container(
                                      width: ScreenUtil().screenWidth,
                                      height: 51.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0x89FFEFF7),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "${Constants.imagePath}upload.svg",
                                            height: 18.h,
                                            width: 18.h,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text('Upload Photograph',
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                      fontSize: 12.sp,
                                                      color: AppTheme
                                                          .primaryColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  ConstantMethods.customDivider(width: 0.4),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        param.template != "blessing"
                            ? Column(
                                children: [
                                  param.template == "spell"
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          'Name & Photo of the Individual You’re Interested in',
                                                      style: AppTheme.lightTheme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 14.sp)),
                                                  TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xFFFF4B55),
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'Noto Sans Hebrew',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                                'Please specify the name and details of the person for whom you would like to perform the spell. Who are they to you, and what is the current situation between you?   \nIf you wish to perform a spell for someone else or for two people who do not include you, please mention their names, provide a brief description of them,\nThis information will help me focus and perform my work more accurately.Please attach a photo of the person you are interested in. It is advisable that the photo does not include other people or animals.',
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        fontSize: 10.sp)),
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                          ],
                                        )
                                      : param.template == "future-channeling"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "Target Individual's Name and Details & Photo",
                                                          style: AppTheme
                                                              .lightTheme
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  fontSize:
                                                                      14.sp)),
                                                      TextSpan(
                                                        text: '*',
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFFFF4B55),
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Noto Sans Hebrew',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                    'Please write the name and details of the person you wish to gain information about.\nIf you wish to receive information about multiple individuals, please provide their names, a brief description about them, and attach a photo of each individual.\nThis information will help me focus and perform my work more accurately.\nPlease attach a clear photo of the face of the person you are interested in. Ensure that the photo is taken with the person facing the camera to guarantee the desired outcome.',
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 10.sp)),
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "Details of the Individual You're Interested In",
                                                          style: AppTheme
                                                              .lightTheme
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  fontSize:
                                                                      14.sp)),
                                                      TextSpan(
                                                        text: '*',
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFFFF4B55),
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Noto Sans Hebrew',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                    'Please write the name and details of the person you wish to gain information about.\nIf you wish to receive information about multiple individuals, please provide their names, a brief description about them, and attach a photo of each individual.\nThis information will help me focus and perform my work more accurately.\nPlease attach a clear photo of the face of the person you are interested in. Ensure that the photo is taken with the person facing the camera to guarantee the desired outcome.',
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 10.sp)),
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                              ],
                                            ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: AppTheme.cursorColor,
                                    cursorWidth: 1.0,
                                    cursorHeight: 18.h,
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Enter Full Name',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10.sp),
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
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) {
                                      ref
                                          .read(fullNameProviderFormIndividual
                                              .notifier)
                                          .state = value;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: AppTheme.cursorColor,
                                    cursorWidth: 1.0,
                                    cursorHeight: 18.h,
                                    maxLines: 3,
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.h, horizontal: 12.w),
                                        label: Text(
                                          'Enter Current Situation',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10.sp),
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
                                        errorStyle:
                                            AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                                        fillColor: AppTheme.appBarAndBottomBarColor),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      ref
                                          .read(
                                              currentSituationProviderFormIndividual
                                                  .notifier)
                                          .state = value;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Current Situation is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(6.r),
                                        dashPattern: [4, 2],
                                        strokeWidth: 1,
                                        color: AppTheme.primaryColor,
                                        child: Container(
                                          width: 181.w,
                                          height: 34.h,
                                          color: const Color(0x89FFEFF7),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "${Constants.imagePath}upload.svg",
                                                height: 15.h,
                                                width: 15.h,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text('Upload Photograph',
                                                  style: AppTheme.lightTheme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          fontSize: 12.sp,
                                                          color: AppTheme
                                                              .primaryColor)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 34.h,
                                        height: 34.h,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 0.60,
                                              color: const Color(0xFF393939),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(Icons.add_rounded),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 30.h,
                        ),
                        Visibility(
                          visible: param.template == "spell",
                          child: Column(
                            children: [
                              ConstantMethods.customDivider(width: 0.4),
                              SizedBox(
                                height: 23.h,
                              ),
                              Text(
                                'Is There Anything Else You Think Is Important for Me to Know?',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                'If you have any additional information or things I should be aware of, please don’t hesitate to write them here!',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(fontSize: 10.sp),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorColor: AppTheme.cursorColor,
                                cursorWidth: 1.0,
                                cursorHeight: 18.h,
                                maxLines: 3,
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.h, horizontal: 12.w),
                                    label: Text(
                                      'Enter Your Question',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(fontSize: 10.sp),
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
                                    fillColor:
                                        AppTheme.appBarAndBottomBarColor),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  ref
                                      .read(questionProviderFormIndividual
                                          .notifier)
                                      .state = value;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Center(
                          child: Container(
                            width: 88.w,
                            height: 32.h,
                            decoration: ShapeDecoration(
                              color: AppTheme.subTextColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                            child: Center(
                              child: Text(
                                'Submit',
                                textAlign: TextAlign.center,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        color: AppTheme.appBarAndBottomBarColor,
                                        fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 33.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpellForm extends ConsumerWidget {
  const SpellForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
