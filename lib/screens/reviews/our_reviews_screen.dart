import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/product/product_details_screen.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OurReviewsScreen extends HookConsumerWidget {
  final bool isMyReview;
  const OurReviewsScreen(this.isMyReview, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);

    // if (isMyReview) {

    // }
    final reviews = ref.watch(ourReviewsApiProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Our Reviews",
          style: AppTheme.lightTheme.textTheme.titleMedium
              ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        actions: [
          PopupMenuButton<int>(
            color: AppTheme.appBarAndBottomBarColor,
            shape: Border.all(
              color: AppTheme.strokeColor,
            ),
            onSelected: (value) {
              if (value == 1) {
                print("Edit Selected");
              } else if (value == 2) {
                print("Delete Selected");
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "${Constants.imagePath}empty_star.svg",
                      color: AppTheme.primaryColor,
                      height: 10.h,
                    ),
                    SizedBox(width: 6.w), // Space between icon and text
                    Text(
                      'Check Your Reviews',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                  height: 1.h,
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 0.4,
                    color: AppTheme.strokeColor,
                  )),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "${Constants.imagePath}edit.svg",
                      color: AppTheme.primaryColor,
                      height: 12.h,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Rate Your Products',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
            icon: SvgPicture.asset(
                "${Constants.imagePath}review_menu.svg"), // Three-dot menu icon
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(localization.ratingAndReviews,
                    style: AppTheme.lightTheme.textTheme.bodyLarge),
                // Row(
                //   children: [
                //     SvgPicture.asset(
                //       "${Constants.imagePathProducts}pencil.svg",
                //       height: ScreenUtil().setSp(13),
                //     ),
                //     SizedBox(
                //       width: 4,
                //     ),
                //     Text(localization.writeAReview,
                //         style: AppTheme.lightTheme.textTheme.bodyMedium
                //             ?.copyWith(fontWeight: FontWeight.w600)),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            width: 207.w,
            height: 34.h,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: AppTheme.subTextColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Center(
              child: Text('Rate Your Purchased Products',
                  style: AppTheme.lightTheme.textTheme.bodySmall
                      ?.copyWith(fontSize: 12.sp)),
            ),
          ),
          SizedBox(
            height: 36.sp,
          ),
          reviews.when(
            data: (data) {
              final datum = data.data;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                            calculateStarRating([
                              int.parse(datum?.rating?.s1Star ?? "0"),
                              int.parse(datum?.rating?.s2Star ?? "0"),
                              int.parse(datum?.rating?.s3Star ?? "0"),
                              int.parse(datum?.rating?.s4Star ?? "0"),
                              int.parse(datum?.rating?.s5Star ?? "0")
                            ]).toString(),
                            style: AppTheme.lightTheme.textTheme.headlineLarge
                                ?.copyWith(fontSize: 38.sp)),
                        datum?.rating?.totalRating == "1"
                            ? Text(
                                '${datum?.rating?.totalRating ?? ""} rating',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                              )
                            : Text(
                                '${datum?.rating?.totalRating ?? ""} ratings',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                              ),
                      ],
                    ),
                    StarRatingProgress(ratingCounts: [
                      int.parse(datum?.rating?.s1Star ?? "0"),
                      int.parse(datum?.rating?.s2Star ?? "0"),
                      int.parse(datum?.rating?.s3Star ?? "0"),
                      int.parse(datum?.rating?.s4Star ?? "0"),
                      int.parse(datum?.rating?.s5Star ?? "0")
                    ])
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return SizedBox();
            },
            loading: () {
              return SizedBox();
            },
          ),
          SizedBox(
            height: 18.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    // width: ScreenUtil().setWidth(34),
                    height: ScreenUtil().setHeight(34),

                    decoration: ShapeDecoration(
                      color: AppTheme.appBarAndBottomBarColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 0.40,
                            color: AppTheme.appBarAndBottomBarColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "${Constants.imagePath}search.svg",
                            height: 15.sp,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                      // width: ScreenUtil().setWidth(160),
                      height: ScreenUtil().setHeight(34),
                      padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                      decoration: ShapeDecoration(
                        color: AppTheme.appBarAndBottomBarColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 0.40,
                              color: AppTheme.appBarAndBottomBarColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(localization.sortBy,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(fontSize: 11.sp)),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 14.sp,
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: 8.sp,
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    // width: ScreenUtil().setWidth(160),
                    height: ScreenUtil().setHeight(34),
                    padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                    decoration: ShapeDecoration(
                      color: AppTheme.appBarAndBottomBarColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 0.40,
                            color: AppTheme.appBarAndBottomBarColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.sortByRating,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(fontSize: 11.sp)),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 14.sp,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 24.sp,
          ),
          Divider(
            color: AppTheme.subTextColor.withOpacity(0.3),
            height: 0.1,
          ),
          reviews.when(
            data: (data) {
              final datum = data.data;
              return datum?.reviews != null && datum!.reviews!.isNotEmpty
                  ? Expanded(
                      // height: ScreenUtil().setHeight(200),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0.sp, vertical: 12.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          datum.reviews?[index].productImage ??
                                              "",
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: SizedBox(
                                          height: ScreenUtil().setHeight(20),
                                          width: ScreenUtil().setWidth(20),
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      height: 87.h,
                                      width: 75.w,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingStars(
                                        value: double.parse(datum
                                                .reviews?[index].rating
                                                .toString() ??
                                            "0.0"),
                                        onValueChanged: (v) {
                                          //
                                        },
                                        starBuilder: (index, color) =>
                                            ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              color!, BlendMode.srcIn),
                                          child: SvgPicture.asset(
                                              "${Constants.imagePath}empty_star.svg"),
                                        ),
                                        starCount: 5,
                                        starSize: ScreenUtil().setSp(14),
                                        maxValue: 5,
                                        starSpacing: 2,
                                        maxValueVisibility: true,
                                        valueLabelVisibility: false,
                                        animationDuration:
                                            Duration(milliseconds: 1000),
                                        starOffColor: AppTheme.strokeColor,
                                        starColor: AppTheme.primaryColor,
                                      ),
                                      SizedBox(
                                        height: 8.sp,
                                      ),
                                      datum.reviews![index].title!.isNotEmpty
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().screenWidth *
                                                          0.7,
                                                  child: Text(
                                                    datum.reviews![index]
                                                            .title ??
                                                        "",
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 15.sp),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.sp,
                                                ),
                                              ],
                                            )
                                          : SizedBox.shrink(),
                                      SizedBox(
                                        width: ScreenUtil().screenWidth * 0.7,
                                        child: Text(
                                          datum.reviews![index].content ?? "",
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      datum.reviews != null &&
                                              datum.reviews![index]
                                                  .reviewImages!.isNotEmpty
                                          ? SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: datum.reviews![index]
                                                    .reviewImages!
                                                    .map((e) => Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 8.0.w),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12)),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl: e,
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          downloadProgress) =>
                                                                      Center(
                                                                child: SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          20),
                                                                  width: ScreenUtil()
                                                                      .setWidth(
                                                                          20),
                                                                  child: CircularProgressIndicator(
                                                                      value: downloadProgress
                                                                          .progress),
                                                                ),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                              height: 76.h,
                                                              width: 68.w,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: AppTheme.subTextColor.withOpacity(0.3),
                              height: 0.1,
                            );
                          },
                          itemCount: datum.reviews!.length),
                    )
                  : SizedBox(
                      // height: 40.sp,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            SvgPicture.asset(
                                "${Constants.imagePath}no_stars.svg"),
                            Text(
                              'No Reviews',
                              style: AppTheme.lightTheme.textTheme.headlineLarge
                                  ?.copyWith(fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                    );
            },
            error: (error, stackTrace) {
              if (error is NetworkException) {
                // Show No Internet Widget
                return NoInternetWidget(
                  onRetry: () {
                    return ref.refresh(getHelpCenterListApiProvider(""));
                  },
                );
              }
              return ConstantMethods.buildErrorUI(
                ref,
                onPressed: () => ref.refresh(getHelpCenterListApiProvider("")),
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
            height: 26.sp,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                // Button press action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.appBgColor, // Transparent background
                // foregroundColor: Colors.blue, // Text color
                side: const BorderSide(
                  color: AppTheme.subTextColor, // Border color
                  width: 1.0, // Border width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      ScreenUtil().setSp(13)), // Border radius
                ),
              ),
              child: Text(
                localization.checkMoreReviews,
                style: AppTheme.lightTheme.textTheme.labelSmall,
              ),
            ),
          ),
          SizedBox(
            height: 80.sp,
          ),
        ],
      ),
    );
  }

  double calculateStarRating(List<int> ratingCounts) {
    // Ensure the list has exactly 5 elements (1-star to 5-star counts)
    if (ratingCounts.length != 5) {
      throw ArgumentError("ratingCounts must have exactly 5 elements.");
    }

    // Calculate the total ratings
    int totalRatings = ratingCounts.reduce((a, b) => a + b);

    if (totalRatings == 0) {
      return 0.0; // No ratings, return 0
    }

    // Calculate the weighted sum
    int weightedSum = 0;
    for (int i = 0; i < ratingCounts.length; i++) {
      weightedSum += ratingCounts[i] *
          (i + 1); // (i+1) is the star value (1-star to 5-star)
    }

    // Calculate and return the average
    return (weightedSum / totalRatings).roundToDouble();
  }
}

extension on List<int> {
  get reviewImages => null;
}
