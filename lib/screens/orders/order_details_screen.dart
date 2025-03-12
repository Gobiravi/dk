import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/orders/order_details_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderDetailsScreen extends HookConsumerWidget {
  String itemId;
  OrderDetailsScreen(this.itemId, {super.key});

  // final List<TimelineStep> steps = [
  //   TimelineStep(
  //     title: "Order Confirmed",
  //     subtitle: "12 Oct 2024, 15:42",
  //     icon: "assets/checklist.svg",
  //   ),
  //   TimelineStep(
  //     title: "Submitted Requirements",
  //     subtitle: "14 Oct 2024, 13:25",
  //     icon: "assets/document.svg",
  //   ),
  //   TimelineStep(
  //     title: "Your Order Started",
  //     subtitle: "14 Oct 2024, 13:38",
  //     icon: "assets/review.svg",
  //   ),
  //   TimelineStep(
  //     title: "Order was Completed",
  //     subtitle: "14 Oct 2024, 13:38",
  //     icon: "assets/package.svg",
  //   ),
  // ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final orderDetails = ref.watch(orderDetailsApiProvider(itemId));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop(context);
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        title: Text(
          localization.order_details,
          style: AppTheme.lightTheme.textTheme.bodyLarge
              ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: orderDetails.when(
        data: (data) {
          switch (data.status) {
            case true:
              final datum = data.data ?? OrderDetailsModelData(status: null);
              final currencySymbol =
                  CurrencySymbol.fromString(datum.currency ?? "USD");
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.sp,
                      ),
                      Container(
                        width: ScreenUtil().screenWidth,
                        padding: EdgeInsets.all(16.sp),
                        // height: 331,
                        decoration: ShapeDecoration(
                          color: AppTheme.appBarAndBottomBarColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: AppTheme.strokeColor),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6.sp),
                                  child: CachedNetworkImage(
                                    imageUrl: datum.image ?? "",
                                    height: 72.sp,
                                    width: 72.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.sp,
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(200),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        datum.name ?? "",
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall
                                            ?.copyWith(fontSize: 14.sp),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        "Qty: ${datum.quantity ?? 1}",
                                        style: AppTheme
                                            .lightTheme.textTheme.labelSmall
                                            ?.copyWith(fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        "${currencySymbol.symbol} ${datum.price ?? 0.0}",
                                        style: AppTheme
                                            .lightTheme.textTheme.labelSmall
                                            ?.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Need Help?',
                                    textAlign: TextAlign.right,
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            ConstantMethods.customDivider(),
                            SizedBox(
                              height: 22.h,
                            ),
                            Text('Order Details',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500)),
                            SizedBox(height: 14.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  datum.orderActivity?.orderStatus ?? "",
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          color: AppTheme.teritiaryTextColor),
                                ),
                                Text(
                                  datum.orderActivity?.orderDate ?? "",
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          color: AppTheme.subTextColor,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Order Id',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          color: AppTheme.teritiaryTextColor),
                                ),
                                Text(
                                  "#${datum.orderId.toString()}",
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          color: AppTheme.subTextColor,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 23.h,
                            ),
                            ConstantMethods.customDivider(),
                            SizedBox(
                              height: 23.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "${Constants.imagePathOrders}edit_form.svg",
                                      height: 28.h,
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Column(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'View/Edit Requirement Form\n',
                                                  style: AppTheme.lightTheme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13.sp,
                                                          letterSpacing:
                                                              -0.30)),
                                              TextSpan(
                                                text:
                                                    'You can check & review the form you have \nfilled for requirements',
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 12.sp,
                                                        letterSpacing: -0.30),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: AppTheme.primaryColor,
                                    size: 14.sp,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        width: ScreenUtil().screenWidth,
                        padding: EdgeInsets.all(18.sp),
                        decoration: ShapeDecoration(
                          color: AppTheme.appBarAndBottomBarColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: AppTheme.strokeColor),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order Activity',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(fontSize: 16.sp)),
                            SizedBox(
                              height: 12.h,
                            ),
                            SizedBox(
                                // height: 300.sp,
                                child: Column(
                              children: [
                                datum.orderActivity?.orderStatus != null
                                    ? TimelineTile(
                                        step: TimelineStep(
                                            title: datum.orderActivity
                                                    ?.orderStatus ??
                                                "",
                                            subtitle: datum
                                                    .orderActivity?.orderDate ??
                                                "",
                                            icon:
                                                "${Constants.imagePathOrders}confirmed.svg"),
                                        isLast: datum.orderActivity
                                                    ?.requirementStatus !=
                                                null
                                            ? false
                                            : true,
                                      )
                                    : SizedBox(),
                                datum.orderActivity?.requirementStatus != null
                                    ? TimelineTile(
                                        step: TimelineStep(
                                            title: datum.orderActivity
                                                    ?.requirementStatus ??
                                                "",
                                            subtitle: datum.orderActivity
                                                    ?.requirementDate ??
                                                "",
                                            icon:
                                                "${Constants.imagePathOrders}submit_req.svg"),
                                        isLast: datum.orderActivity
                                                    ?.processingStatus !=
                                                null
                                            ? false
                                            : true,
                                      )
                                    : SizedBox(),
                                datum.orderActivity?.processingStatus != null
                                    ? TimelineTile(
                                        step: TimelineStep(
                                            title: datum.orderActivity
                                                    ?.processingStatus ??
                                                "",
                                            subtitle: datum.orderActivity
                                                    ?.processedDate ??
                                                "",
                                            icon:
                                                "${Constants.imagePathOrders}order_processing.svg"),
                                        isLast: datum.orderActivity
                                                    ?.completeStatus !=
                                                null
                                            ? false
                                            : true,
                                      )
                                    : SizedBox(),
                                datum.orderActivity?.completeStatus != null
                                    ? TimelineTile(
                                        step: TimelineStep(
                                            title: datum.orderActivity
                                                    ?.completeStatus ??
                                                "",
                                            subtitle: datum.orderActivity
                                                    ?.completedDate ??
                                                "",
                                            icon:
                                                "${Constants.imagePathOrders}order_completed.svg"),
                                        isLast: true,
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ConstantMethods.customDivider(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Check Dikla’s Message & \nDownload Attachments',
                                      style: TextStyle(
                                        color: Color(0xFFC1768D),
                                        fontSize: 13,
                                        fontFamily: 'Noto Sans Hebrew',
                                        fontWeight: FontWeight.w500,
                                        height: 1.46,
                                        letterSpacing: -0.30,
                                      ),
                                    ),
                                    Text(
                                      'View Now',
                                      style: TextStyle(
                                        color: Color(0xFF393939),
                                        fontSize: 12,
                                        fontFamily: 'Noto Sans Hebrew',
                                        fontWeight: FontWeight.w300,
                                        height: 1.42,
                                        letterSpacing: -0.30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 56.h,
                      )
                    ],
                  ),
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
    );
  }

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    ref.refresh(orderDetailsApiProvider(itemId));
  }
}

class TimelineTile extends StatelessWidget {
  final TimelineStep step;
  final bool isLast;

  const TimelineTile({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              "${Constants.imagePathAuth}success.svg",
              height: 20.h,
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 50.h,
                color: AppTheme.primaryColor, // Line color
              ),
          ],
        ),
        SizedBox(width: 12),
        // Title & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                step.title,
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              SizedBox(height: 4),
              Text(
                step.subtitle,
                style: AppTheme.lightTheme.textTheme.bodySmall
                    ?.copyWith(color: AppTheme.teritiaryTextColor),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),

        // Trailing Icon
        SvgPicture.asset(
          step.icon,
          height: 20.h,
          width: 20.h,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}

class TimelineStep {
  final String title;
  final String subtitle;
  final String icon;

  TimelineStep(
      {required this.title, required this.subtitle, required this.icon});
}
