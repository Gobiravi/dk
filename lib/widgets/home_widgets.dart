import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeMenuWidget extends StatelessWidget {
  final List<DashboardModelMenu> menuModel;
  const HomeMenuWidget(this.menuModel, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(60.0),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0.sp),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menuModel.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(top: 14.sp, bottom: 15.0.sp, right: 8.sp),
              child: InkWell(
                onTap: () {
                  if (menuModel[index].type == "taxonomy") {
                    context.go("/product", extra: {
                      "id": menuModel[index].id,
                      "name": menuModel[index].title ?? ""
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.20, color: AppTheme.strokeColor),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Center(
                    child: CustomText(menuModel[index].title ?? "",
                        AppTheme.lightTheme.textTheme.bodyMedium!),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeBestSellingWidget extends ConsumerStatefulWidget {
  final List<DashboardModeTopbanner> bestSellingModel;
  const HomeBestSellingWidget(this.bestSellingModel, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeBestSellingWidget();
  }
}

class _HomeBestSellingWidget extends ConsumerState<HomeBestSellingWidget> {
  late PageController pageController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (ref.read(indexOfPageViewInHomeBestSelling) ==
            widget.bestSellingModel.length - 1) {
          pageController.jumpToPage(0);
        } else {
          pageController.nextPage(
              duration: const Duration(seconds: 1), curve: Curves.easeIn);
        }
      },
    );
    pageController = PageController(viewportFraction: 0.85);
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
    ref.watch(indexOfPageViewInHomeBestSelling.notifier);
    return SizedBox(
        height: ScreenUtil().setHeight(350),
        width: ScreenUtil().screenWidth,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.bestSellingModel.length,
                padEnds: false,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  ref.read(indexOfPageViewInHomeBestSelling.notifier).state =
                      value;
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0.sp),
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().setHeight(332),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                        color: AppTheme.appBarAndBottomBarColor,
                      ),
                      // margin: EdgeInsets.symmetric(horizontal: 10.0.sp),
                      child: Column(children: [
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              context.go("/product", extra: {
                                "id": widget.bestSellingModel[index].redirect,
                                "name":
                                    widget.bestSellingModel[index].heading ?? ""
                              });
                            },
                            child: SizedBox.expand(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.sp),
                                    topRight: Radius.circular(12.sp)),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      widget.bestSellingModel[index].imageUrl ??
                                          "",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                      width: ScreenUtil().setWidth(20),
                                      child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        strokeWidth: 1.0,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.sp),
                            child: SizedBox(
                              width: ScreenUtil().setWidth(300),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.bestSellingModel[index].heading ??
                                        "",
                                    style: AppTheme
                                        .lightTheme.textTheme.labelMedium!
                                        .copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 17.sp),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    widget.bestSellingModel[index].content ??
                                        "",
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall!,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(8),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.go("/product", extra: {
                                        "id": widget
                                            .bestSellingModel[index].redirect,
                                        "name": widget.bestSellingModel[index]
                                                .heading ??
                                            ""
                                      });
                                    },
                                    child: Text(
                                      localization.shopNow,
                                      style: AppTheme
                                          .lightTheme.textTheme.labelMedium!
                                          .copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14.sp,
                                              color: AppTheme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.0.sp),
                child: SizedBox(
                  child: SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: widget.bestSellingModel.length ?? 0,
                      effect: ExpandingDotsEffect(
                          activeDotColor: AppTheme.primaryColor,
                          dotHeight: 8.sp,
                          dotWidth: 8.0.sp,
                          dotColor: AppTheme.primaryColor
                              .withOpacity(0.41)), // your preferred effect
                      onDotClicked: (index) {
                        if (widget.bestSellingModel != null &&
                            widget.bestSellingModel.isNotEmpty) {
                          pageController.jumpToPage(index);
                        }
                      }),
                ),
              ),
            )
          ],
        ));
  }
}

class HomeFastResultsWidget extends ConsumerWidget {
  final List<DashboardModelFastResult> fastResults;
  final WishListType type;

