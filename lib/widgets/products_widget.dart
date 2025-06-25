import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/product_details_model.dart';
import 'package:dikla_spirit/model/product_filter_opt_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductFilterWidget extends StatefulHookConsumerWidget {
  ProductFilterOptionsModel productFilterOptionsModel;
  ProductFilterWidget(this.productFilterOptionsModel, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends ConsumerState<ProductFilterWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final localization = AppLocalizations.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.appBarAndBottomBarColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0.r),
              topRight: Radius.circular(12.0.r),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
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
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).filterBy,
                      style: AppTheme.lightTheme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppTheme.textColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Divider(
                  height: 0.3,
                ),
                Column(
                  children: [
                    widget.productFilterOptionsModel.data != null &&
                            widget.productFilterOptionsModel.data!.categories !=
                                null &&
                            widget.productFilterOptionsModel.data!.categories
                                .isNotEmpty
                        ? Column(
                            children: [
                              _buildExpandableListOfCategory(context,
                                  "Category", widget.productFilterOptionsModel),
                              const Divider(
                                height: 0.30,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),

                    _buildExpandableListOfRating(context, "Rating", ref),
                    const Divider(),
                    PriceSelector(
                      title: "Price range",
                      maxPrice: double.parse(widget
                              .productFilterOptionsModel.data?.price
                              .toString() ??
                          "0.0"),
                      initialMinPrice: double.parse(widget
                                  .productFilterOptionsModel.data?.price
                                  .toString() ??
                              "0.0") /
                          4,
                      initialMaxPrice: double.parse(widget
                              .productFilterOptionsModel.data?.price
                              .toString() ??
                          "0.0"),
                      onPriceChanged: (minPrice, maxPrice) {
                        print("Min Price: $minPrice, Max Price: $maxPrice");
                      },
                    ),
                    // _buildPriceSelector(
                    //   context, "Price Range",
                    //   ), // Maximum allowable price
                    //   double.parse(widget.productFilterOptionsModel.data?.price
                    //           .toString() ??
                    //       "0.0"),
                    //   (minPrice, maxPrice) {
                    //     print("Min Price: $minPrice, Max Price: $maxPrice");
                    //   },
                    // ),
                  ],
                ),
                const Divider(),
                SizedBox(height: 14.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                        context,
                        AppLocalizations.of(context).clearAll,
                        AppTheme.appBarAndBottomBarColor,
                        AppTheme.subTextColor),
                    _buildActionButton(
                        context,
                        AppLocalizations.of(context).showResults,
                        AppTheme.subTextColor,
                        AppTheme.appBarAndBottomBarColor),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  // return Container(
  //   decoration: const BoxDecoration(
  //       color: AppTheme.appBarAndBottomBarColor,
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
  //   child: Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.close,
  //                 color: Colors.transparent,
  //               )),
  //           Text(localization.sortBy,
  //               style: ThemeData.light().textTheme.labelMedium!),
  //           IconButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               icon: const Icon(
  //                 Icons.close,
  //                 color: AppTheme.textColor,
  //               ))
  //         ],
  //       ),
  //       SingleChildScrollView(
  //         scrollDirection: Axis.vertical,
  //         child: Column(
  //           children: [
  //             Card(
  //               color: AppTheme.appBarAndBottomBarColor,
  //               elevation: 0,
  //               borderOnForeground: false,
  //               child: ExpansionTile(
  //                 title: Text(
  //                   "Category",
  //                   style: Theme.of(context).textTheme.bodyMedium,
  //                 ),
  //                 children: [
  //                   SizedBox(
  //                     height: ScreenUtil().setHeight(300),
  //                     child: Padding(
  //                         padding:
  //                             const EdgeInsets.only(top: 2.0, left: 12.0),
  //                         child: ListView.builder(
  //                           scrollDirection: Axis.vertical,
  //                           itemCount: widget.productFilterOptionsModel.data
  //                               ?.categories.length,
  //                           itemBuilder: (context, index) {
  //                             return Row(
  //                               children: [
  //                                 Checkbox.adaptive(
  //                                   checkColor: AppTheme.primaryColor,
  //                                   activeColor: AppTheme.appBgColor,
  //                                   value: widget.productFilterOptionsModel
  //                                       .data?.categories[index].isSelected,
  //                                   onChanged: (bool? newValue) {
  //                                     widget
  //                                         .productFilterOptionsModel
  //                                         .data
  //                                         ?.categories[index]
  //                                         .isSelected = newValue ?? false;
  //                                   },
  //                                 ),
  //                                 GestureDetector(
  //                                   onTap: () {
  //                                     if (widget
  //                                             .productFilterOptionsModel
  //                                             .data
  //                                             ?.categories[index]
  //                                             .isSelected ==
  //                                         null) {
  //                                       widget
  //                                           .productFilterOptionsModel
  //                                           .data
  //                                           ?.categories[index]
  //                                           .isSelected = true;
  //                                     } else {
  //                                       widget
  //                                               .productFilterOptionsModel
  //                                               .data
  //                                               ?.categories[index]
  //                                               .isSelected =
  //                                           !widget
  //                                               .productFilterOptionsModel
  //                                               .data!
  //                                               .categories[index]
  //                                               .isSelected!;
  //                                     }
  //                                   },
  //                                   child: CustomText(
  //                                     widget.productFilterOptionsModel.data
  //                                             ?.categories[index].name ??
  //                                         "",
  //                                     ThemeData.light()
  //                                         .textTheme
  //                                         .labelSmall!
  //                                         .copyWith(fontSize: 14.sp),
  //                                   ),
  //                                 )
  //                               ],
  //                             );
  //                           },
  //                         )),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const Divider(),
  //             Card(
  //               color: AppTheme.appBarAndBottomBarColor,
  //               elevation: 0,
  //               borderOnForeground: false,
  //               child: ExpansionTile(
  //                 title: Text(
  //                   "Category",
  //                   style: Theme.of(context).textTheme.bodyMedium,
  //                 ),
  //                 children: [
  //                   SizedBox(
  //                     height: ScreenUtil().setHeight(300),
  //                     child: Padding(
  //                         padding:
  //                             const EdgeInsets.only(top: 2.0, left: 12.0),
  //                         child: ListView.builder(
  //                           scrollDirection: Axis.vertical,
  //                           itemCount: widget.productFilterOptionsModel.data
  //                               ?.categories.length,
  //                           itemBuilder: (context, index) {
  //                             return Row(
  //                               children: [
  //                                 Checkbox.adaptive(
  //                                   checkColor: AppTheme.primaryColor,
  //                                   activeColor: AppTheme.appBgColor,
  //                                   value: widget.productFilterOptionsModel
  //                                       .data?.categories[index].isSelected,
  //                                   onChanged: (bool? newValue) {
  //                                     widget
  //                                         .productFilterOptionsModel
  //                                         .data
  //                                         ?.categories[index]
  //                                         .isSelected = newValue ?? false;
  //                                   },
  //                                 ),
  //                                 GestureDetector(
  //                                   onTap: () {
  //                                     if (widget
  //                                             .productFilterOptionsModel
  //                                             .data
  //                                             ?.categories[index]
  //                                             .isSelected ==
  //                                         null) {
  //                                       widget
  //                                           .productFilterOptionsModel
  //                                           .data
  //                                           ?.categories[index]
  //                                           .isSelected = true;
  //                                     } else {
  //                                       widget
  //                                               .productFilterOptionsModel
  //                                               .data
  //                                               ?.categories[index]
  //                                               .isSelected =
  //                                           !widget
  //                                               .productFilterOptionsModel
  //                                               .data!
  //                                               .categories[index]
  //                                               .isSelected!;
  //                                     }
  //                                   },
  //                                   child: CustomText(
  //                                     widget.productFilterOptionsModel.data
  //                                             ?.categories[index].name ??
  //                                         "",
  //                                     ThemeData.light()
  //                                         .textTheme
  //                                         .labelSmall!
  //                                         .copyWith(fontSize: 14.sp),
  //                                   ),
  //                                 )
  //                               ],
  //                             );
  //                           },
  //                         )),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),

  //       // SizedBox(
  //       //   height: ScreenUtil().setHeight(300),
  //       //   child: Padding(
  //       //       padding: const EdgeInsets.only(top: 2.0, left: 12.0),
  //       //       child: ListView.builder(
  //       //         scrollDirection: Axis.vertical,
  //       //         itemCount:
  //       //             widget.productFilterOptionsModel.data?.categories.length,
  //       //         itemBuilder: (context, index) {
  //       //           return Row(
  //       //             children: [
  //       //               Checkbox.adaptive(
  //       //                 checkColor: AppTheme.primaryColor,
  //       //                 activeColor: AppTheme.appBgColor,
  //       //                 value: widget.productFilterOptionsModel.data
  //       //                     ?.categories[index].isSelected,
  //       //                 onChanged: (bool? newValue) {
  //       //                   widget
  //       //                       .productFilterOptionsModel
  //       //                       .data
  //       //                       ?.categories[index]
  //       //                       .isSelected = newValue ?? false;
  //       //                 },
  //       //               ),
  //       //               GestureDetector(
  //       //                 onTap: () {
  //       //                   if (widget.productFilterOptionsModel.data
  //       //                           ?.categories[index].isSelected ==
  //       //                       null) {
  //       //                     widget.productFilterOptionsModel.data
  //       //                         ?.categories[index].isSelected = true;
  //       //                   } else {
  //       //                     widget.productFilterOptionsModel.data
  //       //                             ?.categories[index].isSelected =
  //       //                         !widget.productFilterOptionsModel.data!
  //       //                             .categories[index].isSelected!;
  //       //                   }
  //       //                 },
  //       //                 child: CustomText(
  //       //                   widget.productFilterOptionsModel.data
  //       //                           ?.categories[index].name ??
  //       //                       "",
  //       //                   ThemeData.light()
  //       //                       .textTheme
  //       //                       .labelSmall!
  //       //                       .copyWith(fontSize: 14.sp),
  //       //                 ),
  //       //               )
  //       //             ],
  //       //           );
  //       //         },
  //       //       )),
  //       // ),
  //       const Divider(),
  //       SizedBox(
  //         height: 14.sp,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           SizedBox(
  //             width: ScreenUtil().screenWidth / 2.2,
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 // Button press action
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: AppTheme
  //                     .appBarAndBottomBarColor, // Transparent background
  //                 // foregroundColor: Colors.blue, // Text color
  //                 side: const BorderSide(
  //                   color: AppTheme.subTextColor, // Border color
  //                   width: 1.0, // Border width
  //                 ),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(
  //                       ScreenUtil().setSp(13)), // Border radius
  //                 ),
  //               ),
  //               child: Text(
  //                 localization.clearAll,
  //                 style: AppTheme.lightTheme.textTheme.labelSmall,
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: ScreenUtil().screenWidth / 2.2,
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 // Button press action
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor:
  //                     AppTheme.subTextColor, // Transparent background
  //                 // foregroundColor: Colors.blue, // Text color
  //                 side: const BorderSide(
  //                   color: AppTheme.subTextColor, // Border color
  //                   width: 1.0, // Border width
  //                 ),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(
  //                       ScreenUtil().setSp(13)), // Border radius
  //                 ),
  //               ),
  //               child: Text(
  //                 localization.showResults,
  //                 style: AppTheme.lightTheme.textTheme.labelSmall
  //                     ?.copyWith(color: AppTheme.appBarAndBottomBarColor),
  //               ),
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //   ),
  // );
}

Widget _buildExpandableListOfCategory(BuildContext context, String title,
    ProductFilterOptionsModel productFilterOptionsModel) {
  return Card(
    color: AppTheme.appBarAndBottomBarColor,
    elevation: 0,
    child: ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes default border
        side: BorderSide.none, // Removes the line
      ),
      // tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium
            ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(300),
          child: Padding(
            padding: EdgeInsets.only(top: 2.0.h, left: 12.0.w),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: productFilterOptionsModel.data?.categories.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox.adaptive(
                      checkColor: AppTheme.primaryColor,
                      activeColor: AppTheme.appBgColor,
                      value: productFilterOptionsModel
                              .data?.categories[index].isSelected ??
                          false,
                      onChanged: (bool? newValue) {
                        productFilterOptionsModel.data?.categories[index]
                            .isSelected = newValue ?? false;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        productFilterOptionsModel.data?.categories[index]
                            .isSelected = !(productFilterOptionsModel
                                .data?.categories[index].isSelected ??
                            false);
                      },
                      child: Text(
                        productFilterOptionsModel
                                .data?.categories[index].name ??
                            "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 14.sp),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildExpandableListOfRating(
    BuildContext context, String title, WidgetRef ref) {
  final ratingModel = ref.watch(ratingProvider);
  return Card(
    color: AppTheme.appBarAndBottomBarColor,
    elevation: 0,
    child: ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes default border
        side: BorderSide.none, // Removes the line
      ),
      title: Text(title,
          style: AppTheme.lightTheme.textTheme.bodyMedium
              ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600)),
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(220),
          child: Padding(
            padding: EdgeInsets.only(top: 2.0.h, left: 12.0.w),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: ratingModel.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox.adaptive(
                      checkColor: AppTheme.primaryColor,
                      activeColor: AppTheme.appBgColor,
                      value: ratingModel[index].isSelected,
                      side: BorderSide(
                        color: AppTheme.subTextColor,
                        width: 0.6,
                      ),
                      onChanged: (bool? newValue) {
                        // ratingModel[index].isSelected = newValue ?? false;
                        ref
                            .read(ratingProvider.notifier)
                            .toggleSelection(index);
                      },
                    ),
                    RatingStars(
                      value: ratingModel[index].rating,
                      onValueChanged: (v) {
                        //
                      },
                      starBuilder: (starIndex, color) {
                        bool isFilled =
                            starIndex < ratingModel[index].rating.floor();
                        return ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              color ?? Colors.transparent, BlendMode.srcIn),
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
                      animationDuration: Duration(milliseconds: 1000),
                      valueLabelVisibility: false,
                      starOffColor: AppTheme.strokeColor,
                      starColor: AppTheme.primaryColor,
                    ),
                    SizedBox(
                      width: 6.0.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(ratingProvider.notifier)
                            .toggleSelection(index);
                      },
                      child: Text(
                        ratingModel[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 14.sp),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionButton(
    BuildContext context, String label, Color background, Color textColor) {
  return SizedBox(
    width: ScreenUtil().screenWidth / 2.2,
    child: ElevatedButton(
      onPressed: () {
        // Button press action
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        side: const BorderSide(
          color: AppTheme.subTextColor,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(13)),
        ),
      ),
      child: Text(
        label,
        style:
            Theme.of(context).textTheme.labelSmall!.copyWith(color: textColor),
      ),
    ),
  );
}

class PriceSelector extends StatefulHookConsumerWidget {
  final String title;
  final double maxPrice;
  final double initialMinPrice;
  final double initialMaxPrice;
  final Function(double minPrice, double maxPrice) onPriceChanged;

  PriceSelector({
    super.key,
    required this.title,
    required this.maxPrice,
    required this.initialMinPrice,
    required this.initialMaxPrice,
    required this.onPriceChanged,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PriceSelectorState();
}

class _PriceSelectorState extends ConsumerState<PriceSelector> {
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  late RangeValues priceRange;

  @override
  void initState() {
    super.initState();
    priceRange = RangeValues(widget.initialMinPrice, widget.initialMaxPrice);
    minPriceController =
        TextEditingController(text: priceRange.start.toStringAsFixed(0));
    maxPriceController =
        TextEditingController(text: priceRange.end.toStringAsFixed(0));
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currency = ref.watch(currentCurrencySymbolProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Card(
        color: AppTheme.appBarAndBottomBarColor,
        elevation: 0,
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Removes default border
            side: BorderSide.none, // Removes the line
          ),
          title: Text(widget.title,
              style: AppTheme.lightTheme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Min',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.textColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            width: ScreenUtil().screenWidth / 2.35,
                            child: TextField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                              controller: minPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                          color: AppTheme.strokeColor,
                                          width: 0.2.w)),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.strokeColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.strokeColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  suffix: Text(
                                    currency,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.teritiaryTextColor),
                                  )),
                              onChanged: (value) {
                                final minPrice =
                                    double.tryParse(value) ?? priceRange.start;
                                if (minPrice <= priceRange.end) {
                                  setState(() {
                                    priceRange =
                                        RangeValues(minPrice, priceRange.end);
                                    widget.onPriceChanged(
                                        priceRange.start, priceRange.end);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.textColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            width: ScreenUtil().screenWidth / 2.35,
                            child: TextField(
                              cursorColor: AppTheme.cursorColor,
                              cursorWidth: 1.0,
                              cursorHeight: 18.h,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                              controller: maxPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                          color: AppTheme.strokeColor,
                                          width: 0.2.w)),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.strokeColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.strokeColor,
                                          width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  suffix: Text(
                                    currency,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.teritiaryTextColor),
                                  )),
                              onChanged: (value) {
                                final maxPrice =
                                    double.tryParse(value) ?? priceRange.end;
                                if (maxPrice >= priceRange.start) {
                                  setState(() {
                                    priceRange =
                                        RangeValues(priceRange.start, maxPrice);
                                    widget.onPriceChanged(
                                        priceRange.start, priceRange.end);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: widget.maxPrice,
                    divisions: 100,
                    activeColor: AppTheme.primaryColor,
                    labels: RangeLabels(
                      "$currency ${priceRange.start.toStringAsFixed(0)}",
                      "$currency ${priceRange.end.toStringAsFixed(0)}",
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        priceRange = values;
                        minPriceController.text =
                            values.start.toStringAsFixed(0);
                        maxPriceController.text = values.end.toStringAsFixed(0);
                        widget.onPriceChanged(values.start, values.end);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSortByWidget extends StatefulHookConsumerWidget {
  const ProductSortByWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductSortByWidgetState();
}

class _ProductSortByWidgetState extends ConsumerState<ProductSortByWidget> {
  late List<SortByOptions> options;
  dynamic localization;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localization = AppLocalizations.of(context);
    options = [
      SortByOptions(title: localization.relevance, isSelected: false),
      SortByOptions(title: localization.bestselling, isSelected: false),
      SortByOptions(title: localization.top_rated, isSelected: false),
      SortByOptions(title: localization.price_low_to_high, isSelected: false),
      SortByOptions(title: localization.price_high_to_low, isSelected: false),
      SortByOptions(title: localization.sortBynew, isSelected: false)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppTheme.appBarAndBottomBarColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
      child: Column(
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
                AppLocalizations.of(context).filterBy,
                style: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
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
          // SizedBox(
          //   height: 16.h,
          // ),
          const Divider(),
          SizedBox(
            height: ScreenUtil().setHeight(260),
            child: Padding(
                padding: EdgeInsets.only(top: 2.0.h, left: 12.0.w),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Checkbox.adaptive(
                          checkColor: AppTheme.primaryColor,
                          activeColor: AppTheme.appBgColor,
                          value: options[index].isSelected,
                          side: BorderSide(
                            color: AppTheme.subTextColor,
                            width: 0.6,
                          ),
                          onChanged: (bool? newValue) {
                            setState(() {
                              options[index].isSelected = newValue ?? false;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              options[index].isSelected =
                                  !options[index].isSelected;
                            });
                          },
                          child: Text(
                            options[index].title,
                            style: AppTheme.lightTheme.textTheme.labelSmall!
                                .copyWith(fontSize: 14.sp),
                          ),
                        )
                      ],
                    );
                  },
                )),
          ),
          const Divider(),
          SizedBox(
            height: 14.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: ScreenUtil().screenWidth / 2.2,
                child: ElevatedButton(
                  onPressed: () {
                    // Button press action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme
                        .appBarAndBottomBarColor, // Transparent background
                    // foregroundColor: Colors.blue, // Text color
                    side: const BorderSide(
                      color: AppTheme.subTextColor, // Border color
                      width: 1.0, // Border width
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ScreenUtil().setSp(13)), // Border radius
                    ),
                  ),
                  child: Text(
                    localization.clearAll,
                    style: AppTheme.lightTheme.textTheme.labelSmall,
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().screenWidth / 2.2,
                child: ElevatedButton(
                  onPressed: () {
                    // Button press action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppTheme.subTextColor, // Transparent background
                    // foregroundColor: Colors.blue, // Text color
                    side: const BorderSide(
                      color: AppTheme.subTextColor, // Border color
                      width: 1.0, // Border width
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ScreenUtil().setSp(13)), // Border radius
                    ),
                  ),
                  child: Text(
                    localization.showResults,
                    style: AppTheme.lightTheme.textTheme.labelSmall
                        ?.copyWith(color: AppTheme.appBarAndBottomBarColor),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SortByOptions {
  final String title;
  bool isSelected;

  SortByOptions({required this.title, this.isSelected = false});
}

class FilterRatingModel {
  final String title;
  bool isSelected;
  final double rating;

  FilterRatingModel(
      {required this.title, this.isSelected = false, required this.rating});

  FilterRatingModel copyWith({bool? isSelected}) {
    return FilterRatingModel(
      title: title,
      rating: rating,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class ProvenResultsWidget extends ConsumerStatefulWidget {
  final List<ProvenResult> provenResults;
  const ProvenResultsWidget(this.provenResults, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProvenResultsWidget();
  }
}

class _ProvenResultsWidget extends ConsumerState<ProvenResultsWidget> {
  late PageController pageController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (mounted) {
          if (ref.read(indexOfProvenResultInProductDetail) ==
              widget.provenResults.length - 1) {
            pageController.jumpToPage(0);
          } else {
            pageController.nextPage(
                duration: const Duration(seconds: 1), curve: Curves.easeIn);
          }
        }
      },
    );
    pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          SizedBox(
            height: 16.sp,
          ),
          Text(
            'PROVEN RESULTS',
            style: AppTheme.lightTheme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20.sp,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(90),
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.provenResults.length,
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                ref.read(indexOfProvenResultInProductDetail.notifier).state =
                    value;
              },
              itemBuilder: (context, index) {
                return Container(
                  // height: ScreenUtil().setHeight(130),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.provenResults[index].percentage ?? ""}%",
                        style: AppTheme.lightTheme.textTheme.titleLarge!
                            .copyWith(
                                color: AppTheme.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 26.sp),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.provenResults[index].result ?? "",
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          SmoothPageIndicator(
              controller: pageController, // PageController
              count: widget.provenResults.length,
              effect: ExpandingDotsEffect(
                  activeDotColor: AppTheme.primaryColor,
                  dotHeight: 8.sp,
                  dotWidth: 8.0,
                  dotColor: AppTheme.primaryColor
                      .withOpacity(0.41)), // your preferred effect
              onDotClicked: (index) {
                pageController.jumpToPage(index);
              }),
        ],
      ),
    );
  }
}

// Create a StateNotifier to Manage the List
class RatingNotifier extends StateNotifier<List<FilterRatingModel>> {
  RatingNotifier()
      : super([
          FilterRatingModel(title: "5 Rating", isSelected: true, rating: 5.0),
          FilterRatingModel(title: "4 & up", isSelected: true, rating: 4.0),
          FilterRatingModel(title: "3 & up", isSelected: true, rating: 3.0),
          FilterRatingModel(title: "2 & up", isSelected: true, rating: 2.0),
        ]);

  void toggleSelection(int index) {
    state = List.from(state)
      ..[index] = state[index].copyWith(isSelected: !state[index].isSelected);
  }

  void resetSelection() {
    state = state.map((e) => e.copyWith(isSelected: true)).toList();
  }
}

// Define the Provider
final ratingProvider =
    StateNotifierProvider<RatingNotifier, List<FilterRatingModel>>((ref) {
  return RatingNotifier();
});
