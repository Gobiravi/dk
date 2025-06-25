import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/product_filter_opt_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/product/notifier/product_cat_notifier.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/app_bar.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:dikla_spirit/widgets/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCategoryListScreen extends StatefulHookConsumerWidget {
  final String id;
  final String name;
  const ProductCategoryListScreen(this.id, this.name, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductCategoryListScreenState();
}

class _ProductCategoryListScreenState
    extends ConsumerState<ProductCategoryListScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final notifier =
            ref.read(productCategoryListNotifierProvider(widget.id).notifier);
        notifier.loadMore(widget.id);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    final state = ref.watch(productCategoryListNotifierProvider(widget.id));
    final filterOptions = ref.watch(productFilterOptionsApiProvider(widget.id));
    final notifier =
        ref.read(productCategoryListNotifierProvider(widget.id).notifier);
    final currency = ref.watch(currentCurrencySymbolProvider);
    useEffect(() {
      Future.microtask(
        () {
          notifier.fetchProductCategory(widget.id);
        },
      );
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: ScreenUtil().screenWidth / 2.4,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  ref.read(ratingProvider.notifier).resetSelection();
                  context.goNamed("dashboard");
                },
                icon: Icon(Icons.arrow_back_outlined)),
            SizedBox(
              width: ScreenUtil().screenWidth / 3.5,
              child: Text(
                widget.name,
                style: AppTheme.lightTheme.textTheme.titleMedium
                    ?.copyWith(color: AppTheme.textColor, fontSize: 17.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        title: Image.asset("${Constants.imagePath}logo.png",
            height: ScreenUtil().setHeight(34)),
        actions: [
          IconButton(
              onPressed: () {
                context.push("/search_widget");
              },
              icon: SvgPicture.asset("assets/images/search.svg")),
          WishlistWidget(),
          SizedBox(
            width: 20.sp,
          )
        ],
      ),
      body: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: state.when(
            loaded: (data, status, code) {
              // var products = data.data?.products;
              switch (status) {
                case true:
                  Future.microtask(
                    () {
                      ref
                          .read(wishlistProvider.notifier)
                          .initializeProductCatList(data.products ?? []);
                    },
                  );
                  return Column(
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: data.categoryBanner ?? "",
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
                        height: ScreenUtil().setHeight(80),
                        width: ScreenUtil().screenWidth,
                      ),
                      Row(
                        children: [
                          Container(
                            width: ScreenUtil().screenWidth / 2,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                // start: BorderSide(color: AppTheme.strokeColor),
                                top: BorderSide(color: AppTheme.strokeColor),
                                end: BorderSide(
                                    width: 0.2, color: AppTheme.strokeColor),
                                bottom: BorderSide(
                                    color: AppTheme.strokeColor, width: 0.2),
                              ),
                            ),
                            child: Center(
                              child: TextButton.icon(
                                iconAlignment: IconAlignment.end,
                                onPressed: () {
                                  showModalBottomSheet(
                                      isDismissible: false,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return ProductFilterWidget(
                                            filterOptions.value ??
                                                ProductFilterOptionsModel());
                                      });
                                },
                                label: Text(
                                  'Filter By',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                                icon: SvgPicture.asset(
                                    "${Constants.imagePath}filterby.svg",
                                    height: 12.sp),
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenUtil().screenWidth / 2,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                // start: BorderSide(color: AppTheme.strokeColor),
                                top: BorderSide(color: AppTheme.strokeColor),
                                end: BorderSide(
                                    width: 0.2, color: AppTheme.strokeColor),
                                bottom: BorderSide(
                                    color: AppTheme.strokeColor, width: 0.2),
                              ),
                            ),
                            child: Center(
                              child: TextButton.icon(
                                iconAlignment: IconAlignment.end,
                                onPressed: () {
                                  showModalBottomSheet(
                                      isDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return ProductSortByWidget();
                                      });
                                },
                                label: Text(
                                  'Sort By',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                                icon: SvgPicture.asset(
                                  "${Constants.imagePath}sortBy.svg",
                                  height: 7.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        // flex: 1,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final wishlistState = ref.watch(wishlistProvider);
                            return GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 14.sp,
                                      childAspectRatio: 0.8.sp),
                              scrollDirection: Axis.vertical,
                              itemCount: wishlistState.productCatList.isNotEmpty
                                  ? wishlistState.productCatList.length
                                  : data.products.length,
                              itemBuilder: (context, index) {
                                final item =
                                    wishlistState.productCatList.isNotEmpty
                                        ? wishlistState.productCatList[index]
                                        : data.products[index];
                                return InkWell(
                                  onTap: () {
                                    context.push("/product_detail", extra: {
                                      "id": item.id.toString(),
                                      "isMoonJewelry": false,
                                      "name": item.title ?? ""
                                    });
                                  },
                                  child: Container(
                                      width: ScreenUtil().setWidth(200),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r)),
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          border: Border.all(
                                            color: AppTheme.strokeColor,
                                            width: 0.3,
                                          )),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0.w),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  12.0.r)),
                                                  child: SizedBox.expand(
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          item.image ?? "",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child: SizedBox(
                                                          height: ScreenUtil()
                                                              .setHeight(20),
                                                          width: ScreenUtil()
                                                              .setWidth(20),
                                                          child: CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.0.h,
                                              ),
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 9.0.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          RatingStars(
                                                            value: double.parse(item
                                                                    ?.rating
                                                                    .toString() ??
                                                                "0.0"),
                                                            onValueChanged:
                                                                (v) {
                                                              //
                                                            },
                                                            starBuilder: (index,
                                                                    color) =>
                                                                ColorFiltered(
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      color!,
                                                                      BlendMode
                                                                          .srcIn),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "${Constants.imagePath}empty_star.svg"),
                                                            ),
                                                            starCount: 5,
                                                            valueLabelVisibility:
                                                                false,
                                                            starSize:
                                                                ScreenUtil()
                                                                    .setSp(20),
                                                            maxValue: 5,
                                                            starSpacing: 2,
                                                            maxValueVisibility:
                                                                true,
                                                            animationDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        1000),
                                                            starOffColor:
                                                                AppTheme
                                                                    .strokeColor,
                                                            starColor: AppTheme
                                                                .primaryColor,
                                                          ),
                                                          SizedBox(
                                                            width: 8.h,
                                                          ),
                                                          Text(
                                                            "(${item?.ratingCount ?? ""})", //(${fastResults[index].ratingCount ?? ""})",
                                                            style: TextStyle(
                                                              color: AppTheme
                                                                  .subTextColor,
                                                              fontSize: 13.sp,
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
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      Text(
                                                        item?.title ?? "",
                                                        style: AppTheme
                                                            .lightTheme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      Text(
                                                          "$currency ${item?.price}",
                                                          style: AppTheme
                                                              .lightTheme
                                                              .textTheme
                                                              .bodyMedium),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16.sp,
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.0.sp, top: 10.sp),
                                              child: InkWell(
                                                onTap: () {
                                                  ConstantMethods
                                                      .toggleWishlist(
                                                          WishListType
                                                              .productCatList,
                                                          ref,
                                                          index: index);
                                                },
                                                child: SvgPicture.asset(
                                                  item!.isWishlist!
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
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 26.h,
                      )
                    ],
                  );
                case false:
                  ConstantMethods.buildErrorUI(
                    ref,
                    onPressed: () {
                      if (code == 402) {
                        ApiUtils.refreshToken().then((onValue) {
                          return ref.refresh(
                              productCategoryListNotifierProvider(widget.id));
                        });
                      }
                    },
                  );
                default:
                  return SizedBox();
              }
              return SizedBox();
            },
            error: (error) {
              return ConstantMethods.buildErrorUI(
                ref,
                onPressed: () {
                  ref
                      .read(productCategoryListNotifierProvider(
                        widget.id,
                      ).notifier)
                      .fetchProductCategory(widget.id);
                },
              );
            },
            loading: () => _buildShimmerLoading(context),
            noInternet: () => NoInternetWidget(
              onRetry: () {
                ref
                    .read(productCategoryListNotifierProvider(
                      widget.id,
                    ).notifier)
                    .fetchProductCategory(widget.id);
              },
            ),
            reachedEnd: (items) {
              return Column(
                children: [
                  // CachedNetworkImage(
                  //       fit: BoxFit.cover,
                  //       imageUrl: data.categoryBanner ?? "",
                  //       progressIndicatorBuilder:
                  //           (context, url, downloadProgress) => Center(
                  //         child: SizedBox(
                  //           height: ScreenUtil().setHeight(20),
                  //           width: ScreenUtil().setWidth(20),
                  //           child: CircularProgressIndicator(
                  //               value: downloadProgress.progress),
                  //         ),
                  //       ),
                  //       errorWidget: (context, url, error) =>
                  //           const Icon(Icons.error),
                  //       height: ScreenUtil().setHeight(80),
                  //       width: ScreenUtil().screenWidth,
                  //     ),
                  Row(
                    children: [
                      Container(
                        width: ScreenUtil().screenWidth / 2,
                        height: 40.sp,
                        decoration: BoxDecoration(
                          border: BorderDirectional(
                            // start: BorderSide(color: AppTheme.strokeColor),
                            top: BorderSide(color: AppTheme.strokeColor),
                            end: BorderSide(
                                width: 0.2, color: AppTheme.strokeColor),
                            bottom: BorderSide(
                                color: AppTheme.strokeColor, width: 0.2),
                          ),
                        ),
                        child: Center(
                          child: TextButton.icon(
                            iconAlignment: IconAlignment.end,
                            onPressed: () {
                              showModalBottomSheet(
                                  isDismissible: false,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return ProductFilterWidget(
                                        filterOptions.value ??
                                            ProductFilterOptionsModel());
                                  });
                            },
                            label: Text(
                              'Filter By',
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                            ),
                            icon: SvgPicture.asset(
                                "${Constants.imagePath}filterby.svg",
                                height: 12.sp),
                          ),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().screenWidth / 2,
                        height: 40.sp,
                        decoration: BoxDecoration(
                          border: BorderDirectional(
                            // start: BorderSide(color: AppTheme.strokeColor),
                            top: BorderSide(color: AppTheme.strokeColor),
                            end: BorderSide(
                                width: 0.2, color: AppTheme.strokeColor),
                            bottom: BorderSide(
                                color: AppTheme.strokeColor, width: 0.2),
                          ),
                        ),
                        child: Center(
                          child: TextButton.icon(
                            iconAlignment: IconAlignment.end,
                            onPressed: () {
                              showModalBottomSheet(
                                  isDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return ProductSortByWidget();
                                  });
                            },
                            label: Text(
                              'Sort By',
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                            ),
                            icon: SvgPicture.asset(
                              "${Constants.imagePath}sortBy.svg",
                              height: 7.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    // flex: 1,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final wishlistState = ref.watch(wishlistProvider);
                        return GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 14.sp,
                                  childAspectRatio: 0.8.sp),
                          scrollDirection: Axis.vertical,
                          itemCount: wishlistState.productCatList.isNotEmpty
                              ? wishlistState.productCatList.length
                              : items.length,
                          itemBuilder: (context, index) {
                            final item = wishlistState.productCatList.isNotEmpty
                                ? wishlistState.productCatList[index]
                                : items[index];
                            return InkWell(
                              onTap: () {
                                context.push("/product_detail", extra: {
                                  "id": item.id.toString(),
                                  "isMoonJewelry": false,
                                  "name": item.title ?? ""
                                });
                              },
                              child: Container(
                                  width: ScreenUtil().setWidth(200),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                      color: AppTheme.appBarAndBottomBarColor,
                                      border: Border.all(
                                        color: AppTheme.strokeColor,
                                        width: 0.3,
                                      )),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.r),
                                                  topRight:
                                                      Radius.circular(12.0.r)),
                                              child: SizedBox.expand(
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: item.image ?? "",
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: SizedBox(
                                                      height: ScreenUtil()
                                                          .setHeight(20),
                                                      width: ScreenUtil()
                                                          .setWidth(20),
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.0.h,
                                          ),
                                          SizedBox(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 9.0.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      RatingStars(
                                                        value: double.parse(item
                                                                ?.rating
                                                                .toString() ??
                                                            "0.0"),
                                                        onValueChanged: (v) {
                                                          //
                                                        },
                                                        starBuilder:
                                                            (index, color) =>
                                                                ColorFiltered(
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  color!,
                                                                  BlendMode
                                                                      .srcIn),
                                                          child: SvgPicture.asset(
                                                              "${Constants.imagePath}empty_star.svg"),
                                                        ),
                                                        starCount: 5,
                                                        valueLabelVisibility:
                                                            false,
                                                        starSize: ScreenUtil()
                                                            .setSp(20),
                                                        maxValue: 5,
                                                        starSpacing: 2,
                                                        maxValueVisibility:
                                                            true,
                                                        animationDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    1000),
                                                        starOffColor: AppTheme
                                                            .strokeColor,
                                                        starColor: AppTheme
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: 8.h,
                                                      ),
                                                      Text(
                                                        "(${item?.ratingCount ?? ""})", //(${fastResults[index].ratingCount ?? ""})",
                                                        style: TextStyle(
                                                          color: AppTheme
                                                              .subTextColor,
                                                          fontSize: 13.sp,
                                                          fontFamily:
                                                              'NotoSansHebrew',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          letterSpacing: 0.20,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    item?.title ?? "",
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                      "$currency ${item?.price}",
                                                      style: AppTheme
                                                          .lightTheme
                                                          .textTheme
                                                          .bodyMedium),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.sp,
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0.sp, top: 10.sp),
                                          child: InkWell(
                                            onTap: () {
                                              ConstantMethods.toggleWishlist(
                                                  WishListType.productCatList,
                                                  ref,
                                                  index: index);
                                            },
                                            child: SvgPicture.asset(
                                              item!.isWishlist!
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
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("You've reached the end."),
                  ),
                ],
              );
            },
          )),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0.sp),
      child: Skeletonizer(
        enabled: true, // Enable the shimmer effect
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
