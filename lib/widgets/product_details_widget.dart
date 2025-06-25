import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/product_details_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:html/parser.dart' as html_parser;

class ProductDetailsWidgetQA extends HookConsumerWidget {
  const ProductDetailsWidgetQA({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// ================= Moon Jewellery Carousel UI ======================

class ProductDetailsJewelleryWidget extends StatefulHookConsumerWidget {
  final Variation variations;
  const ProductDetailsJewelleryWidget(this.variations, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsJewelleryWidgetState();
}

class _ProductDetailsJewelleryWidgetState
    extends ConsumerState<ProductDetailsJewelleryWidget> {
  PageController pageController = PageController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (widget.variations.variationImage!.isNotEmpty) {
          if (mounted) {
            if (ref.watch(indexOfJewelleryInProductDetail) ==
                widget.variations.variationImage!.length - 1) {
              pageController.jumpToPage(0);
            } else {
              pageController.nextPage(
                  duration: const Duration(seconds: 1), curve: Curves.easeIn);
            }
          }
        }
      },
    );
    pageController = PageController(viewportFraction: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.variations.variationImage?.length,
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              ref.read(indexOfJewelleryInProductDetail.notifier).state = value;
            },
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 24.sp),
                // height: ScreenUtil().setHeight(350),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    context.push("/image_viewer", extra: {
                      "urls": widget.variations.variationImage,
                      "index": index
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.variations.variationImage?[index] ?? "",
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
              );
            },
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SmoothPageIndicator(
                controller: pageController, // PageController
                count: widget.variations.variationImage?.length ?? 0,
                effect: ExpandingDotsEffect(
                    activeDotColor: AppTheme.primaryColor,
                    dotHeight: 8.sp,
                    dotWidth: 8.0,
                    dotColor: AppTheme.primaryColor
                        .withOpacity(0.41)), // your preferred effect
                onDotClicked: (index) {
                  pageController.jumpToPage(index);
                }),
          ),
        ),
        Positioned(
            right: 14.sp,
            top: 16.sp,
            child: IconButton(
                onPressed: () {
                  ConstantMethods.toggleWishlist(
                      WishListType.productDetail, ref);
                },
                icon: SvgPicture.asset(
                  "${Constants.imagePath}add_to_wish.svg",
                  height: ScreenUtil().setSp(20),
                  width: ScreenUtil().setSp(22.0),
                ))),
        Positioned(
            left: 14.sp,
            top: 16.sp,
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "${Constants.imagePath}search.svg",
                  height: ScreenUtil().setSp(17),
                  width: ScreenUtil().setSp(17.0),
                )))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    timer?.cancel();
  }
}
// =======================================================================

// ================= Moon Jewellery Carousel UI ======================

class ProductDetailsJewelleryWidgetSimple extends StatefulHookConsumerWidget {
  final ProductDetail productDetail;
  const ProductDetailsJewelleryWidgetSimple(this.productDetail, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsJewelleryWidgetSimpleState();
}

class _ProductDetailsJewelleryWidgetSimpleState
    extends ConsumerState<ProductDetailsJewelleryWidgetSimple> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 24.sp),
            // height: ScreenUtil().setHeight(350),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.productDetail.productImage ?? "",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    height: ScreenUtil().setHeight(20),
                    width: ScreenUtil().setWidth(20),
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Positioned(
            right: 14.sp,
            top: 16.sp,
            child: IconButton(
                onPressed: () {
                  ConstantMethods.toggleWishlist(
                      WishListType.productDetail, ref);
                },
                icon: SvgPicture.asset(
                  "${Constants.imagePath}add_to_wish.svg",
                  height: ScreenUtil().setSp(20),
                  width: ScreenUtil().setSp(22.0),
                ))),
        Positioned(
            left: 14.sp,
            top: 16.sp,
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "${Constants.imagePath}search.svg",
                  height: ScreenUtil().setSp(17),
                  width: ScreenUtil().setSp(17.0),
                )))
      ],
    );
  }
}
// =======================================================================

