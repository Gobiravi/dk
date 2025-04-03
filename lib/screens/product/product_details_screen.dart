import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/product_details_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/app_bar.dart';
import 'package:dikla_spirit/widgets/home_widgets.dart';
import 'package:dikla_spirit/widgets/product_details_widget.dart';
import 'package:dikla_spirit/widgets/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatefulHookConsumerWidget {
  final String productId;
  final String name;
  const ProductDetailsScreen(this.productId, this.name, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsScreenState(productId);
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final String productId;
  _ProductDetailsScreenState(this.productId);
  @override
  Widget build(BuildContext context) {
    final productDetails = ref.watch(productDetailsApiProvider(productId));
    final expectedDate =
        ref.watch(getExpectedDateForChannelingApiProvider(productId));
    final localization = AppLocalizations.of(context);
    final indexOfSelectedJewellery =
        ref.watch(indexOfJewelleryVariationInProductDetail);
    final choosedVariation = ref.watch(selectedVariation);
    final suggestedPriceValid = ref.watch(suggestedPriceProviderValid);
    useEffect(() {
      productDetails.when(
        data: (data) {
          final datum = data.data ?? ProductDetailsModelData();
          if (datum.productDetail?.variations != null &&
              datum.productDetail!.variations!.isNotEmpty) {
            Future.microtask(
              () {
                if (datum.productDetail?.type == "variable") {
                  ref.read(selectedVariation.notifier).state =
                      datum.productDetail!.variations!.first;
                }
              },
            );
          }
        },
        loading: () {},
        error: (error, stackTrace) {},
      );
      return null; // No cleanup required
    }, [productDetails]);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: ScreenUtil().screenWidth / 2.4,
          actions: [
            IconButton(
                onPressed: () {
                  Share.share(
                      productDetails.value?.data?.productDetail?.productLink ??
                          "",
                      subject: 'Look Out For this product');
                },
                icon:
                    SvgPicture.asset("${Constants.imagePathAppBar}share.svg")),
            IconButton(
                onPressed: () {
                  context.push("/search_widget");
                },
                icon: SvgPicture.asset("${Constants.imagePath}search.svg")),
            WishlistWidget(),
            SizedBox(
              width: 20.sp,
            )
          ],
          leading: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: IconButton(
                    onPressed: () {
                      ref.watch(selectedVariation.notifier).state = Variation();
                      context.goNamed("dashboard");
                    },
                    icon: SvgPicture.asset(
                        "${Constants.imagePathAppBar}back.svg")),
              ),
              SizedBox(
                width: ScreenUtil().screenWidth / 4.5,
                child: Text(
                  widget.name,
                  style: AppTheme.lightTheme.textTheme.titleMedium
                      ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        body: productDetails.when(
          data: (data) {
            // final wishlistState = ref.watch(wishlistProvider);
            final datum = data.data ?? ProductDetailsModelData();
            final currency = CurrencySymbol.fromString(datum.currency ?? "ILS");
            // useEffect(
            //   () {
            //     if (datum.productDetail?.variations != null &&
            //         datum.productDetail!.variations!.isNotEmpty) {
            //       ref.read(selectedVariation.notifier).state =
            //           datum.productDetail?.variations?.first ?? Variation();
            //     }
            //     return;
            //   },
            // );
            switch (data.status) {
              case true:
                Future.microtask(
                  () {
                    ref
                        .read(wishlistProvider.notifier)
                        .initializeProductDetails(
                            data.data?.productDetail ?? ProductDetail());
                    ref
                        .read(wishlistProvider.notifier)
                        .initializeProductDetailsFastResult(
                            data.data?.relatedProducts ?? []);
                    ref
                        .read(wishlistProvider.notifier)
                        .initializeProductDetailsYouMayLikeThis(
                            data.data?.youMayAlsoLikeThis ?? []);
                  },
                );

                return SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: datum.productDetail?.template == 3,
                              child: Padding(
                                padding: EdgeInsets.all(18.0.sp),
                                child: Container(
                                    height: ScreenUtil().setHeight(380),
                                    decoration: ShapeDecoration(
                                      color: AppTheme.appBarAndBottomBarColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.sp),
                                      ),
                                    ),
                                    child: datum.productDetail != null &&
                                            datum.productDetail?.type !=
                                                "simple" &&
                                            datum.productDetail!.variations !=
                                                null &&
                                            datum.productDetail!.variations!
                                                .isNotEmpty
                                        ? ProductDetailsJewelleryWidget(datum
                                                .productDetail!.variations![
                                            ref.watch(
                                                indexOfJewelleryVariationInProductDetail)])
                                        : datum.productDetail?.type == "simple"
                                            ? ProductDetailsJewelleryWidgetSimple(
                                                datum.productDetail!)
                                            : SizedBox()),
                              ),
                            ),
                            Visibility(
                              visible: datum.productDetail?.template == 3,
                              child: Padding(
                                  padding: EdgeInsets.all(18.0.sp),
                                  child: ProductDetailsVariationWidget(datum)),
                            ),
                            Visibility(
                              visible: datum.productDetail?.template != 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0.sp,
                                    right: 16.0.sp,
                                    top: 16.0.sp),
                                child: Container(
                                  width: ScreenUtil().screenWidth,
                                  height: ScreenUtil().setHeight(380.0),
                                  decoration: ShapeDecoration(
                                    color: AppTheme.appBarAndBottomBarColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 15.sp,
                                        bottom: 15.sp,
                                        right: 15.sp,
                                        top: 17.sp,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: datum.productDetail
                                                    ?.productImage ??
                                                "",
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20),
                                                width:
                                                    ScreenUtil().setWidth(20),
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 14.sp,
                                          top: 16.sp,
                                          child: Consumer(
                                            builder: (context, ref, child) {
                                              final wishlistState =
                                                  ref.watch(wishlistProvider);
                                              final dato =
                                                  wishlistState.productDetails;
                                              return IconButton(
                                                  onPressed: () {
                                                    ConstantMethods
                                                        .toggleWishlist(
                                                            WishListType
                                                                .productDetail,
                                                            ref);
                                                  },
                                                  icon: SvgPicture.asset(
                                                    dato.isWishlist != null &&
                                                            dato.isWishlist!
                                                        ? "${Constants.imagePath}heart_filled.svg"
                                                        : "${Constants.imagePath}add_to_wish.svg",
                                                    height:
                                                        ScreenUtil().setSp(20),
                                                    width: ScreenUtil()
                                                        .setSp(22.0),
                                                  ));
                                            },
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: datum.productDetail?.template != 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 18.sp,
                                    right: 18.sp,
                                    top: 16.sp,
                                    bottom: 40.sp),
                                child: Container(
                                  width: ScreenUtil().screenWidth,
                                  // height: ScreenUtil().setHeight(450),
                                  decoration: ShapeDecoration(
                                    color: AppTheme.appBarAndBottomBarColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 14.sp, top: 18.0.sp),
                                        child: Text(
                                          datum.productDetail?.title ?? "",
                                          style: AppTheme.lightTheme.textTheme
                                              .headlineLarge,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0.sp,
                                            bottom: 12.0.sp,
                                            left: 14.sp),
                                        child: Row(
                                          children: [
                                            RatingStars(
                                              value: double.parse(datum
                                                      .productDetail?.rating
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
                                              starSize: ScreenUtil().setSp(20),
                                              maxValue: 5,
                                              starSpacing: 2,
                                              maxValueVisibility: true,
                                              valueLabelVisibility: false,
                                              animationDuration:
                                                  Duration(milliseconds: 1000),
                                              starOffColor:
                                                  AppTheme.strokeColor,
                                              starColor: AppTheme.primaryColor,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                                "(${datum.productDetail?.ratingCount ?? ""})",
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 14.sp,
                                            right: 14.sp,
                                            bottom: 20.sp),
                                        child: HtmlWidget(datum.productDetail
                                                ?.shortDescription ??
                                            ""),
                                      ),
                                      ConstantMethods.customDivider(),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      datum.productDetail!.descriptionQa !=
                                                  null &&
                                              datum.productDetail!
                                                  .descriptionQa!.isNotEmpty
                                          ? SizedBox.fromSize(
                                              size: Size.fromHeight(datum
                                                      .productDetail!
                                                      .descriptionQa!
                                                      .length *
                                                  50.sp),
                                              child: ListView.builder(
                                                itemCount: datum.productDetail
                                                    ?.descriptionQa!.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      final content =
                                                          parseHtmlString(datum
                                                                  .productDetail!
                                                                  .descriptionQa?[
                                                                      index]
                                                                  .value ??
                                                              "");

                                                      print(
                                                          'Description: ${content.description}');
                                                      for (var item
                                                          in content.items) {
                                                        print(
                                                            '${item.headerIsBold ? '[BOLD] ' : ''}${item.header}');
                                                      }
                                                      // showModalBottomSheet(
                                                      //   isDismissible: false,
                                                      //   context: context,
                                                      //   builder: (context) {
                                                      //     return Container(
                                                      //       decoration: const BoxDecoration(
                                                      //           color: AppTheme
                                                      //               .appBarAndBottomBarColor,
                                                      //           borderRadius: BorderRadius.only(
                                                      //               topLeft: Radius
                                                      //                   .circular(
                                                      //                       12.0),
                                                      //               topRight: Radius
                                                      //                   .circular(
                                                      //                       12.0))),
                                                      //       child: Column(
                                                      //         children: [
                                                      //           SizedBox(
                                                      //             height: 12.sp,
                                                      //           ),
                                                      //           Row(
                                                      //             mainAxisAlignment:
                                                      //                 MainAxisAlignment
                                                      //                     .spaceBetween,
                                                      //             children: [
                                                      //               IconButton(
                                                      //                   onPressed:
                                                      //                       () {
                                                      //                     context
                                                      //                         .pop();
                                                      //                   },
                                                      //                   icon:
                                                      //                       const Icon(
                                                      //                     Icons
                                                      //                         .close,
                                                      //                     color:
                                                      //                         Colors.transparent,
                                                      //                   )),
                                                      //               Text(
                                                      //                   datum.productDetail!.descriptionQa?[index].question ??
                                                      //                       "",
                                                      //                   style: ThemeData.light()
                                                      //                       .textTheme
                                                      //                       .labelMedium!
                                                      //                       .copyWith(color: AppTheme.primaryColor)),
                                                      //               IconButton(
                                                      //                   onPressed:
                                                      //                       () {
                                                      //                     // ref.read(indexOfBottomNavbarProvider.notifier).state = 0;
                                                      //                     Navigator.of(context)
                                                      //                         .pop();
                                                      //                   },
                                                      //                   icon:
                                                      //                       const Icon(
                                                      //                     Icons
                                                      //                         .close,
                                                      //                     color:
                                                      //                         AppTheme.textColor,
                                                      //                   ))
                                                      //             ],
                                                      //           ),
                                                      //           Divider(),
                                                      //           SizedBox(
                                                      //             height: 14.sp,
                                                      //           ),
                                                      //           content.title !=
                                                      //                       null &&
                                                      //                   content
                                                      //                       .title
                                                      //                       .isNotEmpty
                                                      //               ? Padding(
                                                      //                   padding:
                                                      //                       EdgeInsets.symmetric(horizontal: 20.sp),
                                                      //                   child:
                                                      //                       Text(
                                                      //                     content
                                                      //                         .title,
                                                      //                     style: AppTheme
                                                      //                         .lightTheme
                                                      //                         .textTheme
                                                      //                         .bodySmall
                                                      //                         ?.copyWith(fontSize: 14.sp),
                                                      //                   ),
                                                      //                 )
                                                      //               : SizedBox
                                                      //                   .shrink(),
                                                      //           SizedBox(
                                                      //             height: 20.sp,
                                                      //           ),
                                                      //           Expanded(
                                                      //             child: ListView
                                                      //                 .builder(
                                                      //               itemCount: content
                                                      //                       .items
                                                      //                       .length ??
                                                      //                   0,
                                                      //               itemBuilder:
                                                      //                   (context,
                                                      //                       index) {
                                                      //                 final item =
                                                      //                     content
                                                      //                         .items[index]; // ✅ Safe access
                                                      //                 if (item ==
                                                      //                     null)
                                                      //                   return SizedBox
                                                      //                       .shrink(); // Skip if null

                                                      //                 return Padding(
                                                      //                   padding: EdgeInsets.only(
                                                      //                       bottom:
                                                      //                           14.sp,
                                                      //                       left: 32.sp,
                                                      //                       right: 32.sp),
                                                      //                   child:
                                                      //                       Row(
                                                      //                     crossAxisAlignment:
                                                      //                         CrossAxisAlignment.start,
                                                      //                     children: [
                                                      //                       SvgPicture.asset(
                                                      //                         "${Constants.imagePath}heart_filled.svg",
                                                      //                         height: 16.sp,
                                                      //                         width: 16.sp,
                                                      //                         placeholderBuilder: (context) => CircularProgressIndicator(),
                                                      //                       ),
                                                      //                       SizedBox(width: 10.w),
                                                      //                       Expanded(
                                                      //                         child: RichText(
                                                      //                           textAlign: TextAlign.start,
                                                      //                           text: TextSpan(
                                                      //                             children: [
                                                      //                               item.headerIsBold
                                                      //                                   ? TextSpan(
                                                      //                                       text: item.header ?? '',
                                                      //                                       style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(fontSize: 14.sp),
                                                      //                                     )
                                                      //                                   : TextSpan(
                                                      //                                       text: item.header ?? '',
                                                      //                                       style: TextStyle(fontWeight: FontWeight.normal),
                                                      //                                     ),
                                                      //                               TextSpan(
                                                      //                                 text: item.description,
                                                      //                                 style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
                                                      //                               ),
                                                      //                             ],
                                                      //                           ),
                                                      //                         ),
                                                      //                       ),
                                                      //                     ],
                                                      //                   ),
                                                      //                 );
                                                      //               },
                                                      //             ),
                                                      //           ),
                                                      //           // Expanded(
                                                      //           //   child:
                                                      //           //       Padding(
                                                      //           //     padding: EdgeInsets.symmetric(
                                                      //           //         horizontal:
                                                      //           //             16.sp),
                                                      //           //     child:
                                                      //           //         SizedBox(
                                                      //           //       // height: ScreenUtil()
                                                      //           //       //     .setHeight(
                                                      //           //       //         255),
                                                      //           //       child:
                                                      //           //           Padding(
                                                      //           //         padding: EdgeInsets.only(
                                                      //           //             left:
                                                      //           //                 14.sp,
                                                      //           //             right: 14.sp,
                                                      //           //             bottom: 20.sp),
                                                      //           //         child:
                                                      //           //             HtmlWidget(
                                                      //           //           datum.productDetail?.descriptionQa?[index].value ??
                                                      //           //               "",
                                                      //           //           renderMode:
                                                      //           //               RenderMode.listView,
                                                      //           //         ),
                                                      //           //       ),
                                                      //           //     ),
                                                      //           //   ),
                                                      //           // ),
                                                      //           SizedBox(
                                                      //             height: 4.sp,
                                                      //           )
                                                      //         ],
                                                      //       ),
                                                      //     );
                                                      //   },
                                                      // );

                                                      showModalBottomSheet(
                                                        isDismissible:
                                                            true, // Allow user to swipe down to dismiss
                                                        context: context,
                                                        isScrollControlled:
                                                            true, // Allow full-screen expansion
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    12.0),
                                                          ),
                                                        ),
                                                        builder: (context) {
                                                          return DraggableScrollableSheet(
                                                            initialChildSize:
                                                                0.5, // Starts at 50% of screen height
                                                            minChildSize:
                                                                0.3, // Can collapse to 30% of screen height
                                                            maxChildSize:
                                                                0.9, // Can expand up to 90% of screen height
                                                            expand: false,
                                                            builder: (context,
                                                                scrollController) {
                                                              return Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: AppTheme
                                                                      .appBarAndBottomBarColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            12.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            12.0),
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            12.sp),

                                                                    // HEADER
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        IconButton(
                                                                          onPressed: () =>
                                                                              context.pop(),
                                                                          icon: const Icon(
                                                                              Icons.close,
                                                                              color: Colors.transparent),
                                                                        ),
                                                                        Text(
                                                                          datum.productDetail!.descriptionQa?[index].question ??
                                                                              "",
                                                                          style: ThemeData.light()
                                                                              .textTheme
                                                                              .labelMedium!
                                                                              .copyWith(color: AppTheme.primaryColor),
                                                                        ),
                                                                        IconButton(
                                                                          onPressed: () =>
                                                                              Navigator.of(context).pop(),
                                                                          icon: const Icon(
                                                                              Icons.close,
                                                                              color: AppTheme.textColor),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Divider(),
                                                                    SizedBox(
                                                                        height:
                                                                            14.sp),

                                                                    // TITLE (If Available)
                                                                    if (content.title !=
                                                                            null &&
                                                                        content
                                                                            .title
                                                                            .isNotEmpty)
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 20.sp),
                                                                        child:
                                                                            Text(
                                                                          content
                                                                              .title,
                                                                          style: AppTheme
                                                                              .lightTheme
                                                                              .textTheme
                                                                              .bodySmall
                                                                              ?.copyWith(fontSize: 14.sp),
                                                                        ),
                                                                      ),
                                                                    SizedBox(
                                                                        height:
                                                                            20.sp),

                                                                    // SCROLLABLE CONTENT
                                                                    Expanded(
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        controller:
                                                                            scrollController,
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 32.sp),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: content
                                                                              .items
                                                                              .map((item) {
                                                                            return Padding(
                                                                              padding: EdgeInsets.only(bottom: 14.sp),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    "${Constants.imagePath}heart_filled.svg",
                                                                                    height: 16.sp,
                                                                                    width: 16.sp,
                                                                                    placeholderBuilder: (context) => CircularProgressIndicator(),
                                                                                  ),
                                                                                  SizedBox(width: 10.w),
                                                                                  Expanded(
                                                                                    child: RichText(
                                                                                      textAlign: TextAlign.start,
                                                                                      text: TextSpan(
                                                                                        children: [
                                                                                          if (item.headerIsBold)
                                                                                            TextSpan(
                                                                                              text: item.header ?? '',
                                                                                              style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(fontSize: 14.sp),
                                                                                            ),
                                                                                          TextSpan(
                                                                                            text: item.description,
                                                                                            style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            4.sp),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      height: 50.sp,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.0.sp,
                                                                    vertical:
                                                                        8.0.sp),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  datum
                                                                          .productDetail
                                                                          ?.descriptionQa?[
                                                                              index]
                                                                          .question ??
                                                                      "",
                                                                  style: AppTheme
                                                                      .lightTheme
                                                                      .textTheme
                                                                      .labelMedium
                                                                      ?.copyWith(
                                                                          fontSize:
                                                                              13.sp),
                                                                ),
                                                                Icon(Icons
                                                                    .keyboard_arrow_right)
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4.sp,
                                                          ),
                                                          ConstantMethods
                                                              .customDivider(),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ))
                                          : SizedBox(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.sp,
                                            vertical: 20.0.sp),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: SvgPicture.asset(
                                                  "${Constants.imagePathProducts}stright.svg"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: SvgPicture.asset(
                                                  "${Constants.imagePathProducts}gay.svg"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: SvgPicture.asset(
                                                  "${Constants.imagePathProducts}lesbo.svg"),
                                            ),
                                            Text(
                                              localization.suitable_for_all,
                                              style: AppTheme.lightTheme
                                                  .textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: ScreenUtil().screenWidth,
                              decoration: BoxDecoration(
                                  color: AppTheme.appBarAndBottomBarColor),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.sp,
                                    right: 16.sp,
                                    bottom: 42.sp,
                                    top: 33.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible:
                                          datum.productDetail!.template != 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          datum.productDetail!.template == 4
                                              ? Text("There is only one price for a good service - what your heart chooses.",
                                                  style: AppTheme.lightTheme.textTheme.labelMedium
                                                      ?.copyWith(
                                                          color: AppTheme
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16.sp))
                                              : datum.productDetail!.template ==
                                                      2
                                                  ? Text("How curious are you to know the answer?",
                                                      style: AppTheme.lightTheme
                                                          .textTheme.labelMedium
                                                          ?.copyWith(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              fontSize: 16.sp))
                                                  : Text(localization.howStrongDoYouWantYourSpell,
                                                      style: AppTheme.lightTheme
                                                          .textTheme.labelMedium
                                                          ?.copyWith(
                                                              color: AppTheme.primaryColor,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 16.sp)),
                                          SizedBox(
                                            height: 16.sp,
                                          ),
                                          Wrap(
                                            spacing: 8.0,
                                            runSpacing: 8.0,
                                            children: datum
                                                .productDetail!.variations!
                                                .map((variation) {
                                              return InkWell(
                                                onTap: () {
                                                  ref
                                                      .watch(selectedVariation
                                                          .notifier)
                                                      .state = variation;
                                                },
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.all(8.0.sp),
                                                  decoration: ShapeDecoration(
                                                      color: AppTheme
                                                          .appBarAndBottomBarColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: ref
                                                                    .watch(
                                                                        selectedVariation)
                                                                    .id ==
                                                                variation.id
                                                            ? BorderSide(
                                                                width: 0.8,
                                                                color: AppTheme
                                                                    .textColor)
                                                            : BorderSide(
                                                                width: 0.8,
                                                                color: AppTheme
                                                                    .strokeColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.sp),
                                                      ),
                                                      shadows: [
                                                        BoxShadow(
                                                          color: AppTheme
                                                              .textColor
                                                              .withOpacity(0.1),
                                                        )
                                                      ]),
                                                  child: Text(
                                                    variation.termName ?? "",
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 14.sp),
                                                  ),
                                                ),
                                              );
                                            }).toList(), // Convert the Iterable to a List
                                          ),
                                          SizedBox(
                                            height: 18.0.sp,
                                          ),
                                          datum.productDetail!.template == 4
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Suggested Price: ${currency.symbol} ${datum.productDetail?.suggestedPrice.toString()}",
                                                      style: AppTheme
                                                          .lightTheme
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                              fontSize: 16.sp,
                                                              color: AppTheme
                                                                  .textColor),
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    Text(
                                                        'Name your price ( ${currency.symbol} )',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTheme
                                                            .lightTheme
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontSize: 14.sp,
                                                                letterSpacing:
                                                                    -0.30)),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    SizedBox(
                                                      width: 120.w,
                                                      child: TextFormField(
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        cursorColor: AppTheme
                                                            .cursorColor,
                                                        cursorWidth: 1.0,
                                                        cursorHeight: 18.h,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: AppTheme
                                                            .lightTheme
                                                            .textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppTheme
                                                                      .strokeColor,
                                                                  width: 1.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.sp)),
                                                          filled: true,
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                  width: 1.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.sp)),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppTheme
                                                                      .strokeColor,
                                                                  width: 1.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.sp)),
                                                          disabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppTheme
                                                                      .strokeColor,
                                                                  width: 1.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.sp)),
                                                          errorBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppTheme
                                                                      .errorBorder,
                                                                  width: 1.0)),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: AppTheme
                                                                          .errorBorder,
                                                                      width:
                                                                          1.0)),
                                                          errorStyle: AppTheme
                                                              .lightTheme
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: AppTheme
                                                                      .errorBorder,
                                                                  fontSize:
                                                                      11.sp),
                                                          fillColor: AppTheme
                                                              .appBarAndBottomBarColor,
                                                        ),
                                                        onChanged: (value) {
                                                          ref
                                                              .read(
                                                                  suggestedPriceProvider
                                                                      .notifier)
                                                              .state = value;

                                                          ref
                                                                  .read(suggestedPriceProviderValid
                                                                      .notifier)
                                                                  .state =
                                                              value
                                                                  .trim()
                                                                  .isNotEmpty;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 9.h,
                                                    ),
                                                    !suggestedPriceValid
                                                        ? Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "${Constants.imagePathProducts}error.svg",
                                                                height: 15.h,
                                                              ),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Text(
                                                                  'Please enter a higher amount.',
                                                                  style: AppTheme
                                                                      .lightTheme
                                                                      .textTheme
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                          fontSize: 11
                                                                              .sp,
                                                                          color: AppTheme
                                                                              .errorBorder,
                                                                          fontWeight:
                                                                              FontWeight.w400))
                                                            ],
                                                          )
                                                        : SizedBox.shrink()
                                                  ],
                                                )
                                              : Text(
                                                  choosedVariation.price != null
                                                      ? "${currency.symbol} ${choosedVariation.price.toString()}"
                                                      : "",
                                                  style: AppTheme.lightTheme
                                                      .textTheme.displayLarge
                                                      ?.copyWith(
                                                          fontSize: 16.sp,
                                                          color: AppTheme
                                                              .textColor),
                                                ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 14.sp,
                                                right: 14.sp,
                                                bottom: 20.sp),
                                            child: HtmlWidget(ref
                                                    .watch(selectedVariation)
                                                    .termDescription ??
                                                ""),
                                          ),
                                          SizedBox(
                                            height: 16.sp,
                                          ),
                                          expectedDate.when(
                                            data: (data) {
                                              if (data != null) {
                                                return Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Expected Day',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFC1768D),
                                                          fontSize: 13,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: data.data
                                                                ?.split(":")
                                                                .last ??
                                                            "",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF393939),
                                                          fontSize: 13,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return SizedBox.shrink();
                                              }
                                            },
                                            loading: () =>
                                                CircularProgressIndicator(),
                                            error: (error, stackTrace) => Text(
                                                'Error: Expected date is missing'),
                                          ),
                                          SizedBox(
                                            height: 21.sp,
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        visible:
                                            datum.productDetail!.template == 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ConstantMethods.customDivider(),
                                            SizedBox(
                                              height: 12.sp,
                                            ),
                                            datum.productDetail != null &&
                                                    datum.productDetail
                                                            ?.descriptionQa !=
                                                        null &&
                                                    datum
                                                        .productDetail!
                                                        .descriptionQa!
                                                        .isNotEmpty
                                                ? SizedBox.fromSize(
                                                    size: Size.fromHeight(datum
                                                            .productDetail!
                                                            .descriptionQa!
                                                            .length *
                                                        50.sp),
                                                    child: ListView.builder(
                                                      itemCount: datum
                                                          .productDetail
                                                          ?.descriptionQa!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var descQa = datum
                                                                .productDetail
                                                                ?.descriptionQa?[
                                                            index];
                                                        return InkWell(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                              isDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Container(
                                                                  decoration: const BoxDecoration(
                                                                      color: AppTheme
                                                                          .appBarAndBottomBarColor,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              12.0),
                                                                          topRight:
                                                                              Radius.circular(12.0))),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                context.pop();
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.close,
                                                                                color: Colors.transparent,
                                                                              )),
                                                                          Text(
                                                                              descQa?.question ?? "",
                                                                              style: ThemeData.light().textTheme.labelMedium!.copyWith(color: AppTheme.primaryColor)),
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                // ref.read(indexOfBottomNavbarProvider.notifier).state = 0;
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.close,
                                                                                color: AppTheme.textColor,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                      const Divider(),
                                                                      SizedBox(
                                                                        height:
                                                                            14.sp,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            ScreenUtil().setHeight(250),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 14.sp,
                                                                              right: 14.sp,
                                                                              bottom: 20.sp),
                                                                          child:
                                                                              HtmlWidget(
                                                                            descQa?.value ??
                                                                                "",
                                                                            renderMode:
                                                                                RenderMode.listView,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: SizedBox(
                                                            height: 50.sp,
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12.0
                                                                              .sp,
                                                                      vertical:
                                                                          8.0.sp),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        descQa?.question ??
                                                                            "",
                                                                        style: AppTheme
                                                                            .lightTheme
                                                                            .textTheme
                                                                            .labelMedium
                                                                            ?.copyWith(fontSize: 13.sp),
                                                                      ),
                                                                      Icon(Icons
                                                                          .keyboard_arrow_down)
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 4.sp,
                                                                ),
                                                                ConstantMethods
                                                                    .customDivider(),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ))
                                                : SizedBox(),
                                            SizedBox(
                                              height: 30.sp,
                                            ),
                                          ],
                                        )),
                                    Container(
                                      width: ScreenUtil().screenWidth,
                                      height: ScreenUtil().setHeight(200),
                                      decoration: ShapeDecoration(
                                        color: AppTheme.appBgColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: datum.provenResult != null
                                          ? ProvenResultsWidget(
                                              datum.provenResult!)
                                          : SizedBox(),
                                    ),
                                    SizedBox(
                                      height: 16.sp,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38.sp,
                            ),
                            datum.relatedProducts != null &&
                                    datum.relatedProducts!.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16.0.sp),
                                        child: Text(
                                          localization.fastResultsProductDetail,
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.sp,
                                      ),
                                      HomeFastResultsWidget(
                                          datum.relatedProducts ?? [],
                                          WishListType.productDetailFastResult),
                                      SizedBox(
                                        height: 12.sp,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            datum.questionAnswer != null &&
                                    datum.questionAnswer!.isNotEmpty
                                ? Container(
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                        color:
                                            AppTheme.appBarAndBottomBarColor),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 12.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0.sp, bottom: 20.sp),
                                          child: Text(
                                              localization.questionsAndAnswers,
                                              style: AppTheme.lightTheme
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                      color: AppTheme
                                                          .primaryColor)),
                                        ),
                                        ConstantMethods.customDivider(),
                                        SizedBox(
                                          height: 12.sp,
                                        ),
                                        SizedBox.fromSize(
                                            size: Size.fromHeight(
                                                datum.questionAnswer!.length *
                                                    50.sp),
                                            child: ListView.builder(
                                              itemCount:
                                                  datum.questionAnswer!.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      isDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              color: AppTheme
                                                                  .appBarAndBottomBarColor,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12.0
                                                                              .r),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12.0))),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 14.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {},
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .transparent,
                                                                      )),
                                                                  SizedBox(
                                                                    width: ScreenUtil()
                                                                            .screenWidth *
                                                                        0.6,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        datum.questionAnswer![index].question ??
                                                                            "",
                                                                        style: ThemeData.light()
                                                                            .textTheme
                                                                            .labelMedium!
                                                                            .copyWith(color: AppTheme.primaryColor),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        context
                                                                            .pop();
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: AppTheme
                                                                            .textColor,
                                                                      ))
                                                                ],
                                                              ),
                                                              const Divider(),
                                                              SizedBox(
                                                                height: 14.sp,
                                                              ),
                                                              Expanded(
                                                                child: SizedBox(
                                                                  // height:
                                                                  //     ScreenUtil()
                                                                  //         .setHeight(
                                                                  //             250),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          14.sp,
                                                                      right:
                                                                          14.sp,
                                                                      bottom:
                                                                          20.sp,
                                                                    ),
                                                                    child:
                                                                        HtmlWidget(
                                                                      datum.questionAnswer![index]
                                                                              .answer ??
                                                                          "",
                                                                      renderMode:
                                                                          RenderMode
                                                                              .listView,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    height: 50.sp,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16.0.sp,
                                                                  vertical:
                                                                      8.0.sp),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: ScreenUtil()
                                                                        .screenWidth *
                                                                    0.8,
                                                                child: Text(
                                                                  datum.questionAnswer![index]
                                                                          .question ??
                                                                      "",
                                                                  style: AppTheme
                                                                      .lightTheme
                                                                      .textTheme
                                                                      .labelMedium
                                                                      ?.copyWith(
                                                                          fontSize:
                                                                              13.sp),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Icon(Icons
                                                                  .keyboard_arrow_down)
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4.sp,
                                                        ),
                                                        ConstantMethods
                                                            .customDivider(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )),
                                        SizedBox(
                                          height: 28.sp,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Button press action
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppTheme
                                                  .appBarAndBottomBarColor,
                                              side: const BorderSide(
                                                color: AppTheme.subTextColor,
                                                width: 1.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil().setSp(10)),
                                              ),
                                            ),
                                            child: Text(
                                              localization.forMoreQuestions,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35.sp,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 40.sp,
                            ),
                            datum.youMayAlsoLikeThis != null &&
                                    datum.youMayAlsoLikeThis!.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16.0.sp),
                                        child: Text(
                                          localization.youMayAlsoLikeThis,
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyLarge,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.sp,
                                      ),
                                      HomeFastResultsWidget(
                                          datum.youMayAlsoLikeThis ?? [],
                                          WishListType
                                              .productDetailYouMayLikeThis),
                                      SizedBox(
                                        height: 33.sp,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 16.0.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(localization.ratingAndReviews,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodyLarge),
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
                                  //         style: AppTheme
                                  //             .lightTheme.textTheme.bodyMedium
                                  //             ?.copyWith(
                                  //                 fontWeight: FontWeight.w600)),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingStars(
                                  value: 0.0,
                                  onValueChanged: (v) {
                                    //
                                  },
                                  starBuilder: (index, color) =>
                                      SvgPicture.asset(
                                          "${Constants.imagePath}star.svg"),
                                  starCount: 5,
                                  starSize: ScreenUtil().setSp(12),
                                  starSpacing: 2,
                                  valueLabelVisibility: false,
                                  animationDuration:
                                      Duration(milliseconds: 1000),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  '(${datum.rating?.totalRating})',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          color: AppTheme.textColor),
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding:
                            //       EdgeInsets.symmetric(horizontal: 16.0.sp),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Column(
                            //         children: [
                            //           Text(
                            //               calculateStarRating([
                            //                 int.parse(
                            //                     datum.rating?.the1Star ?? "0"),
                            //                 int.parse(
                            //                     datum.rating?.the2Star ?? "0"),
                            //                 int.parse(
                            //                     datum.rating?.the3Star ?? "0"),
                            //                 int.parse(
                            //                     datum.rating?.the4Star ?? "0"),
                            //                 int.parse(
                            //                     datum.rating?.the5Star ?? "0")
                            //               ]).toString(),
                            //               style: AppTheme.lightTheme.textTheme
                            //                   .headlineLarge
                            //                   ?.copyWith(fontSize: 38.sp)),
                            //           datum.rating?.totalRating == "1"
                            //               ? Text(
                            //                   '${datum.rating?.totalRating ?? ""} rating',
                            //                   style: AppTheme.lightTheme
                            //                       .textTheme.bodySmall
                            //                       ?.copyWith(
                            //                           fontSize: 14.sp,
                            //                           fontWeight:
                            //                               FontWeight.w400),
                            //                 )
                            //               : Text(
                            //                   '${datum.rating?.totalRating ?? ""} ratings',
                            //                   style: AppTheme.lightTheme
                            //                       .textTheme.bodySmall
                            //                       ?.copyWith(
                            //                           fontSize: 13.sp,
                            //                           fontWeight:
                            //                               FontWeight.w400),
                            //                 ),
                            //         ],
                            //       ),
                            //       StarRatingProgress(ratingCounts: [
                            //         int.parse(datum.rating?.the5Star ?? "0"),
                            //         int.parse(datum.rating?.the4Star ?? "0"),
                            //         int.parse(datum.rating?.the3Star ?? "0"),
                            //         int.parse(datum.rating?.the2Star ?? "0"),
                            //         int.parse(datum.rating?.the1Star ?? "0")
                            //       ])
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 151.w,
                                height: 36.h,
                                decoration: ShapeDecoration(
                                  color: AppTheme.subTextColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r)),
                                ),
                                child: Center(
                                  child: Text(
                                    localization.writeAReview,
                                    style: AppTheme
                                        .lightTheme.textTheme.headlineLarge
                                        ?.copyWith(
                                      fontSize: 14.sp,
                                      color: AppTheme.appBarAndBottomBarColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35.sp,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 12.0.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              color: AppTheme
                                                  .appBarAndBottomBarColor),
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.sp),
                                        decoration: ShapeDecoration(
                                          color:
                                              AppTheme.appBarAndBottomBarColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.40,
                                                color: AppTheme
                                                    .appBarAndBottomBarColor),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(localization.sortBy,
                                                style: AppTheme.lightTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 11.sp)),
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.sp),
                                      decoration: ShapeDecoration(
                                        color: AppTheme.appBarAndBottomBarColor,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.40,
                                              color: AppTheme
                                                  .appBarAndBottomBarColor),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(localization.sortByRating,
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
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
                            datum.reviews != null && datum.reviews!.isNotEmpty
                                ? SizedBox(
                                    height: ScreenUtil().setHeight(200),
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0.sp,
                                                vertical: 12.sp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RatingStars(
                                                  value: double.parse(datum
                                                          .reviews?[index]
                                                          .rating
                                                          .toString() ??
                                                      "0.0"),
                                                  onValueChanged: (v) {
                                                    //
                                                  },
                                                  starBuilder: (index, color) =>
                                                      ColorFiltered(
                                                    colorFilter:
                                                        ColorFilter.mode(color!,
                                                            BlendMode.srcIn),
                                                    child: SvgPicture.asset(
                                                        "${Constants.imagePath}empty_star.svg"),
                                                  ),
                                                  starCount: 5,
                                                  starSize:
                                                      ScreenUtil().setSp(14),
                                                  maxValue: 5,
                                                  starSpacing: 2,
                                                  maxValueVisibility: true,
                                                  valueLabelVisibility: false,
                                                  animationDuration: Duration(
                                                      milliseconds: 1000),
                                                  starOffColor:
                                                      AppTheme.strokeColor,
                                                  starColor:
                                                      AppTheme.primaryColor,
                                                ),
                                                SizedBox(
                                                  height: 8.sp,
                                                ),

                                                datum.reviews![index].title !=
                                                            null &&
                                                        datum.reviews![index]
                                                            .title!.isNotEmpty
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            datum
                                                                    .reviews![
                                                                        index]
                                                                    .title ??
                                                                "",
                                                            style: AppTheme
                                                                .lightTheme
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                          SizedBox(
                                                            height: 8.sp,
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox.shrink(),
                                                Text(
                                                  datum.reviews![index]
                                                          .content ??
                                                      "",
                                                  style: AppTheme.lightTheme
                                                      .textTheme.bodySmall,
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                                //         ClipRRect(
                                                //   borderRadius: BorderRadius.all(
                                                //       Radius.circular(12)),
                                                //   child: CachedNetworkImage(
                                                //     fit: BoxFit.cover,
                                                //     imageUrl: datum.reviews[index],
                                                //     progressIndicatorBuilder: (context,
                                                //             url, downloadProgress) =>
                                                //         Center(
                                                //       child: SizedBox(
                                                //         height:
                                                //             ScreenUtil().setHeight(20),
                                                //         width:
                                                //             ScreenUtil().setWidth(20),
                                                //         child:
                                                //             CircularProgressIndicator(
                                                //                 value: downloadProgress
                                                //                     .progress),
                                                //       ),
                                                //     ),
                                                //     errorWidget:
                                                //         (context, url, error) =>
                                                //             const Icon(Icons.error),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            color: AppTheme.subTextColor
                                                .withOpacity(0.3),
                                            height: 0.1,
                                          );
                                        },
                                        itemCount: datum.reviews!.length),
                                  )
                                : SizedBox(
                                    // height: 40.sp,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20.sp,
                                          ),
                                          SvgPicture.asset(
                                              "${Constants.imagePath}no_stars.svg"),
                                          Text(
                                            'No Reviews',
                                            style: AppTheme.lightTheme.textTheme
                                                .headlineLarge
                                                ?.copyWith(fontSize: 18.sp),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                  backgroundColor: AppTheme
                                      .appBgColor, // Transparent background
                                  // foregroundColor: Colors.blue, // Text color
                                  side: const BorderSide(
                                    color:
                                        AppTheme.subTextColor, // Border color
                                    width: 1.0, // Border width
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil()
                                            .setSp(13)), // Border radius
                                  ),
                                ),
                                child: Text(
                                  localization.checkMoreReviews,
                                  style:
                                      AppTheme.lightTheme.textTheme.labelSmall,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80.sp,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            if (datum.productDetail?.stockStatus != "instock") {
                              if (datum.productDetail?.template == 3) {
                                if (datum.productDetail?.type == "variabl") {
                                  ref
                                      .refresh(addToCartApiProvider(datum
                                                  .productDetail!
                                                  .variations?[
                                                      indexOfSelectedJewellery]
                                                  .id
                                                  .toString() ??
                                              "")
                                          .future)
                                      .then((value) {
                                    if (context.mounted) {
                                      if (value.status!) {
                                        ConstantMethods.showSnackbar(context,
                                            "${datum.productDetail?.title ?? ""} Added To Bag");
                                      } else {
                                        ConstantMethods.showSnackbar(
                                            context, value.message ?? "");
                                      }
                                    }
                                  });
                                } else {
                                  ref
                                      .refresh(addToCartApiProvider(datum
                                                  .productDetail?.id
                                                  .toString() ??
                                              "")
                                          .future)
                                      .then((value) {
                                    if (context.mounted) {
                                      if (value.status!) {
                                        ConstantMethods.showSnackbar(context,
                                            "${datum.productDetail?.title ?? ""} Added To Bag");
                                      } else {
                                        ConstantMethods.showSnackbar(
                                            context, value.message ?? "");
                                      }
                                    }
                                  });
                                }
                              } else {
                                if (datum.productDetail?.type == "variable") {
                                  ref
                                      .refresh(addToCartApiProvider(
                                              choosedVariation.id.toString() ??
                                                  "")
                                          .future)
                                      .then((value) {
                                    if (context.mounted) {
                                      if (value.status!) {
                                        ConstantMethods.showSnackbar(context,
                                            "${datum.productDetail?.title ?? ""} Added To Bag");
                                      } else {
                                        ConstantMethods.showSnackbar(
                                            context, value.message ?? "");
                                      }
                                    }
                                  });
                                } else {
                                  ref
                                      .refresh(addToCartApiProvider(datum
                                                  .productDetail?.id
                                                  .toString() ??
                                              "")
                                          .future)
                                      .then((value) {
                                    if (context.mounted) {
                                      if (value.status!) {
                                        ConstantMethods.showSnackbar(context,
                                            "${datum.productDetail?.title ?? ""} Added To Bag");
                                      } else {
                                        ConstantMethods.showSnackbar(
                                            context, value.message ?? "");
                                      }
                                    }
                                  });
                                }
                              }
                            }
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(60.sp),
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
                                width: ScreenUtil().screenWidth * 0.9,
                                height: 36.sp,
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
                                    datum.productDetail?.stockStatus ==
                                            "instock"
                                        ? localization.with_a_click_its_yours
                                        : localization.out_of_stock,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
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
                      ),
                    ],
                  ),
                );
              case false:
                return ConstantMethods.buildErrorUI(
                  ref,
                  onPressed: () async {
                    await ApiUtils.refreshToken();
                    ref.watch(productDetailsApiProvider(productId));
                  },
                );
              default:
                return SizedBox();
            }
          },
          error: (error, stackTrace) {
            SchedulerBinding.instance.addPostFrameCallback(
              (timeStamp) {
                return ConstantMethods.showSnackbar(context, error.toString());
              },
            );
            return SizedBox();
          },
          loading: () {
            final spinkit = SpinKitPumpingHeart(
              color: AppTheme.appBarAndBottomBarColor,
              size: ScreenUtil().setHeight(50),
            );
            return Center(child: spinkit);
          },
        ));
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

