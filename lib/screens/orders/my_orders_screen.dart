import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

final selectedMyOrderSortProvider = Provider<int>((ref) {
  return 0;
});

class MyOrdersScreen extends HookConsumerWidget {
  const MyOrdersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrderList = ref.watch(getMyOrdersApiProvider);
    final localization = AppLocalizations.of(context);
    final selectedSortBy = ref.watch(selectedMyOrderSortProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              ref.read(indexOfBottomNavbarProvider.notifier).state = 0;
              context.go('/dashboard');
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        title: Text(
          localization.my_orders,
          style: AppTheme.lightTheme.textTheme.bodyLarge
              ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: myOrderList.when(
        data: (data) {
          switch (data.status) {
            case true:
              final datum = data.data?.orders ?? [];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    SizedBox(
                      height: 26.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.sp),
                              height: 30.h,
                              decoration: ShapeDecoration(
                                color: AppTheme.appBarAndBottomBarColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.20, color: Color(0xFFF0D3E2)),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child: Center(
                                child: Text('All',
                                    textAlign: TextAlign.center,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: selectedSortBy == 0
                                                ? AppTheme.primaryColor
                                                : AppTheme.subTextColor)),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.sp),
                              height: 30.h,
                              decoration: ShapeDecoration(
                                color: AppTheme.appBarAndBottomBarColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.20, color: Color(0xFFF0D3E2)),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child: Center(
                                child: Text('Processing',
                                    textAlign: TextAlign.center,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: selectedSortBy == 1
                                                ? AppTheme.primaryColor
                                                : AppTheme.subTextColor)),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.sp),
                              height: 30.h,
                              decoration: ShapeDecoration(
                                color: AppTheme.appBarAndBottomBarColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.20, color: Color(0xFFF0D3E2)),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child: Center(
                                child: Text('Completed',
                                    textAlign: TextAlign.center,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: selectedSortBy == 2
                                                ? AppTheme.primaryColor
                                                : AppTheme.subTextColor)),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          height: 30.h,
                          decoration: ShapeDecoration(
                            color: AppTheme.appBarAndBottomBarColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.20, color: Color(0xFFF0D3E2)),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Text('Filter By',
                                    textAlign: TextAlign.center,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: selectedSortBy == 1
                                                ? AppTheme.primaryColor
                                                : AppTheme.subTextColor)),
                                SizedBox(
                                  width: 8.sp,
                                ),
                                SvgPicture.asset(
                                  "${Constants.imagePath}filterby.svg",
                                  height: 12.sp,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 27.sp,
                    ),
                    if (datum.isNotEmpty)
                      Expanded(
                        child: SizedBox(
                            // height: 237.sp * datum.length,
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 14.sp),
                              child: Container(
                                width: ScreenUtil().screenWidth,
                                // height: 215.sp,
                                decoration: ShapeDecoration(
                                  color: AppTheme.appBarAndBottomBarColor,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: AppTheme.strokeColor),
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14.sp, vertical: 16.sp),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                datum[index].itemStatus ==
                                                        "processing"
                                                    ? "${Constants.imagePathOrders}order_processing.svg"
                                                    : "${Constants.imagePathOrders}order_completed.svg",
                                                height: 28.sp,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    datum[index].itemStatus ??
                                                        "Status",
                                                    style: AppTheme.lightTheme
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                      datum[index].orderDate ??
                                                          "",
                                                      style: AppTheme.lightTheme
                                                          .textTheme.bodySmall),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            // width: 96.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp),
                                            height: 32.h,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color:
                                                        AppTheme.subTextColor),
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                datum[index].requirementForm !=
                                                            null &&
                                                        datum[index]
                                                            .requirementForm!
                                                    ? 'Order Again'
                                                    : "Complete Your Order",
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      ConstantMethods.customDivider(),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.go("/order_details",
                                              extra: datum[index]
                                                  .itemId
                                                  .toString());
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.sp),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        datum[index].image ??
                                                            "",
                                                    height: 72.sp,
                                                    width: 72.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12.sp,
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil()
                                                      .setWidth(200),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        datum[index].name ?? "",
                                                        style: AppTheme
                                                            .lightTheme
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontSize:
                                                                    14.sp),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        datum[index]
                                                            .price
                                                            .toString(),
                                                        style: AppTheme
                                                            .lightTheme
                                                            .textTheme
                                                            .labelMedium
                                                            ?.copyWith(
                                                                fontSize:
                                                                    16.sp),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              child: Icon(
                                                  Icons.keyboard_arrow_right),
                                              onTap: () {},
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      ConstantMethods.customDivider(),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      datum[index].requirementForm != null &&
                                              datum[index].requirementForm!
                                          ? Row(
                                              children: [
                                                Text('Rate this Product:',
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodySmall),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                RatingStars(
                                                  value: 0.0,
                                                  onValueChanged: (v) {
                                                    //
                                                  },
                                                  starBuilder: (index, color) =>
                                                      SvgPicture.asset(
                                                          "${Constants.imagePathOrders}star_outlined.svg"),
                                                  // starOffColor:
                                                  //     AppTheme.strokeColor,
                                                  // starColor:
                                                  //     AppTheme.primaryColor,
                                                  starCount: 5,
                                                  starSize:
                                                      ScreenUtil().setSp(18),
                                                  // maxValue: 5,
                                                  starSpacing: 2,
                                                  valueLabelVisibility: false,
                                                  animationDuration: Duration(
                                                      milliseconds: 1000),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              "Please fill out your requirement form to move the product to 'in progress'.",
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: AppTheme
                                                          .teritiaryTextColor,
                                                      fontSize: 11.sp),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: datum.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                        )),
                      )
                    else
                      Column(
                        children: [
                          SizedBox(
                            height: 67.sp,
                          ),
                          SvgPicture.asset(
                            "${Constants.imagePathOrders}no_orders.svg",
                            height: 36.sp,
                          ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          Text(
                            'You have no orders yet !',
                            textAlign: TextAlign.center,
                            style: AppTheme.lightTheme.textTheme.headlineLarge
                                ?.copyWith(fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            'Keep track of yours orders and return here',
                            textAlign: TextAlign.center,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          Container(
                            width: 159.w,
                            height: 38.h,
                            decoration: ShapeDecoration(
                              color: AppTheme.subTextColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Start Exploring',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppTheme.appBarAndBottomBarColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80.sp,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Search Products',
                              style: AppTheme.lightTheme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 29.h,
                    ),
                    Text(
                      "DIKLA SPIRIT",
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.primaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.60),
                    ),
                    SizedBox(
                      height: 39.h,
                    ),
                  ],
                ),
              );

            case false:
              if (data.statusCode == 402) {
                refreshApi(ref);
              }
              return Column(
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
                    onPressed: () {
                      ref.refresh(getMyOrdersApiProvider);
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
              );
            default:
              return SizedBox();
          }
        },
        error: (error, stackTrace) {
          if (error is NetworkException) {
            // Show No Internet Widget
            return NoInternetWidget(
              onRetry: () {
                ref.refresh(getMyOrdersApiProvider);
              },
            );
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 121.w,
                  height: 121.92.h,
                  decoration: ShapeDecoration(
                    color: AppTheme.appBarAndBottomBarColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp)),
                  ),
                  child: SvgPicture.asset(
                    "${Constants.imagePath}warning.svg",
                    height: 40.sp,
                  ),
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
                  onPressed: () {
                    ref.refresh(getMyOrdersApiProvider);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => _buildShimmerLoading(context),
      ),
    );
  }

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    ref.refresh(getMyOrdersApiProvider);
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0.sp),
      child: Skeletonizer(
        enabled: true, // Enable the shimmer effect
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              color: AppTheme
                  .appBarAndBottomBarColor, // Skeleton shimmer base color
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 22.sp,
                ),
                Icon(
                  Icons.ac_unit,
                  size: 55.sp,
                ),
                ListTile(
                  title: Text('Item number $index as title'),
                  subtitle: const Text('Subtitle here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
