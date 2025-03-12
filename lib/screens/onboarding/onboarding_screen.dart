import 'dart:async';

import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/onboarding/onboard_notifier.dart';
import 'package:dikla_spirit/screens/onboarding/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulHookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController pageController;
  Timer? timer;
  List<SplashScreen> images = [];

  @override
  void initState() {
    super.initState();

    // timer = Timer.periodic(
    //   const Duration(seconds: 2),
    //   (timer) {
    //     if (ref.read(indexOfOnboarding) == images.length - 1) {
    //       pageController.jumpToPage(0);
    //     } else {
    //       pageController.nextPage(
    //           duration: const Duration(seconds: 1), curve: Curves.easeIn);
    //     }
    //   },
    // );
    // pageController = PageController(viewportFraction: 1.0);
    pageController = PageController(viewportFraction: 1.0);

    timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        final images = ref.read(onboardingImagesProvider);
        final currentPage = ref.read(indexOfOnboarding);

        if (images.isNotEmpty) {
          if (currentPage == images.length - 1) {
            pageController.jumpToPage(0);
          } else {
            pageController.nextPage(
                duration: const Duration(seconds: 1), curve: Curves.easeIn);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final onboarding = ref.watch(getOnboardingApiProvider);
    final images = ref.watch(onboardingImagesProvider);
    return SizedBox(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      child: Scaffold(
        body: onboarding.when(
          data: (data) {
            final newImages = data.data?.splashScreen;

            // Update the provider state when new images are received
            if (images.isEmpty || images.length != newImages?.length) {
              Future.microtask(
                () {
                  ref
                      .read(onboardingImagesProvider.notifier)
                      .updateImages(newImages ?? []);
                },
              );
            }

            return Stack(
              children: [
                if (images.isNotEmpty)
                  PageView.builder(
                    controller: pageController,
                    itemCount: images.length,
                    pageSnapping: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      ref.read(indexOfOnboarding.notifier).state = value;
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        height: ScreenUtil().screenHeight,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  images[index].logo ?? "",
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.7),
                            color: AppTheme.textColor),
                        width: ScreenUtil().screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: ScreenUtil().screenHeight * 0.3),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 26.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    images[index].text ?? "",
                                    style: AppTheme
                                        .lightTheme.textTheme.titleMedium!
                                        .copyWith(
                                      color: AppTheme.appBarAndBottomBarColor,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(8),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 140.0.sp),
                    child: SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().setHeight(40),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed("login_options");
                            SecureStorage.save("isOnboardDone", "true");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.appBarAndBottomBarColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(13)),
                            ),
                          ),
                          child: Text(
                            localization.get_started,
                            style: AppTheme.lightTheme.textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (images.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 45.0.sp),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: images.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppTheme.primaryColor,
                          dotHeight: 8.sp,
                          dotWidth: 8.0,
                          dotColor: AppTheme.primaryColor.withOpacity(0.41),
                        ),
                        onDotClicked: (index) {
                          pageController.jumpToPage(index);
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 80.sp,
                    color: AppTheme.primaryColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Something went wrong',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  ElevatedButton(
                    onPressed: () async {
                      ref.refresh(getOnboardingApiProvider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () {
            final spinkit = SpinKitPumpingHeart(
              color: AppTheme.appBarAndBottomBarColor,
              size: ScreenUtil().setHeight(50),
            );
            return Center(child: spinkit);
          },
        ),
      ),
    );
  }
}