final selectedVariation = StateProvider<Variation>((ref) {
  return Variation();
});

final selectedVariationOfWishList = StateProvider<Variation>((ref) {
  return Variation();
});

class StarRatingProgress extends StatelessWidget {
  final List<int> ratingCounts;

  const StarRatingProgress({super.key, required this.ratingCounts});

  @override
  Widget build(BuildContext context) {
    int totalRatings = ratingCounts.reduce((a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(ratingCounts.length, (index) {
        double percentage =
            totalRatings > 0 ? (ratingCounts[index] / totalRatings) : 0.0;
        var value = 5 - index;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(value, (index) {
                    return Icon(
                      Icons.star,
                      color: AppTheme.primaryColor,
                      size: 16.sp,
                    );
                  }),
                ),
              ),
              SizedBox(width: 8.0),
              SizedBox(
                width: 150.sp,
                child: LinearProgressIndicator(
                  value: percentage,
                  backgroundColor:
                      AppTheme.appBarAndBottomBarColor.withOpacity(0.3),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.subTextColor),
                  minHeight: 8.sp,
                  borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                ),
              ),
              SizedBox(width: 8.0),
              SizedBox(
                width: 30.sp,
                child: Text(ratingCounts[index].toString(),
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis),
              ),
              // Text('${(percentage * 100).toStringAsFixed(1)}%'),
            ],
          ),
        );
      }).toList(), // Reverse to display 5★ at the top
    );
  }
}

