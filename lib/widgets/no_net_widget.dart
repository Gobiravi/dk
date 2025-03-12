import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetWidget({Key? key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 121.sp,
              height: 121.92.sp,
              decoration: ShapeDecoration(
                color: AppTheme.appBarAndBottomBarColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "${Constants.imagePath}offline.svg",
                  height: 32.sp,
                  width: 38.sp,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Internet Connection',
              style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please check your internet connection \nand try again',
              style: AppTheme.lightTheme.textTheme.bodySmall
                  ?.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            if (onRetry != null)
              InkWell(
                onTap: onRetry,
                child: Container(
                  width: 93.w,
                  height: 32.h,
                  decoration: ShapeDecoration(
                    color: AppTheme.subTextColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp)),
                  ),
                  child: Center(
                    child: Text('Try Again',
                        textAlign: TextAlign.center,
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(
                                fontSize: 12.sp,
                                color: AppTheme.appBarAndBottomBarColor)),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
