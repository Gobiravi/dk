import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/home_widgets.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:dikla_spirit/widgets/search_widget/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchProvider);
    final isSearching = _controller.text.isNotEmpty;
    final searchBgData = ref.watch(searchBgApiProvider);
    final currency = ref.watch(currentCurrencySymbolProvider);
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 62.h + kToolbarHeight,
                decoration: BoxDecoration(
                    color: AppTheme.appBarAndBottomBarColor,
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE8E8E8), width: 0.5))),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 11.h, left: 19.w, right: 19.w),
                    child: Row(
                      children: [
                        InkWell(
                          child: SvgPicture.asset(
                              "${Constants.imagePathAppBar}back.svg"),
                          onTap: () {
                            ref.read(searchProvider.notifier).clearSearch();
                            context.pop();
                          },
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          height: 40.h,
                          width: ScreenUtil().screenWidth * 0.8,
                          child: TextField(
                            cursorColor: AppTheme.cursorColor,
                            cursorWidth: 1.0,
                            cursorHeight: 18.h,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(color: AppTheme.textColor),
                            textAlignVertical: TextAlignVertical.center,
                            controller: _controller,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "Search...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.strokeColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.primaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.primaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.strokeColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.errorBorder, width: 1.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.errorBorder, width: 1.0)),
                              prefixIcon: Container(
                                padding: EdgeInsets.only(
                                    left:
                                        13.sp), // Adjust left padding if needed
                                width: 48
                                    .w, // Set a fixed width for the prefix icon container
                                alignment:
                                    Alignment.center, // Align the SVG properly
                                child: SvgPicture.asset(
                                  "${Constants.imagePath}search.svg",
                                  fit: BoxFit.contain,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              suffixIcon: _controller.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        _controller.clear();
                                        ref
                                            .read(searchProvider.notifier)
                                            .clearSearch();
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                ref.read(searchProvider.notifier).clearSearch();
                              } else {
                                ref.read(searchProvider.notifier).search(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 27.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                            child: Text(
                              localization.recent_purchase_dikla,
                              style: AppTheme.lightTheme.textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          searchBgData.when(
                            data: (data) {
                              switch (data.status) {
                                case true:
                                  Future.microtask(
                                    () {
                                      ref
                                          .read(wishlistProvider.notifier)
                                          .initializeWishListSearchRecentPurchase(
                                              data.data?.products ?? []);
                                    },
                                  );
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HomeFastResultsWidget(
                                          data.data?.products ?? [],
                                          WishListType.searchRecentPurchase),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0.w),
                                        child: Text(
                                          localization.popular_categories,
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 16.0.w),
                                      //   child: Wrap(
                                      //     children: data.data?.categories
                                      //             ?.map((e) => Padding(
                                      //                   padding:
                                      //                       EdgeInsets.only(
                                      //                           right: 8.0.w,
                                      //                           bottom: 8.h),
                                      //                   child: InkWell(
                                      //                     onTap: () {
                                      //                       context.go(
                                      //                           "/product",
                                      //                           extra: {
                                      //                             "id": e.id,
                                      //                             "name":
                                      //                                 e.title ??
                                      //                                     ""
                                      //                           });
                                      //                     },
                                      //                     child: Container(
                                      //                       width: 186.w,
                                      //                       height: 95.h,
                                      //                       decoration:
                                      //                           ShapeDecoration(
                                      //                         color: AppTheme
                                      //                             .appBarAndBottomBarColor,
                                      //                         shape:
                                      //                             RoundedRectangleBorder(
                                      //                           side: BorderSide(
                                      //                               width: 0.20,
                                      //                               color: AppTheme
                                      //                                   .strokeColor),
                                      //                           borderRadius:
                                      //                               BorderRadius
                                      //                                   .circular(
                                      //                                       10.r),
                                      //                         ),
                                      //                       ),
                                      //                       child: Padding(
                                      //                         padding: EdgeInsets
                                      //                             .symmetric(
                                      //                                 horizontal:
                                      //                                     18.0
                                      //                                         .w,
                                      //                                 vertical:
                                      //                                     10.h),
                                      //                         child: Text(
                                      //                           e.title ?? "",
                                      //                           textAlign:
                                      //                               TextAlign
                                      //                                   .center,
                                      //                           style: AppTheme
                                      //                               .lightTheme
                                      //                               .textTheme
                                      //                               .bodySmall
                                      //                               ?.copyWith(
                                      //                                   fontSize: 14
                                      //                                       .sp,
                                      //                                   letterSpacing:
                                      //                                       -0.30),
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ))
                                      //             .toList() ??
                                      //         [], // ✅ Provide an empty list if null
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0.w),
                                        child: SizedBox(
                                          height: 95.h * 2,
                                          child: GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                data.data?.categories?.length ??
                                                    0,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 8.h,
                                              crossAxisSpacing: 8.w,
                                              childAspectRatio: 186.w /
                                                  ScreenUtil().screenWidth *
                                                  1.1, // Aspect ratio = width / height
                                            ),
                                            itemBuilder: (context, index) {
                                              final e =
                                                  data.data!.categories![index];
                                              return InkWell(
                                                onTap: () {
                                                  context
                                                      .go("/product", extra: {
                                                    "id": e.id,
                                                    "name": e.title ?? "",
                                                  });
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11.r),
                                                  child: Container(
                                                    // width: 186.w,
                                                    // height: 95.h,
                                                    decoration: ShapeDecoration(
                                                      color: AppTheme
                                                          .appBarAndBottomBarColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          width: 0.20,
                                                          color: AppTheme
                                                              .strokeColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11.r),
                                                      ),
                                                      image: e.image != null &&
                                                              e.image!
                                                                  .isNotEmpty
                                                          ? DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                      e.image!),
                                                              fit: BoxFit.cover,
                                                            )
                                                          : null,
                                                    ),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.4), // optional overlay for text visibility
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 18.0.w,
                                                          vertical: 10.h,
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            e.title ?? "",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTheme
                                                                .lightTheme
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                              fontSize: 16.sp,
                                                              letterSpacing:
                                                                  -0.30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                      data.data != null &&
                                              data.data!.youMayAlsoLike !=
                                                  null &&
                                              data.data!.youMayAlsoLike!
                                                  .isNotEmpty
                                          ? SizedBox(
                                              // height:
                                              //     ScreenUtil().setHeight(200),
                                              width: ScreenUtil().screenWidth,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.0.w),
                                                    child: Text(
                                                      localization
                                                          .youMayAlsoLikeThis,
                                                      style: AppTheme.lightTheme
                                                          .textTheme.bodyLarge,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 18.h,
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(166),
                                                    width: ScreenUtil()
                                                        .screenWidth,
                                                    child: ListView.builder(
                                                      itemCount: data
                                                          .data
                                                          ?.youMayAlsoLike
                                                          ?.length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0.sp,
                                                                  right: 10.sp),
                                                          child: Container(
                                                            width: ScreenUtil()
                                                                    .screenWidth *
                                                                0.9,
                                                            height: ScreenUtil()
                                                                .setHeight(160),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.sp),
                                                              color: AppTheme
                                                                  .appBarAndBottomBarColor,
                                                              border:
                                                                  Border.all(
                                                                color: AppTheme
                                                                    .strokeColor,
                                                                // width: 0.3,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          12.0.sp),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            139),
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            141),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.sp),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        imageUrl:
                                                                            data.data?.youMayAlsoLike?[index].image ??
                                                                                "",
                                                                        progressIndicatorBuilder: (context,
                                                                                url,
                                                                                downloadProgress) =>
                                                                            Center(
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                ScreenUtil().setHeight(20),
                                                                            width:
                                                                                ScreenUtil().setWidth(20),
                                                                            child:
                                                                                CircularProgressIndicator(value: downloadProgress.progress),
                                                                          ),
                                                                        ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            const Icon(Icons.error),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          16.w),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start, // Align text to the left
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              22.sp,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            RatingStars(
                                                                              value: double.parse(data.data?.youMayAlsoLike?[index].rating.toString() ?? "0.0"),
                                                                              onValueChanged: (v) {
                                                                                //
                                                                              },
                                                                              starBuilder: (index, color) => ColorFiltered(
                                                                                colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
                                                                                child: SvgPicture.asset("${Constants.imagePath}empty_star.svg"),
                                                                              ),
                                                                              starCount: 5,
                                                                              starSize: ScreenUtil().setSp(20),
                                                                              maxValue: 5,
                                                                              starSpacing: 2,
                                                                              maxValueVisibility: true,
                                                                              valueLabelVisibility: false,
                                                                              animationDuration: Duration(milliseconds: 1000),
                                                                              starOffColor: AppTheme.strokeColor,
                                                                              starColor: AppTheme.primaryColor,
                                                                            ),
                                                                            Text(
                                                                              " (${data.data?.youMayAlsoLike?[index].ratingCount ?? ""})",
                                                                              maxLines: 5,
                                                                              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(overflow: TextOverflow.ellipsis),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10.sp,
                                                                        ),
                                                                        SizedBox(
                                                                          // width:
                                                                          //     300.w,
                                                                          child:
                                                                              Text(
                                                                            data.data?.youMayAlsoLike?[index].title ??
                                                                                "",
                                                                            style:
                                                                                AppTheme.lightTheme.textTheme.bodyMedium,
                                                                            maxLines:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10.h,
                                                                        ),
                                                                        SizedBox(
                                                                          // width:
                                                                          //     300.w,
                                                                          child:
                                                                              Text(
                                                                            data.data?.youMayAlsoLike?[index].shortDesc ??
                                                                                "",
                                                                            style:
                                                                                AppTheme.lightTheme.textTheme.bodySmall,
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        // SizedBox(
                                                                        //   child:
                                                                        //       Text(
                                                                        //     data.data?.youMayAlsoLike?[index].symbol ??
                                                                        //         "",
                                                                        //     style:
                                                                        //         AppTheme.lightTheme.textTheme.bodySmall?.copyWith(fontSize: 12.sp, color: AppTheme.textColor),
                                                                        //     maxLines:
                                                                        //         3,
                                                                        //   ),
                                                                        // ),
                                                                        SizedBox(
                                                                          height:
                                                                              14.h,
                                                                        ),
                                                                        Text(
                                                                          "$currency ${data.data?.youMayAlsoLike?[index].price.toString() ?? ""}",
                                                                          style: AppTheme
                                                                              .lightTheme
                                                                              .textTheme
                                                                              .bodyMedium
                                                                              ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
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
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 55.h + kToolbarHeight,
                                      )
                                    ],
                                  );
                                case false:
                                  if (data.statusCode == 402) {
                                    return ConstantMethods.buildErrorUI(
                                      ref,
                                      onPressed: () {
                                        refreshApi();
                                      },
                                    );
                                  }
                                  return ConstantMethods.buildErrorUI(
                                    ref,
                                    onPressed: () {
                                      return ref.refresh(searchBgApiProvider);
                                    },
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
                                    return ref.refresh(searchBgApiProvider);
                                  },
                                );
                              }
                              return ConstantMethods.buildErrorUI(
                                ref,
                                onPressed: () {
                                  return ref.refresh(searchBgApiProvider);
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
                        ],
                      ),
                      if (isSearching && searchResults.isEmpty)
                        Container(
                          height: 320.h,
                          decoration: BoxDecoration(
                              color: AppTheme.appBarAndBottomBarColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.r),
                                bottomRight: Radius.circular(12.r),
                              ),
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xFFE8E8E8), width: 0.5))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "${Constants.imagePath}search_1.svg",
                                  height: 28.h,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text('No Result Found !',
                                    style: AppTheme
                                        .lightTheme.textTheme.headlineLarge
                                        ?.copyWith(fontSize: 18.sp)),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                    'Sorry, we couldn’t find any matching\nresult for your Search',
                                    textAlign: TextAlign.center,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(fontSize: 14.sp)),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  width: 159.w,
                                  height: 38.h,
                                  decoration: ShapeDecoration(
                                    color: AppTheme.subTextColor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: AppTheme.subTextColor),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Explore Catgories',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(
                                              fontSize: 12.sp,
                                              color: AppTheme
                                                  .appBarAndBottomBarColor,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (searchResults.isNotEmpty)
                        Container(
                          height: searchResults.length * 60.h,
                          decoration: BoxDecoration(
                            color: AppTheme.appBarAndBottomBarColor,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.h),
                                Text(
                                  'Product Suggestion',
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.teritiaryTextColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: searchResults.length,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context.go("/product_detail", extra: {
                                            "id": searchResults[index]
                                                .id
                                                .toString(),
                                            "isMoonJewelry": false,
                                            "name":
                                                searchResults[index].title ?? ""
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 15.h),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 60.sp,
                                                height: 60.sp,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        searchResults[index]
                                                                .productImage ??
                                                            ""),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: 10
                                                      .w), // Add spacing between image and text
                                              Expanded(
                                                // Prevents text from overflowing
                                                child: Text(
                                                  searchResults[index].title ??
                                                      "",
                                                  style: AppTheme.lightTheme
                                                      .textTheme.bodySmall,
                                                  overflow: TextOverflow
                                                      .ellipsis, // Handle long text
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  refreshApi() async {
    await ApiUtils.refreshToken();
    return ref.refresh(searchBgApiProvider);
  }
}