// ================= Variation UI ======================================
class ProductDetailsVariationWidget extends HookConsumerWidget {
  final ProductDetailsModelData productDetailsModelData;
  ProductDetailsVariationWidget(this.productDetailsModelData, {super.key});
  var indexOfVariation = 0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencySymbol = ref.watch(currentCurrencySymbolProvider);
    if (productDetailsModelData.productDetail?.type != "simple") {
      indexOfVariation = ref.watch(indexOfJewelleryVariationInProductDetail);
    }
    final localization = AppLocalizations.of(context);
    return Container(
      // height: ScreenUtil().setHeight(450),
      width: ScreenUtil().screenWidth,
      decoration: ShapeDecoration(
        color: AppTheme.appBarAndBottomBarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0.sp, top: 26.0.sp),
            child: Text(
              productDetailsModelData.productDetail?.title ?? "",
              style: AppTheme.lightTheme.textTheme.headlineLarge
                  ?.copyWith(fontSize: 23.sp),
            ),
          ),
          SizedBox(
            height: 11.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Text(
              "$currencySymbol ${productDetailsModelData.productDetail?.type != "simple" ? productDetailsModelData.productDetail?.variations![indexOfVariation].price.toString() ?? "0.0" : productDetailsModelData.productDetail?.price.toString() ?? "0.0"}",
              style: AppTheme.lightTheme.textTheme.labelMedium
                  ?.copyWith(fontSize: 17.sp),
            ),
          ),
          SizedBox(
            height: 11.sp,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                children: [
                  RatingStars(
                    value: double.parse(productDetailsModelData
                            .productDetail?.rating
                            .toString() ??
                        "0.0"),
                    onValueChanged: (v) {
                      //
                    },
                    starBuilder: (index, color) => ColorFiltered(
                      colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
                      child: SvgPicture.asset(
                          "${Constants.imagePath}empty_star.svg"),
                    ),
                    starCount: 5,
                    starSize: ScreenUtil().setSp(14),
                    maxValue: 5,
                    starSpacing: 2,
                    maxValueVisibility: true,
                    valueLabelVisibility: false,
                    animationDuration: Duration(milliseconds: 1000),
                    starOffColor: AppTheme.strokeColor,
                    starColor: AppTheme.primaryColor,
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  Text(
                      "(${productDetailsModelData.productDetail?.ratingCount ?? ""})",
                      textAlign: TextAlign.center,
                      style: AppTheme.lightTheme.textTheme.labelSmall),
                ],
              )),
          SizedBox(
            height: 16.sp,
          ),
          ConstantMethods.customDivider(),
          SizedBox(
            height: 16.sp,
          ),
          productDetailsModelData.productDetail?.type != "simple"
              ? Visibility(
                  visible:
                      productDetailsModelData.productDetail?.type != "simple",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${localization.color} ",
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(color: AppTheme.primaryColor),
                              ),
                              TextSpan(
                                  text: productDetailsModelData
                                          .productDetail
                                          ?.variations![indexOfVariation]
                                          .termName ??
                                      "",
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                          color: AppTheme.primaryColor,
                                          fontSize: 16.sp)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      Visibility(
                        visible: productDetailsModelData.productDetail?.type !=
                            "simple",
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                          child: SizedBox(
                            height: ScreenUtil().setHeight(40),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productDetailsModelData
                                  .productDetail?.variations?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.0.sp),
                                  child: InkWell(
                                    onTap: () {
                                      ref
                                          .read(
                                              indexOfJewelleryVariationInProductDetail
                                                  .notifier)
                                          .state = index;
                                    },
                                    child: Container(
                                      width: 39.sp,
                                      height: 38.sp,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: CircleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: indexOfVariation == index
                                                  ? AppTheme.subTextColor
                                                  : AppTheme.strokeColor),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0.sp),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(19.sp),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: productDetailsModelData
                                                    .productDetail
                                                    ?.variations?[index]
                                                    .termImage ??
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
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 22.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: localization.availability,
                    style: AppTheme.lightTheme.textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: productDetailsModelData
                                    .productDetail?.stockQuantity !=
                                null &&
                            productDetailsModelData
                                    .productDetail!.stockQuantity! >
                                0
                        ? "${productDetailsModelData.productDetail?.type != "simple" ? productDetailsModelData.productDetail?.variations![indexOfVariation].stockQuantity : productDetailsModelData.productDetail?.stockQuantity ?? 0} in stock"
                        : "Out of Stock",
                    style: AppTheme.lightTheme.textTheme.bodySmall
                        ?.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24.sp,
          ),
          ConstantMethods.customDivider(),
          SizedBox(
            height: 15.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: HtmlWidget(convertHtmlToHeartList(
                productDetailsModelData.productDetail?.sizeToFit ?? "")),
          ),
          SizedBox(
            height: 24.sp,
          ),
        ],
      ),
    );
  }
}

String convertHtmlToHeartList(String html) {
  final document = html_parser.parse(html);
  final listItems = document.querySelectorAll('li');

  final buffer = StringBuffer();
  for (var item in listItems) {
    final text = item.text.trim();
    if (text.isNotEmpty) {
      buffer.writeln('<p>🩷 $text</p>');
    }
  }

  return buffer.toString();
}
//======================================================================

// ================= Image viewer ======================================
class ProductDetailImageViewer extends StatefulHookConsumerWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ProductDetailImageViewer(
      {super.key, required this.imageUrls, required this.initialIndex});

  @override
  _ProductDetailImageViewerState createState() =>
      _ProductDetailImageViewerState();
}

class _ProductDetailImageViewerState
    extends ConsumerState<ProductDetailImageViewer> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return InteractiveImage(
            imageUrl: widget.imageUrls[index],
          );
        },
      ),
    );
  }
}

class InteractiveImage extends StatefulHookConsumerWidget {
  final String imageUrl;

  const InteractiveImage({super.key, required this.imageUrl});

  @override
  _InteractiveImageState createState() => _InteractiveImageState();
}

class _InteractiveImageState extends ConsumerState<InteractiveImage> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        transformationController: _transformationController,
        panEnabled: true, // Enable panning
        boundaryMargin: EdgeInsets.all(20),
        minScale: 1.0,
        maxScale: 5.0,
        onInteractionEnd: (details) {
          // Optional: Reset zoom level when interaction ends
          if (_transformationController.value.getMaxScaleOnAxis() < 1.1) {
            _transformationController.value = Matrix4.identity();
          }
        },
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: widget.imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: SizedBox(
              height: ScreenUtil().setHeight(20),
              width: ScreenUtil().setWidth(20),
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

// ===================================================================================