  const HomeFastResultsWidget(this.fastResults, this.type, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the wishlist state
    final wishlistState = ref.watch(wishlistProvider);
    final currencySymbol = ref.watch(currentCurrencySymbolProvider);
    // Read the wishlist notifier to perform actions
    // final wishlistNotifier = ref.read(wishlistProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(left: 16.0.sp),
      child: SizedBox(
        height: ScreenUtil().setHeight(270.0),
        width: ScreenUtil().screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: fastResults.length,
          itemBuilder: (context, index) {
            // Fetch the corresponding item from the updated state
            final item = type == WishListType.fast
                ? wishlistState.fastResults.isNotEmpty
                    ? wishlistState.fastResults[index]
                    : fastResults[index]
                : type == WishListType.quick
                    ? wishlistState.quickSolutions.isNotEmpty
                        ? wishlistState.quickSolutions[index]
                        : fastResults[index]
                    : type == WishListType.favToExploreInCart
                        ? wishlistState.favToExploreInCart.isNotEmpty
                            ? wishlistState.favToExploreInCart[index]
                            : fastResults[index]
                        : type == WishListType.favToExploreInWishList
                            ? wishlistState.favToExploreInWishList.isNotEmpty
                                ? wishlistState.favToExploreInWishList[index]
                                : fastResults[index]
                            : type == WishListType.youMayLikeThis
                                ? wishlistState
                                        .youMayAlsoLikeThisInWishList.isNotEmpty
                                    ? wishlistState
                                        .youMayAlsoLikeThisInWishList[index]
                                    : fastResults[index]
                                : type == WishListType.productDetailFastResult
                                    ? wishlistState
                                            .productDetailFastResult.isNotEmpty
                                        ? wishlistState
                                            .productDetailFastResult[index]
                                        : fastResults[index]
                                    : type == WishListType.searchRecentPurchase
                                        ? wishlistState
                                                .searchRecentPurchase.isNotEmpty
                                            ? wishlistState
                                                .searchRecentPurchase[index]
                                            : fastResults[index]
                                        : type ==
                                                WishListType
                                                    .shopBestSellingWishlist
                                            ? wishlistState
                                                    .shopBestSellingWishlist
                                                    .isNotEmpty
                                                ? wishlistState
                                                        .shopBestSellingWishlist[
                                                    index]
                                                : fastResults[index]
                                            : wishlistState
                                                    .productDetailYouMayLikeThis
                                                    .isNotEmpty
                                                ? wishlistState
                                                        .productDetailYouMayLikeThis[
                                                    index]
                                                : fastResults[index];

            return Padding(
              padding: EdgeInsets.only(right: 8.sp),
              child: InkWell(
                onTap: () {
                  //  final router = GoRouter.of(context);
                  //  if (router.location.startsWith('/shell')) { }
                  context.goNamed("product_detail", extra: {
                    "id": item.id.toString(),
                    "isMoonJewelry": false,
                    "name": item.title ?? ""
                  });
                },
                child: Container(
                  width: ScreenUtil().setWidth(160),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                    color: AppTheme.appBarAndBottomBarColor,
                    border: Border.all(
                      color: AppTheme.strokeColor,
                    ),
                  ),
                  // margin: EdgeInsets.symmetric(horizontal: 4.0.sp),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.sp),
                              topRight: Radius.circular(12.sp)),
                          child: SizedBox.expand(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: item.image ?? "",
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
                                      Center(child: const Icon(Icons.error)),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0.sp, top: 10.sp),
                                    child: InkWell(
                                      onTap: () {
                                        ConstantMethods.toggleWishlist(
                                            type, ref,
                                            index: index);
                                      },
                                      child: SvgPicture.asset(
                                        item.isWishlist!
                                            ? "${Constants.imagePath}heart_filled.svg"
                                            : "${Constants.imagePath}add_to_wish.svg",
                                        height: 16.sp,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0.sp,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RatingStars(
                                      value: item.rating!.isNotEmpty
                                          ? double.parse(
                                              item.rating.toString() ?? "0.0")
                                          : 0.0,
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
                                      starSize: ScreenUtil().setSp(18),
                                      // maxValue: 5,
                                      starSpacing: 2,
                                      valueLabelVisibility: false,
                                      animationDuration:
                                          Duration(milliseconds: 1000),
                                      starOffColor: AppTheme.strokeColor,
                                      starColor: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "(${item.ratingCount ?? ""})",
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  item.title ?? "",
                                  style: AppTheme
                                      .lightTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text('$currencySymbol ${item.price ?? ""}',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0.sp,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeElevateExperienceWidget extends ConsumerStatefulWidget {
  const HomeElevateExperienceWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeElevateExperienceWidget();
  }
}

class _HomeElevateExperienceWidget
    extends ConsumerState<HomeElevateExperienceWidget> {
  List<ElevateExperienceModel>? model;
  @override
  void initState() {
    super.initState();
    model = ElevateExperienceModel().addData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(120.0),
      width: ScreenUtil().screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                width: ScreenUtil().setWidth(320.0),
                height: ScreenUtil().setHeight(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.appBarAndBottomBarColor,
                  border: Border.all(
                    color: AppTheme.strokeColor,
                    // width: 0.3,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        model![index].img ?? "",
                        height:
                            ScreenUtil().setHeight(46), // Ensure proper sizing
                        width: ScreenUtil().setWidth(46),
                      ),
                      const SizedBox(
                          width: 16), // Add spacing between the icon and text
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              model![index].title ?? "",
                              style: AppTheme.lightTheme.textTheme
                                  .labelMedium, // Handle long text gracefully
                            ),
                            Text(
                              model![index].desc ?? "",
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                              // Handle long text gracefully
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeMoreFromDiklaWidget extends ConsumerStatefulWidget {
  List<DashboardModlMoreFrom> moreFromModel;
  HomeMoreFromDiklaWidget(this.moreFromModel, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeMoreFromDiklaWidget();
  }
}

class _HomeMoreFromDiklaWidget extends ConsumerState<HomeMoreFromDiklaWidget> {
  late PageController pageController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (ref.read(indexOfPageViewInHomeMoreFrom) ==
            widget.moreFromModel.length - 1) {
          pageController.jumpToPage(0);
        } else {
          pageController.nextPage(
              duration: const Duration(seconds: 1), curve: Curves.easeIn);
        }
      },
    );
    pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
      child: SizedBox(
        height: ScreenUtil().setHeight(510),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(478),
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.moreFromModel.length,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  ref.read(indexOfPageViewInHomeMoreFrom.notifier).state =
                      value;
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 4.0.sp),
                    child: InkWell(
                      onTap: () {
                        context.go("/product_Detail", extra: {
                          "id": widget.moreFromModel[index].redirect,
                          "name": widget.moreFromModel[index].title ?? ""
                        });
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(478),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.moreFromModel[index].imageUrl ?? "",
                                height: ScreenUtil().setHeight(478),
                                width: ScreenUtil().screenWidth,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.moreFromModel[index].title ?? "",
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: AppTheme
                                                .appBarAndBottomBarColor),
                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  ),
                                  Text(
                                    widget.moreFromModel[index].title ?? "",
                                    style: AppTheme
                                        .lightTheme.textTheme.headlineLarge!
                                        .copyWith(
                                            color: AppTheme
                                                .appBarAndBottomBarColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 22.0.sp,
            ),
            SmoothPageIndicator(
                controller: pageController, // PageController
                count: widget.moreFromModel.length ?? 0,
                effect: ExpandingDotsEffect(
                    activeDotColor: AppTheme.primaryColor,
                    dotHeight: 8.sp,
                    dotWidth: 8.0,
                    dotColor: AppTheme.primaryColor
                        .withOpacity(0.41)), // your preferred effect
                onDotClicked: (index) {
                  if (widget.moreFromModel != null &&
                      widget.moreFromModel.isNotEmpty) {
                    pageController.jumpToPage(index);
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class HomeBestSellingServiceWidget extends ConsumerWidget {
  List<DashboardModelBestSelling> bestSelling;
  HomeBestSellingServiceWidget(this.bestSelling, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: ScreenUtil().setHeight(280.0),
      width: ScreenUtil().screenWidth,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0.sp),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bestSelling.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 10.0.sp),
              child: InkWell(
                onTap: () {
                  context.go("/product_Detail", extra: {
                    "id": bestSelling[index].id.toString(),
                    "name": bestSelling[index].title ?? ""
                  });
                },
                child: SizedBox(
                  width: ScreenUtil().setWidth(190),
                  height: ScreenUtil().setHeight(223),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // width: ScreenUtil().setWidth(190),
                        // height: ScreenUtil().setHeight(223),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            color: AppTheme.appBarAndBottomBarColor,
                            border: Border.all(
                              color: AppTheme.strokeColor,
                              // width: 0.3,
                            )),
                        // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(8))),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: bestSelling[index].image ?? "",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: SizedBox(
                                height: ScreenUtil().setHeight(20),
                                width: ScreenUtil().setWidth(20),
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0.sp),
                        child: Text(
                          bestSelling[index].title ?? "",
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          bestSelling[index].title ?? "",
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeReviewListWidget extends ConsumerStatefulWidget {
  List<DashboardModelReview> reviews;
  HomeReviewListWidget(this.reviews, {super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeReviewListWidget();
  }
}

class _HomeReviewListWidget extends ConsumerState<HomeReviewListWidget> {
  // List<DashboardModelReview> reviews;

  late PageController pageController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.reviews != null && widget.reviews.isNotEmpty) {
      pageController = PageController(initialPage: 0);
      timer = Timer.periodic(
        const Duration(seconds: 4),
        (timer) {
          if (ref.read(indexOfPageViewInHomeReview) ==
              widget.reviews.length - 1) {
            pageController.jumpToPage(0);
          } else {
            pageController.nextPage(
                duration: const Duration(seconds: 1), curve: Curves.easeIn);
          }
        },
      );
    }
    pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final localization = AppLocalizations.of(context);
    return SizedBox(
      height: ScreenUtil().setHeight(200),
      width: ScreenUtil().screenWidth,
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(166),
            width: ScreenUtil().screenWidth,
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.reviews.length,
              pageSnapping: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                ref.read(indexOfPageViewInHomeReview.notifier).state = value;
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10.0.sp, right: 10.sp),
                  child: Container(
                    width: ScreenUtil().screenWidth * 0.9,
                    height: ScreenUtil().setHeight(160),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppTheme.appBarAndBottomBarColor,
                      border: Border.all(
                        color: AppTheme.strokeColor,
                        // width: 0.3,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                      child: Row(
                        children: [
                          SizedBox(
                            width: ScreenUtil().setWidth(139),
                            height: ScreenUtil().setHeight(141),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.sp),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.reviews[index].image ?? "",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(20),
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  16), // Add spacing between the icon and text
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text to the left
                              children: [
                                SizedBox(
                                  height: 22.sp,
                                ),
                                RatingStars(
                                  value: double.parse(
                                      widget.reviews[index].rating.toString() ??
                                          "0.0"),
                                  onValueChanged: (v) {
                                    //
                                  },
                                  starBuilder: (index, color) => ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        color!, BlendMode.srcIn),
                                    child: SvgPicture.asset(
                                        "${Constants.imagePath}empty_star.svg"),
                                  ),
                                  starCount: 5,
                                  starSize: ScreenUtil().setSp(20),
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
                                Text(
                                  widget.reviews[index].review ?? "",
                                  maxLines: 5,
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                          overflow: TextOverflow
                                              .ellipsis), // Handle long text gracefully
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 18.0.sp,
          ),
          SmoothPageIndicator(
              controller: pageController, // PageController
              count: widget.reviews.length ?? 0,
              effect: ExpandingDotsEffect(
                  activeDotColor: AppTheme.primaryColor,
                  dotHeight: 8.sp,
                  dotWidth: 8.0,
                  dotColor: AppTheme.primaryColor
                      .withOpacity(0.41)), // your preferred effect
              onDotClicked: (index) {
                if (widget.reviews != null && widget.reviews.isNotEmpty) {
                  pageController.jumpToPage(index);
                }
              }),
        ],
      ),
    );
  }
}

class HomeQuickSolutionstsWidget extends ConsumerWidget {
  final List<DashboardModelFastResult> quickSolutions;
  const HomeQuickSolutionstsWidget(this.quickSolutions, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the wishlist state
    final wishlistState = ref.watch(wishlistProvider);
    final currencySymbol = ref.watch(currentCurrencySymbolProvider);
    // Read the wishlist notifier to perform actions
    final wishlistNotifier = ref.read(wishlistProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
      child: SizedBox(
        height: ScreenUtil().setHeight(270.0),
        width: ScreenUtil().screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: quickSolutions.length,
          itemBuilder: (context, index) {
            // Fetch the corresponding item from the updated state
            final item = wishlistState.quickSolutions.isNotEmpty
                ? wishlistState.quickSolutions[index]
                : quickSolutions[index];
            return Padding(
              padding: EdgeInsets.only(right: 8.0.sp),
              child: InkWell(
                onTap: () {
                  context.go("/product_detail", extra: {
                    "id": item.id.toString(),
                    "isMoonJewelry": false,
                    "name": item.title ?? ""
                  });
                },
                child: Container(
                    width: ScreenUtil().setWidth(160),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                        color: AppTheme.appBarAndBottomBarColor,
                        border: Border.all(
                          color: AppTheme.strokeColor,
                          // width: 0.3,
                        )),
                    // margin: EdgeInsets.symmetric(horizontal: 10.0.sp),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.sp),
                                topRight: Radius.circular(12.sp)),
                            child: SizedBox.expand(
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: item.image ?? "",
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
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.0.sp, top: 10.sp),
                                      child: InkWell(
                                        onTap: () {
                                          ConstantMethods.toggleWishlist(
                                              WishListType.quick, ref,
                                              index: index);
                                        },
                                        child: SvgPicture.asset(
                                          item.isWishlist!
                                              ? "${Constants.imagePath}heart_filled.svg"
                                              : "${Constants.imagePath}add_to_wish.svg",
                                          height: 16.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0.sp,
                        ),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        RatingStars(
                                          value: double.parse(
                                              item.rating.toString() ?? "0.0"),
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
                                          starSize: ScreenUtil().setSp(20),
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
                                          width: 8,
                                        ),
                                        Text(
                                          "(${item.ratingCount ?? ""})",
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      item.title ?? "",
                                      style: AppTheme
                                          .lightTheme.textTheme.bodyMedium
                                          ?.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text('$currencySymbol ${item.price ?? ""}',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 12.0.sp,
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeGuidanceWidget extends StatefulWidget {
  const HomeGuidanceWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeGuidanceWidget();
  }
}

class _HomeGuidanceWidget extends State<HomeGuidanceWidget> {
  List<GuidanceModel> model = [];
  @override
  void initState() {
    super.initState();
    model = GuidanceModel().addData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: ScreenUtil().setHeight(122),
        width: ScreenUtil().screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 8.0.sp),
              child: Container(
                width: ScreenUtil().setWidth(95),
                height: ScreenUtil().setHeight(122),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  shadows: [
                    BoxShadow(
                      color: AppTheme.shadowColor,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          model[index].title ?? "",
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(model[index].img ?? ""))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   return SizedBox(
//     height: ScreenUtil().setHeight(180.0),
//     width: ScreenUtil().screenWidth,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: reviews.length,
//         itemBuilder: (context, index) {
//           return
//         },
//       ),
//     ),
//   );
// }

class ElevateExperienceModel {
  String? title;
  String? desc;
  String? img;
  ElevateExperienceModel({this.title, this.desc, this.img});

  List<ElevateExperienceModel> addData() {
    List<ElevateExperienceModel> model = [
      ElevateExperienceModel(
          title: "Your data is protected",
          desc:
              "Your privacy is our top prioirity. We’ll never sell your data and you can delete it at anytime",
          img: "${Constants.imagePathHome}verified.png"),
      ElevateExperienceModel(
          img: "${Constants.imagePathHome}fire.png",
          title: "Do you want to date \nwith someone",
          desc: "Subscribe for enchanting spells and mystical tips")
    ];
    return model;
  }
}

class GuidanceModel {
  String? title;
  String? desc;
  String? img;
  GuidanceModel({this.title, this.desc, this.img});

  List<GuidanceModel> addData() {
    List<GuidanceModel> model = [
      GuidanceModel(
          title: "Ideal Spell \nSelection",
          desc: "",
          img: "assets/images/home/star_home.svg"),
      GuidanceModel(
          img: "assets/images/home/faq_home.svg",
          title: "How it works?",
          desc: ""),
      GuidanceModel(
          img: "assets/images/home/chat_home.svg",
          title: "Chat with\nDikla",
          desc: ""),
      GuidanceModel(
          img: "assets/images/home/trending_home.svg",
          title: "Trending",
          desc: "")
    ];
    return model;
  }
}