HtmlContent parseHtmlString(String html) {
  // Extract all paragraphs
  final paragraphRegex = RegExp(r'<p>(.*?)<\/p>', dotAll: true);
  final paragraphs = paragraphRegex
      .allMatches(html)
      .map((match) => match.group(1) ?? '')
      .toList();

  String title = '';
  bool titleIsBold = false;
  String description = '';

  if (paragraphs.isNotEmpty) {
    String firstParagraph =
        paragraphs.first.replaceAll(RegExp(r'&nbsp;'), '').trim();

    // Check if the first paragraph is fully bold
    final boldRegex =
        RegExp(r'^(<b>|<strong>)(.*?)(<\/b>|<\/strong>)$', dotAll: true);
    final boldMatch = boldRegex.firstMatch(firstParagraph);

    if (boldMatch != null) {
      // Extract the title and mark it as bold
      title = boldMatch.group(2)?.replaceAll(RegExp(r'<.*?>'), '').trim() ?? '';
      titleIsBold = true;
    } else {
      // If not bold, just take the first paragraph as title
      title = firstParagraph.replaceAll(RegExp(r'<.*?>'), '').trim();
      titleIsBold = false;
    }

    // Use the next paragraph as the description if available
    if (paragraphs.length > 1) {
      description = paragraphs[1].replaceAll(RegExp(r'<.*?>'), '').trim();
    }
  }

  // Extract list items
  final listItemRegex = RegExp(r'<li>(.*?)<\/li>', dotAll: true);
  final items = listItemRegex.allMatches(html).map((match) {
    String rawText = match.group(1) ?? '';

    // Extract bold header (if exists)
    final boldMatch = RegExp(
            r'^(?:<b>|<strong>)(.*?)(?:<\/b>|<\/strong>)\s*-?\s*',
            dotAll: true)
        .firstMatch(rawText);
    final header = boldMatch?.group(1)?.replaceAll(RegExp(r'<.*?>'), '').trim();

    // Extract remaining text after the bold header
    String remainingText = rawText;
    if (header != null) {
      remainingText =
          remainingText.replaceFirst(boldMatch!.group(0)!, '').trim();
    }

    // Remove any extra HTML tags from the description
    remainingText = remainingText.replaceAll(RegExp(r'<.*?>'), '').trim();

    return ListItem(
      header: header ?? "", // Keep empty if no header
      headerIsBold: header != null, // True if there's a header
      description: remainingText,
      descriptionIsBold: false, // Assuming only headers are bold
    );
  }).toList();

  return HtmlContent(
    title: title,
    titleIsBold: titleIsBold,
    description: description,
    items: items,
  );
}

class HtmlContent {
  final String description;
  final String title;
  final bool titleIsBold;
  final List<ListItem> items;

  HtmlContent(
      {required this.description,
      required this.items,
      required this.title,
      required this.titleIsBold});
}

class ListItem {
  final String? header;
  final bool headerIsBold;
  final String? description;
  final bool descriptionIsBold;

  ListItem({
    this.header,
    required this.headerIsBold,
    this.description,
    required this.descriptionIsBold,
  });
}
