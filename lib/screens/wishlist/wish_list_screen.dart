import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WishListScreen extends HookConsumerWidget {
  const WishListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishListData = ref.watch(wishListApiProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/images/search.svg",
                height: 20.sp,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        title: Text(
          'Wishlist',
          style: AppTheme.lightTheme.textTheme.labelMedium,
        ),
        // CustomText(
        //     localization.title, ThemeData.light().textTheme.titleLarge!),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: wishListData.when(
            data: (data) {
              switch (data.status) {
                case true:
                  // final wishlistState = ref.watch(wishlistProvider);
                  Future.microtask(
                    () {
                      ref
                          .read(wishlistProvider.notifier)
                          .initializeWishList(data.data?.wishlist ?? []);
                      ref
                          .read(wishlistProvider.notifier)
                          .initializeFavToExploreInWishList(
                              data.data?.youMayLike ?? []);
                    },
                  );

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        data.data!.wishlist != null
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 14.0.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Sort By',
                                            style: AppTheme
                                                .lightTheme.textTheme.labelSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppTheme.primaryColor)),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17.sp,
                                  ),
                                  ConstantMethods.customDivider(),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 26.sp,
                        ),
                        data.data!.wishlist == null
                            ? Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.0.sp),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 14.sp,
                                    ),
                                    SvgPicture.asset(
                                      "${Constants.imagePath}wishlist.svg",
                                      height: 24.sp,
                                    ),
                                    SizedBox(
                                      height: 14.sp,
                                    ),
                                    Text(
                                      'Nothing Saved...',
                                      style: AppTheme
                                          .lightTheme.textTheme.headlineLarge
                                          ?.copyWith(fontSize: 18.sp),
                                    ),
                                    SizedBox(
                                      height: 11.sp,
                                    ),
                                    Text(
                                      '... no worries. Join to start saving, or sign in to see what you’ve already saved. Exploring made way easy.',
                                      textAlign: TextAlign.center,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(fontSize: 14.sp),
                                    ),
                                    SizedBox(
                                      height: 24.sp,
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(150),
                                      height: ScreenUtil().setHeight(36),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 9),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF393939),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Text(
                                        'Start Exploring',
                                        textAlign: TextAlign.center,
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                                color: AppTheme
                                                    .appBarAndBottomBarColor,
                                                fontSize: 14.sp),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.sp,
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: SizedBox(
                                  // height: ScreenUtil().setHeight(350),
                                  // height: data.data!.wishlist!.length * 205.sp,
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 18.sp,
                                            crossAxisSpacing: 19.sp,
                                            childAspectRatio: 0.65),
                                    scrollDirection: Axis.vertical,
                                    itemCount: data.data?.wishlist?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final wishList = data.data != null &&
                                              data.data?.wishlist != null
                                          ? data.data?.wishlist![index]
                                          : DashboardModelFastResult();
                                      return InkWell(
                                        onTap: () {
                                          // context.push("/product_detail", extra: {
                                          //   "id": data.data?.wishlist![index].id.toString(),
                                          //   "isMoonJewelry": false
                                          // });
                                        },
                                        child: Container(
                                            // width: ScreenUtil().setWidth(250),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.sp)),
                                                color: AppTheme
                                                    .appBarAndBottomBarColor,
                                                border: Border.all(
                                                  color: AppTheme.strokeColor,
                                                  // width: 0.3,
                                                )),
                                            // margin: EdgeInsets.symmetric(
                                            //     horizontal: 10.0.sp),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12.0)),
                                                        child: SizedBox.expand(
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl: data
                                                                    .data
                                                                    ?.wishlist![
                                                                        index]
                                                                    .image ??
                                                                "",
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        downloadProgress) =>
                                                                    Center(
                                                              child: SizedBox(
                                                                height:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            20),
                                                                width:
                                                                    ScreenUtil()
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
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12.0.sp,
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: SizedBox(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      9.0.sp),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  RatingStars(
                                                                    value: double.parse(wishList
                                                                            ?.rating
                                                                            .toString() ??
                                                                        "0.0"),
                                                                    onValueChanged:
                                                                        (v) {
                                                                      //
                                                                    },
                                                                    starBuilder:
                                                                        (index, color) =>
                                                                            ColorFiltered(
                                                                      colorFilter: ColorFilter.mode(
                                                                          color!,
                                                                          BlendMode
                                                                              .srcIn),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                              "${Constants.imagePath}empty_star.svg"),
                                                                    ),
                                                                    starCount:
                                                                        5,
                                                                    starSize: ScreenUtil()
                                                                        .setSp(
                                                                            20),
                                                                    maxValue: 5,
                                                                    starSpacing:
                                                                        2,
                                                                    valueLabelVisibility:
                                                                        false,
                                                                    maxValueVisibility:
                                                                        true,
                                                                    animationDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                1000),
                                                                    starOffColor:
                                                                        AppTheme
                                                                            .strokeColor,
                                                                    starColor:
                                                                        AppTheme
                                                                            .primaryColor,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "(${wishList?.ratingCount ?? ""})", //(${fastResults[index].ratingCount ?? ""})",
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppTheme
                                                                          .subTextColor,
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontFamily:
                                                                          'NotoSansHebrew',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      letterSpacing:
                                                                          0.20,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Text(
                                                                wishList?.title ??
                                                                    "",
                                                                style: AppTheme
                                                                    .lightTheme
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                maxLines: 1,
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Text(
                                                                  "\$ ${wishList?.price}", //'${fastResults[index].symbol ?? ""} ${fastResults[index].price ?? ""}',
                                                                  style: AppTheme
                                                                      .lightTheme
                                                                      .textTheme
                                                                      .bodyMedium),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 6.sp,
                                                            ),
                                                            ConstantMethods
                                                                .customDivider(
                                                                    width: 0.3),
                                                            TextButton(
                                                              onPressed: () {
                                                                if (wishList
                                                                        ?.type ==
                                                                    "variable") {
                                                                  if (wishList
                                                                          ?.variation !=
                                                                      null) {
                                                                    ConstantMethods.showVariation(
                                                                        context,
                                                                        wishList?.variation ??
                                                                            [],
                                                                        wishList?.template ==
                                                                                3
                                                                            ? "Select Color"
                                                                            : "Strength level to choose form",
                                                                        wishList?.template ??
                                                                            0,
                                                                        wishList?.title ??
                                                                            "");
                                                                  }
                                                                } else {
                                                                  ref
                                                                      .refresh(addToCartApiProvider(wishList?.id.toString() ??
                                                                              "0")
                                                                          .future)
                                                                      .then(
                                                                          (value) {
                                                                    if (value
                                                                        .status!) {
                                                                      ConstantMethods.showSnackbar(
                                                                          context,
                                                                          "${data.data?.wishlist?[index].title} Added To Bag");
                                                                      ref
                                                                          .watch(wishlistProvider
                                                                              .notifier)
                                                                          .removeFromWishlist(
                                                                              index);
                                                                    } else {
                                                                      ConstantMethods.showSnackbar(
                                                                          context,
                                                                          value.message ??
                                                                              "");
                                                                    }
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                'Add To Bag',
                                                                style: AppTheme
                                                                    .lightTheme
                                                                    .textTheme
                                                                    .labelSmall
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppTheme
                                                                            .primaryColor),
                                                              ),
                                                            ),
                                                            // SizedBox(
                                                            //   height: 12.sp,
                                                            // )
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.0.sp,
                                                        top: 10.sp),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Toggle the wishlist state
                                                        // wishlistNotifier.toggleWishlist(
                                                        //     WishListType.fast, index);
                                                        ConstantMethods
                                                            .toggleWishlist(
                                                                WishListType
                                                                    .wishList,
                                                                ref,
                                                                index: index);
                                                      },
                                                      child: SvgPicture.asset(
                                                        data
                                                                .data!
                                                                .wishlist![
                                                                    index]
                                                                .isWishlist!
                                                            ? "${Constants.imagePath}heart_filled.svg"
                                                            : "${Constants.imagePath}add_to_wish.svg",
                                                        height: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 39.sp,
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
                        HomeFastResultsWidget(data.data?.youMayLike ?? [],
                            WishListType.favToExploreInWishList),
                        SizedBox(
                          height: 60.sp,
                        ),
                      ],
                    ),
                  );

                case false:
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 14.sp,
                        ),
                        Text(
                          'Nothing Saved...',
                          style: TextStyle(
                            color: Color(0xFF393939),
                            fontSize: 18,
                            fontFamily: 'Noto Sans Hebrew',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 11.sp,
                        ),
                        Text(
                          '... no worries. Join to start saving, or sign in to see what you’ve already saved. Exploring made way easy.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF393939),
                            fontSize: 14,
                            fontFamily: 'Noto Sans Hebrew',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Container(
                          width: 149.sp,
                          height: 36.sp,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 9),
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
                              SizedBox(
                                width: 101,
                                child: Text(
                                  'Start Exploring',
                                  textAlign: TextAlign.center,
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.sp,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Favorites to Explore',
                            style: TextStyle(
                              color: Color(0xFFC1768D),
                              fontSize: 18,
                              fontFamily: 'Noto Sans Hebrew',
                              fontWeight: FontWeight.w400,
                              height: 0.07,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.sp,
                        ),
                        HomeFastResultsWidget(data.data?.youMayLike ?? [],
                            WishListType.favToExploreInWishList),
                        SizedBox(
                          height: 60.sp,
                        ),
                      ],
                    ),
                  );
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
              return;
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
}
