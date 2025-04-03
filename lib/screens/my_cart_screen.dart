import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/cart_list_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/app_bar.dart';
import 'package:dikla_spirit/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyCartScreen extends HookConsumerWidget {
  const MyCartScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCartList = ref.watch(myCartApiProvider);
    final localization = AppLocalizations.of(context);
    final currency = ref.watch(currentCurrencySymbolProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/images/search.svg",
                height: 20.sp,
              )),
          WishlistWidget(),
          SizedBox(
            width: 20.sp,
          )
        ],
        leading: IconButton(
            onPressed: () {
              ref.read(indexOfBottomNavbarProvider.notifier).state = 0;
              context.go('/dashboard');
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        title: Text(
          localization.myBag,
          style: AppTheme.lightTheme.textTheme.bodyLarge
              ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
        ),
        // CustomText(
        //     localization.title, ThemeData.light().textTheme.titleLarge!),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: myCartList.when(
            data: (data) {
              final cart = data.data?.cart ?? [];
              switch (data.status) {
                case true:
                  Future.microtask(
                    () {
                      ref
                          .read(wishlistProvider.notifier)
                          .initializeFavToExploreInCart(
                              data.data?.favourite ?? []);
                    },
                  );
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        cart.isNotEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 24.sp,
                                  ),
                                  Container(
                                    width: ScreenUtil().screenWidth,
                                    // height: ScreenUtil().setHeight(400),
                                    decoration: ShapeDecoration(
                                      color: AppTheme.appBarAndBottomBarColor,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1,
                                            color: AppTheme.strokeColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0.sp),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          // height: ScreenUtil().setHeight(190),
                                          height: cart.length * 100.sp,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: cart.length ?? 0,
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
                                                                imageUrl: cart[
                                                                            index]
                                                                        .productImage ??
                                                                    "",
                                                                height: 72.sp,
                                                                width: 72.sp,
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
                                                                    cart[index]
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
                                                                    '$currency ${cart[index].price.toString() ?? ""}',
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
                                                                  cart[index].quantity !=
                                                                              null &&
                                                                          cart[index].quantity !=
                                                                              0
                                                                      ? Text(
                                                                          "x ${cart[index].quantity.toString()}",
                                                                          style: AppTheme
                                                                              .lightTheme
                                                                              .textTheme
                                                                              .labelMedium
                                                                              ?.copyWith(fontSize: 16.sp),
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
                                                        InkWell(
                                                          child:
                                                              SvgPicture.asset(
                                                            "${Constants.imagePath}cart_remove.svg",
                                                            height: 20.sp,
                                                            width: 20.sp,
                                                          ),
                                                          onTap: () {
                                                            showRemoveFromCart(
                                                                context,
                                                                cart[index],
                                                                localization
                                                                    .moveFromBag);
                                                          },
                                                        )
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
                                        SizedBox(
                                          height: 16.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Subtotal:',
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppTheme
                                                            .teritiaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Text(
                                                "$currency ${data.data?.subtotal.toString() ?? ""}",
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppTheme
                                                            .teritiaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Shipping:',
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppTheme
                                                            .teritiaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Text(
                                                "$currency 0",
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppTheme
                                                            .teritiaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.sp),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Shipping options will be updated during checkout.',
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppTheme
                                                            .teritiaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Estimated Total:',
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppTheme
                                                            .subTextColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Text(
                                                "$currency ${data.data?.total.toString() ?? ""}",
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppTheme
                                                            .subTextColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24.sp,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            bool isContainJewel = cart.any(
                                              (element) =>
                                                  element.template == 3,
                                            );
                                            context.push("/steps", extra: {
                                              "template": isContainJewel
                                            });
                                          },
                                          child: Container(
                                            height:
                                                ScreenUtil().setHeight(60.sp),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Container(
                                                width:
                                                    ScreenUtil().screenWidth *
                                                        0.9,
                                                height: 36.sp,
                                                decoration: ShapeDecoration(
                                                  color: AppTheme.subTextColor,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 1,
                                                        color: AppTheme
                                                            .subTextColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.sp),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    localization.go_to_checkout,
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            color: AppTheme
                                                                .appBarAndBottomBarColor,
                                                            fontSize: 14.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 40.sp,
                                  ),
                                  SvgPicture.asset(
                                    "${Constants.imagePath}cart.svg",
                                    height: 31.sp,
                                  ),
                                  SizedBox(
                                    height: 14.sp,
                                  ),
                                  Text(
                                    'Your Cart is Empty!',
                                    style: AppTheme
                                        .lightTheme.textTheme.headlineLarge
                                        ?.copyWith(fontSize: 18.sp),
                                  ),
                                  SizedBox(
                                    height: 11.sp,
                                  ),
                                  Text(
                                    'Cart’s empty! Time to explore our treasures and find something special just for you',
                                    textAlign: TextAlign.center,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(fontSize: 14.sp),
                                  ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                  Container(
                                    width: 170.sp,
                                    height: 36.sp,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.sp, vertical: 9.sp),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF393939),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Start Exploring',
                                          textAlign: TextAlign.center,
                                          style: AppTheme
                                              .lightTheme.textTheme.titleMedium
                                              ?.copyWith(
                                                  color: AppTheme
                                                      .appBarAndBottomBarColor,
                                                  fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 55.sp,
                                  ),
                                ],
                              ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0.sp),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Favorites to Explore',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(fontSize: 18.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.sp,
                        ),
                        HomeFastResultsWidget(data.data?.favourite ?? [],
                            WishListType.favToExploreInCart),
                        SizedBox(
                          height: 60.sp,
                        ),
                      ],
                    ),
                  );

                case false:
                  if (data.statusCode == 402) {
                    refreshToken(ref);
                  }
                  Future.microtask(
                    () {
                      ref
                          .read(wishlistProvider.notifier)
                          .initializeFavToExploreInCart(
                              data.data?.favourite ?? []);
                    },
                  );
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.sp,
                          ),
                          SvgPicture.asset(
                            "${Constants.imagePath}cart.svg",
                            height: 31.sp,
                          ),
                          SizedBox(
                            height: 14.sp,
                          ),
                          Text(
                            'Your Cart is Empty!',
                            style: AppTheme.lightTheme.textTheme.headlineLarge
                                ?.copyWith(fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 11.sp,
                          ),
                          Text(
                            'Cart’s empty! Time to explore our treasures and find something special just for you',
                            textAlign: TextAlign.center,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Container(
                            width: 170.sp,
                            height: 36.sp,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.sp, vertical: 9.sp),
                            decoration: ShapeDecoration(
                              color: Color(0xFF393939),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Start Exploring',
                                  textAlign: TextAlign.center,
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 55.sp,
                          ),
                        ],
                      ));
                default:
                  return SizedBox();
              }
            },
            error: (error, stackTrace) {
              SchedulerBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  ConstantMethods.showSnackbar(context, error.toString());
                },
              );
              return ConstantMethods.buildErrorUI(
                ref,
                onPressed: () {
                  ref.watch(myCartApiProvider);
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
          )),
    );
  }

  showRemoveFromCart(
      BuildContext context, CartListModelDataCart cart, String title) {
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
              height: ScreenUtil().setHeight(215),
              child: Column(
                children: [
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
                        title,
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
                  Padding(
                      padding: EdgeInsets.only(top: 10.0.sp),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6.sp),
                                  child: CachedNetworkImage(
                                    imageUrl: cart.productImage ?? "",
                                    height: 55.sp,
                                    width: 55.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 14.sp,
                                ),
                                Text(
                                  'Are you sure you want to move the items\nfrom bag?',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 23.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            ref
                                .watch(removeFromCartApiProvider(
                                        cart.cartItemKey ?? "")
                                    .future)
                                .then((onValue) {
                              if (onValue.status!) {
                                context.pop();
                                if (context.mounted) {
                                  ref.invalidate(myCartApiProvider);
                                  ConstantMethods.showSnackbar(
                                      context, onValue.message ?? "");
                                }
                              } else {
                                if (context.mounted) {
                                  ConstantMethods.showSnackbar(
                                      context, onValue.message ?? "",
                                      isFalse: true);
                                }
                              }
                            });
                          },
                          child: Container(
                            width: ScreenUtil().screenWidth / 2.3,
                            height: 38.sp,
                            decoration: ShapeDecoration(
                              color: AppTheme.appBarAndBottomBarColor,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: AppTheme.subTextColor),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Remove',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // ref
                            //     .read(addTowishListApiProvider(
                            //             cart.variationId.toString())
                            //         .future)
                            //     .then((onValue) {
                            //   if (context.mounted) {
                            //     context.pop();
                            //     if (onValue != null && onValue.id != null) {
                            //       ConstantMethods.showSnackbar(context,
                            //           "Product moved to wishlist successfully");

                            //       return ref.refresh(myCartApiProvider);
                            //     }
                            //     // } else {
                            //     //   if (context.mounted) {
                            //     //     ConstantMethods.showSnackbar(
                            //     //         context, onValue.message ?? "",
                            //     //         isFalse: true);
                            //     //   }
                            //   }
                            // });
                            context.pop();
                            ConstantMethods.showSnackbar(
                                context, "Working On It.");
                          },
                          child: Container(
                            width: ScreenUtil().screenWidth / 2.3,
                            height: 38.sp,
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
                                'Move to Wishlist',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans Hebrew',
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  refreshToken(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(myCartApiProvider);
  }
}
