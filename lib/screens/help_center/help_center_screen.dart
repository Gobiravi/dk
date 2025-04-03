import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/help_center/help_center_notifier.dart';
import 'package:dikla_spirit/screens/help_center/search_notifier.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HelpCenterScreen extends HookConsumerWidget {
  const HelpCenterScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final helpCenterState = ref.watch(helpCenterProvider);
    final helpCenterDetailsState = ref.watch(helpCenterDetailsProvider);
    final selectedFilterIndex = ref.watch(selectedFilterIndexProvider);
    final selectedFaq = ref.watch(selectedFaqKey);

    useEffect(() {
      Future.microtask(() =>
          ref.read(helpCenterProvider.notifier).fetchHelpCenterCategories());
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        title: Text(
          localization.help_center,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            fontSize: 17.sp,
            color: AppTheme.textColor,
            letterSpacing: -0.45,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/help/help.png",
              height: 157.h,
              width: ScreenUtil().screenWidth,
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: SearchFieldHelp(),
            ),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              width: ScreenUtil().screenWidth * 0.83,
              child: Text(
                'Welcome to our Help Center. Here, you can find answers to common questions about our services and get support if you need help',
                textAlign: TextAlign.center,
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: ShapeDecoration(
                  color: AppTheme.appBarAndBottomBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        'FAQ',
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(
                                fontSize: 16.sp, color: AppTheme.primaryColor),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      helpCenterState.when(
                        data: (data) {
                          if (data.isNotEmpty) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 120.h,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      width: 12.w,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              ref
                                                  .read(
                                                      helpCenterDetailsProvider
                                                          .notifier)
                                                  .fetchCategoryDetails(
                                                      data[index].key ?? "");
                                              ref
                                                  .read(selectedFaqKey.notifier)
                                                  .state = data[index]
                                                      .key ??
                                                  "";
                                            },
                                            child: Container(
                                              width: 70.h,
                                              height: 70.h,
                                              decoration: ShapeDecoration(
                                                color: AppTheme
                                                    .appBarAndBottomBarColor,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: selectedFaq ==
                                                              data[index].key
                                                          ? AppTheme
                                                              .primaryColor
                                                          : AppTheme
                                                              .strokeColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                              ),
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      data[index].image ?? "",
                                                  height: 38.h,
                                                  width: 38.h,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 62.w,
                                            child: Text(
                                              data[index].value ?? "",
                                              textAlign: TextAlign.center,
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.length,
                                  ),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                ConstantMethods.customDivider(),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Visibility(
                                  visible: selectedFaq == "product-service",
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(selectedFilterIndexProvider
                                                  .notifier)
                                              .state = 0;
                                        },
                                        child: Container(
                                          // width: 121,
                                          height: 29.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 5.h),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: selectedFilterIndex ==
                                                          0
                                                      ? AppTheme.primaryColor
                                                      : AppTheme.subTextColor),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                          ),
                                          child: Text(
                                            'Spell',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color:
                                                        selectedFilterIndex == 0
                                                            ? AppTheme
                                                                .primaryColor
                                                            : AppTheme
                                                                .subTextColor,
                                                    fontSize: 12.sp),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(selectedFilterIndexProvider
                                                  .notifier)
                                              .state = 1;
                                        },
                                        child: Container(
                                          // width: 121,
                                          height: 29.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 5.h),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: selectedFilterIndex ==
                                                          1
                                                      ? AppTheme.primaryColor
                                                      : AppTheme.subTextColor),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                          ),
                                          child: Text(
                                            'Channeling',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color:
                                                        selectedFilterIndex == 1
                                                            ? AppTheme
                                                                .primaryColor
                                                            : AppTheme
                                                                .subTextColor,
                                                    fontSize: 12.sp),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(selectedFilterIndexProvider
                                                  .notifier)
                                              .state = 2;
                                        },
                                        child: Container(
                                          // width: 121,
                                          height: 29.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 5.h),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: selectedFilterIndex ==
                                                          2
                                                      ? AppTheme.primaryColor
                                                      : AppTheme.subTextColor),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                          ),
                                          child: Text(
                                            'Moon Jewellery',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color:
                                                        selectedFilterIndex == 2
                                                            ? AppTheme
                                                                .primaryColor
                                                            : AppTheme
                                                                .subTextColor,
                                                    fontSize: 12.sp),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                        error: (error, stackTrace) {
                          if (error is NetworkException) {
                            // Show No Internet Widget
                            return NoInternetWidget(
                              onRetry: () {
                                return ref
                                    .refresh(getHelpCenterListApiProvider(""));
                              },
                            );
                          }
                          return ConstantMethods.buildErrorUI(
                            ref,
                            onPressed: () {
                              return ref
                                  .refresh(getHelpCenterListApiProvider(""));
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
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: ShapeDecoration(
                  color: AppTheme.appBarAndBottomBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 32.h),
                  child: helpCenterDetailsState.when(
                    data: (data) {
                      final datum = data?.data ?? [];
                      final listToShow = selectedFaq == "product-service"
                          ? (selectedFilterIndex == 0
                                  ? data?.spell
                                  : selectedFilterIndex == 1
                                      ? data?.channeling
                                      : data?.moon) ??
                              []
                          : datum;

                      if (listToShow.isEmpty) {
                        return Center(
                          child: Text(
                            'No FAQ Found',
                            style: AppTheme.lightTheme.textTheme.labelSmall,
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: listToShow.length,
                        separatorBuilder: (_, __) => SizedBox(height: 18.h),
                        itemBuilder: (context, index) {
                          final item = listToShow[index];

                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(color: AppTheme.strokeColor),
                            ),
                            child: ExpansionTile(
                              title: Text(
                                item.title ?? "",
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(fontSize: 14.sp),
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              collapsedBackgroundColor:
                                  AppTheme.appBarAndBottomBarColor,
                              backgroundColor: AppTheme.appBarAndBottomBarColor,
                              shape: Border(), // Removes the default border
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0.sp),
                                  child: HtmlWidget(item.content ?? ""),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      if (error is NetworkException) {
                        return NoInternetWidget(
                          onRetry: () =>
                              ref.refresh(getHelpCenterListApiProvider("")),
                        );
                      }
                      return ConstantMethods.buildErrorUI(
                        ref,
                        onPressed: () {
                          return ref.refresh(getHelpCenterListApiProvider(""));
                        },
                      );
                    },
                    loading: () => Center(
                      child: SpinKitPumpingHeart(
                        color: AppTheme.appBarAndBottomBarColor,
                        size: ScreenUtil().setHeight(50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
                decoration: ShapeDecoration(
                  color: AppTheme.appBarAndBottomBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need more help?',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          fontSize: 16.sp, color: AppTheme.primaryColor),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: ScreenUtil().screenWidth / 3.7,
                          height: 82.h,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppTheme.strokeColor),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "${Constants.imagePathHelp}email.svg",
                                height: 24.h,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text('Email',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil().screenWidth / 3.7,
                          height: 82.h,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppTheme.strokeColor),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "${Constants.imagePathHelp}whatsapp.svg",
                                height: 24.h,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text('Whatsapp',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.push("/submit_request");
                          },
                          child: Container(
                            width: ScreenUtil().screenWidth / 3.7,
                            height: 82.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: AppTheme.strokeColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "${Constants.imagePathHelp}request.svg",
                                  height: 24.h,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text('Raise Request',
                                    textAlign: TextAlign.center,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h + kToolbarHeight,
            ),
          ],
        ),
      ),
    );
  }

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(getHelpCenterListApiProvider(""));
  }
}

final selectedFilterIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final selectedFaqKey = StateProvider<String>((ref) {
  return "";
});

class SearchFieldHelp extends ConsumerWidget {
  final String hintText;

  const SearchFieldHelp({super.key, this.hintText = "Search"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchProviderHelp);

    return Container(
      // height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.strokeColor), // Border color
      ),
      child: TextField(
        cursorColor: AppTheme.cursorColor,
        cursorWidth: 1.0,
        cursorHeight: 18.h,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) =>
            ref.read(searchProviderHelp.notifier).updateSearch(value),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.sp),
            child: SvgPicture.asset(
              "assets/images/search.svg", // Update the path to your SVG
              width: 15.w,
              height: 15.h,
              fit: BoxFit.contain,
            ),
          ),
          hintText: hintText,
          hintStyle: AppTheme.lightTheme.textTheme.bodySmall
              ?.copyWith(fontSize: 15.sp, color: AppTheme.teritiaryTextColor),
          border: InputBorder.none,
          // contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
        // textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
