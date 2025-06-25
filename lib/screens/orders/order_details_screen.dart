import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/orders/order_details_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderDetailsScreen extends HookConsumerWidget {
  final String itemId;
  const OrderDetailsScreen(this.itemId, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final orderDetails = ref.watch(orderDetailsApiProvider(itemId));
    final currency = ref.watch(currentCurrencySymbolProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed("dashboard");
              }
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
              final datum = data.data ?? OrderDetailsModelData(orderId: null);
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
                                  "Order Confirmed",
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
                                            title: "Order Confirmed",
                                            subtitle: datum
                                                    .orderActivity?.orderDate ??
                                                "",
                                            icon:
                                                "${Constants.imagePathOrders}confirmed.svg"),
                                        isLast: datum.orderActivity!
                                                .requirementStatus!
                                            ? false
                                            : true,
                                      )
                                    : SizedBox(),
                                datum.orderActivity!.requirementStatus!
                                    ? TimelineTile(
                                        step: TimelineStep(
                                            title: "Submitted Requirement",
                                            subtitle: datum.orderActivity
                                                    ?.requirementDate ??
                                                "",
                                            icon:
                                                "${Constants.imagePathOrders}submit_req.svg"),
                                        isLast: datum.orderActivity!
                                                .processingStatus!
                                            ? false
                                            : true,
                                      )
                                    : SizedBox(),
                                datum.orderActivity!.processingStatus!
                                    ? TimelineTile(
                                        step: TimelineStep(
                                            title: "Your Order Started",
                                            subtitle: datum.orderActivity
                                                    ?.processingDate ??
                                                "",
                                            icon:
                                                "${Constants.imagePathOrders}order_processing.svg"),
                                        isLast:
                                            datum.orderActivity!.completeStatus!
                                                ? false
                                                : true,
                                      )
                                    : SizedBox(),
                                datum.orderActivity!.completeStatus!
                                    ? TimelineTile(
                                        step: TimelineStep(
                                            title: "Order was Completed",
                                            subtitle: datum.orderActivity
                                                    ?.completeDate ??
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
                                InkWell(
                                  onTap: () {
                                    showDiklaMessage(
                                        context,
                                        datum.deliveryMessage ??
                                            DeliveryMessage());
                                  },
                                  child: Row(
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
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'If you have any query connect on ',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(fontSize: 12.sp),
                                ),
                                TextSpan(
                                  text: 'support@diklaspirit.com',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                              width: 1,
                              color: AppTheme.strokeColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Item Price',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$170',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: const Color(0xFF393939),
                                        fontSize: 14,
                                        fontFamily: 'Noto Sans Hebrew',
                                        fontWeight: FontWeight.w600,
                                        height: 1.56,
                                      ),
                                    ),
                                    InkWell(
                                      child: Text(
                                        'View BreakUp',
                                        style: TextStyle(
                                          color: const Color(0xFFC1768D),
                                          fontSize: 12,
                                          fontFamily: 'Noto Sans Hebrew',
                                          fontWeight: FontWeight.w300,
                                          height: 1.42,
                                          letterSpacing: -0.30,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            ConstantMethods.customDivider(),
                            SizedBox(
                              height: 18.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Payment Details',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium),
                                Text(
                                  'Stripe',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: const Color(0xFF393939),
                                    fontSize: 14,
                                    fontFamily: 'Noto Sans Hebrew',
                                    fontWeight: FontWeight.w600,
                                    height: 1.56,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            ConstantMethods.customDivider(),
                            SizedBox(
                              height: 18.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rate this Product',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium),
                                RatingStars(
                                  value: double.parse(datum.rating.toString()),
                                  onValueChanged: (v) {
                                    //
                                  },
                                  starBuilder: (starIndex, color) {
                                    bool isFilled = starIndex <
                                        double.parse(datum.rating.toString());
                                    return ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          color ?? Colors.transparent,
                                          BlendMode.srcIn),
                                      child: SvgPicture.asset(
                                        isFilled
                                            ? "${Constants.imagePath}star.svg"
                                            : "${Constants.imagePathOrders}star_outlined.svg",
                                      ),
                                    );
                                  },
                                  starCount: 5,
                                  starSize: ScreenUtil().setSp(14),
                                  maxValue: 5,
                                  starSpacing: 2,
                                  maxValueVisibility: true,
                                  animationDuration:
                                      Duration(milliseconds: 1000),
                                  valueLabelVisibility: false,
                                  starOffColor: AppTheme.strokeColor,
                                  starColor: AppTheme.primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      datum.otherItem != null && datum.otherItem!.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  'Other Items in this order',
                                  style: AppTheme.lightTheme.textTheme.bodyLarge
                                      ?.copyWith(fontSize: 16.sp),
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Container(
                                  width: ScreenUtil().screenWidth,
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
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 20.h),
                                        child: SizedBox(
                                          // height: ScreenUtil().setHeight(190),
                                          height:
                                              datum.otherItem!.length * 115.h,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                datum.otherItem?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12.0.sp,
                                                        right: 12.sp,
                                                        top: 12.sp),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.sp),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: datum
                                                                        .otherItem?[
                                                                            index]
                                                                        .image ??
                                                                    "",
                                                                height: 77.sp,
                                                                width: 79.sp,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 12.sp,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          200),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    datum.otherItem?[index]
                                                                            .name ??
                                                                        "",
                                                                    style: AppTheme
                                                                        .lightTheme
                                                                        .textTheme
                                                                        .bodySmall
                                                                        ?.copyWith(
                                                                            fontSize:
                                                                                14.sp),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  Text(
                                                                    '$currency ${datum.otherItem?[index].price.toString() ?? ""}',
                                                                    style: AppTheme
                                                                        .lightTheme
                                                                        .textTheme
                                                                        .labelMedium
                                                                        ?.copyWith(
                                                                            fontSize:
                                                                                16.sp),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8.h,
                                                                  ),
                                                                  datum.otherItem?[index].quantity !=
                                                                              null &&
                                                                          datum.otherItem?[index].quantity !=
                                                                              0
                                                                      ? Text(
                                                                          "Qty: ${datum.otherItem?[index].quantity.toString()}",
                                                                          style: AppTheme
                                                                              .lightTheme
                                                                              .textTheme
                                                                              .bodySmall
                                                                              ?.copyWith(fontSize: 12.sp),
                                                                        )
                                                                      : Text(
                                                                          'Out of Stock',
                                                                          style: AppTheme
                                                                              .lightTheme
                                                                              .textTheme
                                                                              .bodySmall
                                                                              ?.copyWith(fontSize: 16.sp, color: AppTheme.primaryColor),
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 12.sp,
                                                  ),
                                                  ConstantMethods.customDivider(
                                                      width: 0.40)
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
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
                              width: 1,
                              color: AppTheme.strokeColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Updates sent to',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(fontSize: 16.sp)),
                            SizedBox(
                              height: 12.h,
                            ),
                            Row(children: [
                              SvgPicture.asset(
                                "${Constants.imagePathAuth}email.svg",
                                height: 16.sp,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                datum.email ?? "",
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.20),
                              ),
                            ])
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
              return ConstantMethods.buildErrorUI(
                ref,
                onPressed: () => ref.refresh(orderDetailsApiProvider(itemId)),
              );
            default:
              return SizedBox();
          }
        },
        error: (error, stackTrace) {
          if (error is NetworkException) {
            return NoInternetWidget(
              onRetry: () {
                return ref.refresh(orderDetailsApiProvider(itemId));
              },
            );
          }
          return ConstantMethods.buildErrorUI(
            ref,
            onPressed: () => ref.refresh(orderDetailsApiProvider(itemId)),
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
    return ref.refresh(orderDetailsApiProvider(itemId));
  }

  showDiklaMessage(BuildContext context, DeliveryMessage message) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            return Container(
              decoration: const BoxDecoration(
                  color: AppTheme.appBarAndBottomBarColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
              height: ScreenUtil().setHeight(477),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            color: Colors.transparent,
                          )),
                      Text(
                        "Dikla’s Delivery Message",
                        style: AppTheme.lightTheme.textTheme.labelMedium
                            ?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          onPressed: () {
                            ref
                                .read(indexOfBottomNavbarProvider.notifier)
                                .state = 0;
                            context.pop();
                          },
                          icon: SvgPicture.asset(
                            "${Constants.imagePath}close_variation.svg",
                            height: 11.sp,
                          ))
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery #1',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(color: AppTheme.subTextColor),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 45.h,
                              height: 45.h,
                              decoration: ShapeDecoration(
                                color: AppTheme.strokeColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.sp)),
                              ),
                              child: Center(
                                child: Image.asset(
                                  "${Constants.imagePath}logo.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dikla’s Message',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(fontSize: 16.sp),
                                ),
                                SizedBox(
                                  height: 9.h,
                                ),
                                SizedBox(
                                  width: 320.w,
                                  child: Text(
                                    message.deliveryMessage ?? "",
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w200,
                                            color: AppTheme.teritiaryTextColor,
                                            fontSize: 14.sp),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (message.deliveryImage != null &&
                                        message.deliveryImage!.isNotEmpty) {
                                      ConstantMethods.downloadFileToDevice(
                                          message.deliveryImage ?? "",
                                          message.deliveryImage ?? "",
                                          context);
                                    } else {
                                      ConstantMethods.showSnackbar(
                                          context, "No File Found");
                                    }
                                  },
                                  child: Container(
                                    width: ScreenUtil().setWidth(141),
                                    height: ScreenUtil().setHeight(151),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: AppTheme.strokeColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(6.sp),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10.h,
                                          right: 10.w,
                                          child: Container(
                                            width: 19.h,
                                            height: 19.h,
                                            decoration: ShapeDecoration(
                                              color: AppTheme.subTextColor
                                                  .withOpacity(0.4),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.r)),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0.sp),
                                              child: SvgPicture.asset(
                                                "${Constants.imagePath}download.svg",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 16.h,
                                          left: 8.h,
                                          right: 8.h,
                                          bottom: 16.h,
                                          child: Image.asset(
                                            "${Constants.imagePath}pdf.png",
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //  static void breakUpUI(
  //     BuildContext context, AsyncValue<WishlistModel> wishlistData) {
  //   Currency? currency;
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Consumer(
  //             builder: (context, ref, child) {
  //               final wishlistData = ref.watch(wishListApiProvider);

  //               return Container(
  //                   decoration: BoxDecoration(
  //                       color: AppTheme.appBarAndBottomBarColor,
  //                       borderRadius: BorderRadius.only(
  //                           topLeft: Radius.circular(12.0.r),
  //                           topRight: Radius.circular(12.0.r))),
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           IconButton(
  //                               onPressed: () {},
  //                               icon: const Icon(
  //                                 Icons.close,
  //                                 color: Colors.transparent,
  //                               )),
  //                           Text(
  //                             'Favorites',
  //                             style: AppTheme.lightTheme.textTheme.bodyLarge,
  //                           ),
  //                           IconButton(
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                               },
  //                               icon: const Icon(
  //                                 Icons.close,
  //                                 color: AppTheme.textColor,
  //                               ))
  //                         ],
  //                       ),
  //                       const Divider(),
  //                       SizedBox(
  //                         height: 12.sp,
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               'Recently Added',
  //                               style: AppTheme.lightTheme.textTheme.labelMedium
  //                                   ?.copyWith(fontSize: 14.sp),
  //                             ),
  //                             TextButton(
  //                               onPressed: () {
  //                                 context.pop();
  //                                 context.push("/wishlist");
  //                               },
  //                               child: Text(
  //                                 'View All',
  //                                 style: AppTheme
  //                                     .lightTheme.textTheme.labelSmall
  //                                     ?.copyWith(color: AppTheme.primaryColor),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       const Divider(),
  //                       Expanded(
  //                         child: SizedBox(
  //                           // height: ScreenUtil().screenHeight / 3.7,
  //                           child: wishlistData.when(
  //                             data: (data) {
  //                               switch (data.status) {
  //                                 case true:
  //                                   Future.microtask(
  //                                     () {
  //                                       ref
  //                                           .read(wishlistProvider.notifier)
  //                                           .initializeWishList(
  //                                               data.data?.wishlist ?? []);
  //                                       currency = CurrencySymbol.fromString(
  //                                           data.data?.currency ?? "USD");
  //                                     },
  //                                   );
  //                                   return data.data?.wishlist != null
  //                                       ? ListView.builder(
  //                                           itemCount:
  //                                               data.data?.wishlist!.length,
  //                                           itemBuilder: (context, index) {
  //                                             return Column(
  //                                               children: [
  //                                                 Padding(
  //                                                   padding: EdgeInsets.only(
  //                                                       bottom: 16.0.sp,
  //                                                       left: 14.sp,
  //                                                       right: 14.sp),
  //                                                   child: Row(
  //                                                     mainAxisAlignment:
  //                                                         MainAxisAlignment
  //                                                             .spaceBetween,
  //                                                     children: [
  //                                                       Row(
  //                                                         children: [
  //                                                           ClipRRect(
  //                                                             borderRadius:
  //                                                                 const BorderRadius
  //                                                                     .all(
  //                                                                     Radius.circular(
  //                                                                         12)),
  //                                                             child:
  //                                                                 CachedNetworkImage(
  //                                                               imageUrl: data
  //                                                                       .data
  //                                                                       ?.wishlist![
  //                                                                           index]
  //                                                                       .image ??
  //                                                                   "",
  //                                                               height:
  //                                                                   ScreenUtil()
  //                                                                       .setHeight(
  //                                                                           50),
  //                                                               fit:
  //                                                                   BoxFit.fill,
  //                                                             ),
  //                                                           ),
  //                                                           SizedBox(
  //                                                             width: 14.sp,
  //                                                           ),
  //                                                           Column(
  //                                                             crossAxisAlignment:
  //                                                                 CrossAxisAlignment
  //                                                                     .start,
  //                                                             children: [
  //                                                               SizedBox(
  //                                                                 width: ScreenUtil()
  //                                                                         .screenWidth *
  //                                                                     0.5,
  //                                                                 child: Text(
  //                                                                   data.data?.wishlist![index]
  //                                                                           .title ??
  //                                                                       "",
  //                                                                   style: AppTheme
  //                                                                       .lightTheme
  //                                                                       .textTheme
  //                                                                       .bodySmall,
  //                                                                   maxLines: 2,
  //                                                                   overflow:
  //                                                                       TextOverflow
  //                                                                           .ellipsis,
  //                                                                 ),
  //                                                               ),
  //                                                               SizedBox(
  //                                                                 height: 4.sp,
  //                                                               ),
  //                                                               Text(
  //                                                                 "${currency?.symbol ?? ""} ${data.data?.wishlist![index].price.toString()}" ??
  //                                                                     "",
  //                                                                 style: AppTheme
  //                                                                     .lightTheme
  //                                                                     .textTheme
  //                                                                     .bodySmall
  //                                                                     ?.copyWith(
  //                                                                         fontWeight:
  //                                                                             FontWeight.w600),
  //                                                               ),
  //                                                             ],
  //                                                           ),
  //                                                         ],
  //                                                       ),
  //                                                       Row(
  //                                                         children: [
  //                                                           IconButton(
  //                                                               onPressed: () {
  //                                                                 ConstantMethods.toggleWishlist(
  //                                                                     WishListType
  //                                                                         .wishList,
  //                                                                     ref,
  //                                                                     index:
  //                                                                         index);
  //                                                               },
  //                                                               icon: SvgPicture
  //                                                                   .asset(
  //                                                                       "assets/images/remove_from_list.svg")),
  //                                                           IconButton(
  //                                                               onPressed: () {
  //                                                                 if (data
  //                                                                         .data!
  //                                                                         .wishlist?[
  //                                                                             index]
  //                                                                         .type ==
  //                                                                     "variable") {
  //                                                                   if (data.data!.wishlist?[index].variation !=
  //                                                                           null &&
  //                                                                       data
  //                                                                           .data!
  //                                                                           .wishlist![index]
  //                                                                           .variation!
  //                                                                           .isNotEmpty) {
  //                                                                     showVariation(
  //                                                                         context,
  //                                                                         data.data!.wishlist?[index].variation ??
  //                                                                             [],
  //                                                                         data.data!.wishlist?[index].template == 3
  //                                                                             ? "Select Color"
  //                                                                             : "Strength level to choose form",
  //                                                                         data.data!.wishlist?[index].template ??
  //                                                                             0,
  //                                                                         data.data!.wishlist?[index].title ??
  //                                                                             "");
  //                                                                   }
  //                                                                 } else {
  //                                                                   ref
  //                                                                       .refresh(addToCartApiProvider(data.data!.wishlist?[index].id.toString() ??
  //                                                                               "0")
  //                                                                           .future)
  //                                                                       .then(
  //                                                                           (value) {
  //                                                                     if (value
  //                                                                         .status!) {
  //                                                                       ConstantMethods.showSnackbar(
  //                                                                           context,
  //                                                                           "${data.data?.wishlist?[index].title} Added To Bag");
  //                                                                       ref.watch(wishlistProvider.notifier).removeFromWishlist(
  //                                                                           index);
  //                                                                     } else {
  //                                                                       ConstantMethods.showSnackbar(
  //                                                                           context,
  //                                                                           value.message ??
  //                                                                               "");
  //                                                                     }
  //                                                                   });
  //                                                                 }
  //                                                               },
  //                                                               icon: SvgPicture
  //                                                                   .asset(
  //                                                                       "assets/images/move_to_cart.svg"))
  //                                                         ],
  //                                                       )
  //                                                     ],
  //                                                   ),
  //                                                 ),
  //                                                 Divider(
  //                                                   height: 0.3,
  //                                                 ),
  //                                                 SizedBox(
  //                                                   height: 12.sp,
  //                                                 )
  //                                               ],
  //                                             );
  //                                           },
  //                                         )
  //                                       : Padding(
  //                                           padding: EdgeInsets.symmetric(
  //                                               horizontal: 16.0.sp),
  //                                           child: Column(
  //                                             children: [
  //                                               SizedBox(
  //                                                 height: 14.sp,
  //                                               ),
  //                                               SvgPicture.asset(
  //                                                 "${Constants.imagePath}wishlist.svg",
  //                                                 height: 24.sp,
  //                                               ),
  //                                               SizedBox(
  //                                                 height: 14.sp,
  //                                               ),
  //                                               Text(
  //                                                 'Nothing Saved...',
  //                                                 style: AppTheme.lightTheme
  //                                                     .textTheme.headlineLarge
  //                                                     ?.copyWith(
  //                                                         fontSize: 18.sp),
  //                                               ),
  //                                               SizedBox(
  //                                                 height: 11.sp,
  //                                               ),
  //                                               Text(
  //                                                 '... no worries. Join to start saving, or sign in to see what you’ve already saved. Exploring made way easy.',
  //                                                 textAlign: TextAlign.center,
  //                                                 style: AppTheme.lightTheme
  //                                                     .textTheme.bodySmall
  //                                                     ?.copyWith(
  //                                                         fontSize: 14.sp),
  //                                               ),
  //                                               SizedBox(
  //                                                 height: 24.sp,
  //                                               ),
  //                                               Container(
  //                                                 width: ScreenUtil()
  //                                                     .setWidth(150),
  //                                                 height: ScreenUtil()
  //                                                     .setHeight(36),
  //                                                 padding: const EdgeInsets
  //                                                     .symmetric(
  //                                                     horizontal: 24,
  //                                                     vertical: 9),
  //                                                 decoration: ShapeDecoration(
  //                                                   color: Color(0xFF393939),
  //                                                   shape:
  //                                                       RoundedRectangleBorder(
  //                                                           borderRadius:
  //                                                               BorderRadius
  //                                                                   .circular(
  //                                                                       8)),
  //                                                 ),
  //                                                 child: Text(
  //                                                   'Start Exploring',
  //                                                   textAlign: TextAlign.center,
  //                                                   style: AppTheme.lightTheme
  //                                                       .textTheme.titleMedium
  //                                                       ?.copyWith(
  //                                                           color: AppTheme
  //                                                               .appBarAndBottomBarColor,
  //                                                           fontSize: 14.sp),
  //                                                 ),
  //                                               ),
  //                                               SizedBox(
  //                                                 height: 50.sp,
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         );
  //                                 case false:
  //                                   return Padding(
  //                                     padding: EdgeInsets.symmetric(
  //                                         horizontal: 16.0.sp),
  //                                     child: Column(
  //                                       children: [
  //                                         SizedBox(
  //                                           height: 14.sp,
  //                                         ),
  //                                         Text(
  //                                           'Nothing Saved...',
  //                                           style: AppTheme.lightTheme.textTheme
  //                                               .headlineLarge
  //                                               ?.copyWith(fontSize: 18.sp),
  //                                         ),
  //                                         SizedBox(
  //                                           height: 11.sp,
  //                                         ),
  //                                         Text(
  //                                           '... no worries. Join to start saving, or sign in to see what you’ve already saved. Exploring made way easy.',
  //                                           textAlign: TextAlign.center,
  //                                           style: AppTheme
  //                                               .lightTheme.textTheme.bodySmall
  //                                               ?.copyWith(fontSize: 14.sp),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   );
  //                                 default:
  //                                   return SizedBox();
  //                               }
  //                             },
  //                             error: (error, stackTrace) {
  //                               print(
  //                                   "Shop List Error: ${stackTrace.toString()}");
  //                               return;
  //                             },
  //                             loading: () {
  //                               final spinkit = SpinKitPumpingHeart(
  //                                 color: AppTheme.appBarAndBottomBarColor,
  //                                 size: ScreenUtil().setHeight(50),
  //                               );
  //                               return Center(child: spinkit);
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ));
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}

class TimelineTile extends StatelessWidget {
  final TimelineStep step;
  final bool isLast;

  const TimelineTile({super.key, required this.step, required this.isLast});

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
