import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/product_details_model.dart';
import 'package:dikla_spirit/model/product_filter_opt_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/widgets/customWidgets.dart';
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
  late List<FilterRatingModel> filterRatingModel;
  @override
  void initState() {
    super.initState();
    filterRatingModel = [
      FilterRatingModel(title: "5 Rating", isSelected: false, rating: 5.0),
      FilterRatingModel(title: "4 & up", isSelected: false, rating: 4.0),
      FilterRatingModel(title: "3 & up", isSelected: false, rating: 3.0),
      FilterRatingModel(title: "2 & up", isSelected: false, rating: 2.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7, // Adjust the initial size
      maxChildSize: 0.7, // Adjust maximum size
      minChildSize: 0.7, // Adjust minimum size
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.appBarAndBottomBarColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
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
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).filterBy,
                      style: ThemeData.light().textTheme.labelMedium!,
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
                Column(
                  children: [
                    _buildExpandableListOfCategory(
                        context, "Category", widget.productFilterOptionsModel),
                    const Divider(),
                    _buildExpandableListOfRating(
                        context, "Rating", filterRatingModel),
                    const Divider(),
                    PriceSelector(
                      title: "Price Range",
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
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(300),
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0, left: 12.0),
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
                          .data?.categories[index].isSelected,
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
                            .labelSmall!
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
    BuildContext context, String title, List<FilterRatingModel> ratingModel) {
  return Card(
    color: AppTheme.appBarAndBottomBarColor,
    elevation: 0,
    child: ExpansionTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(220),
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0, left: 12.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: ratingModel.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox.adaptive(
                      checkColor: AppTheme.primaryColor,
                      activeColor: AppTheme.appBgColor,
                      value: true,
                      onChanged: (bool? newValue) {
                        ratingModel[index].isSelected = newValue ?? false;
                      },
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    RatingStars(
                      value: ratingModel[index].rating,
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
                      animationDuration: Duration(milliseconds: 1000),
                      valueLabelVisibility: false,
                      starOffColor: AppTheme.strokeColor,
                      starColor: AppTheme.primaryColor,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        ratingModel[index].isSelected =
                            !(ratingModel[index].isSelected);
                      },
                      child: Text(
                        ratingModel[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
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

class PriceSelector extends StatefulWidget {
  final String title;
  final double maxPrice;
  final double initialMinPrice;
  final double initialMaxPrice;
  final Function(double minPrice, double maxPrice) onPriceChanged;

  const PriceSelector({
    super.key,
    required this.title,
    required this.maxPrice,
    required this.initialMinPrice,
    required this.initialMaxPrice,
    required this.onPriceChanged,
  });

  @override
  State<PriceSelector> createState() => _PriceSelectorState();
}

class _PriceSelectorState extends State<PriceSelector> {
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
    return Card(
      color: AppTheme.appBarAndBottomBarColor,
      elevation: 0,
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Min',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'NotoSansHebrew',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Max',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'NotoSansHebrew',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: AppTheme.cursorColor,
                        cursorWidth: 1.0,
                        cursorHeight: 18.h,
                        controller: minPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // labelText: "Min Price",
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.strokeColor, width: 0.2)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        cursorColor: AppTheme.cursorColor,
                        cursorWidth: 1.0,
                        cursorHeight: 18.h,
                        controller: maxPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // labelText: "Max Price",
                          border: const OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
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
                const SizedBox(height: 20),
                RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: widget.maxPrice,
                  divisions: 100,
                  activeColor: AppTheme.primaryColor,
                  labels: RangeLabels(
                    priceRange.start.toStringAsFixed(0),
                    priceRange.end.toStringAsFixed(0),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      priceRange = values;
                      minPriceController.text = values.start.toStringAsFixed(0);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: Colors.transparent,
                  )),
              CustomText(localization.sortBy,
                  ThemeData.light().textTheme.labelMedium!),
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
            height: ScreenUtil().setHeight(230),
            child: Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 12.0),
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
                          child: CustomText(
                            options[index].title,
                            ThemeData.light()
                                .textTheme
                                .labelSmall!
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
}

class ProvenResultsWidget extends ConsumerStatefulWidget {
  List<ProvenResult> provenResults;
  ProvenResultsWidget(this.provenResults, {super.key});

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

// class SimilarProductsInDetailWidget extends ConsumerWidget {
//   List<RelatedProduct> relatedProducts;
//   String currency;
//   SimilarProductsInDetailWidget(this.relatedProducts, this.currency,
//       {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SizedBox(
//       height: ScreenUtil().setHeight(270.0),
//       width: ScreenUtil().screenWidth,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: relatedProducts.length,
//         itemBuilder: (context, index) {
//           return Container(
//               width: ScreenUtil().setWidth(160),
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(12)),
//                   color: AppTheme.appBarAndBottomBarColor,
//                   border: Border.all(
//                     color: AppTheme.strokeColor,
//                     width: 0.3,
//                   )),
//               margin: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(12),
//                           topRight: Radius.circular(12.0)),
//                       child: SizedBox.expand(
//                         child: CachedNetworkImage(
//                           fit: BoxFit.fill,
//                           imageUrl: relatedProducts[index].image ?? "",
//                           progressIndicatorBuilder:
//                               (context, url, downloadProgress) => Center(
//                             child: SizedBox(
//                               height: ScreenUtil().setHeight(20),
//                               width: ScreenUtil().setWidth(20),
//                               child: CircularProgressIndicator(
//                                   value: downloadProgress.progress),
//                             ),
//                           ),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12.0,
//                   ),
//                   Expanded(
//                       flex: 1,
//                       child: SizedBox(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 9.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   RatingStars(
//                                     value: double.parse(relatedProducts[index]
//                                         .rating
//                                         .toString()),
//                                     onValueChanged: (v) {
//                                       //
//                                     },
//                                     starBuilder: (index, color) =>
//                                         ColorFiltered(
//                                       colorFilter: ColorFilter.mode(
//                                           color!, BlendMode.srcIn),
//                                       child: SvgPicture.asset(
//                                           "${Constants.imagePath}empty_star.svg"),
//                                     ),
//                                     starCount: 5,
//                                     starSize: ScreenUtil().setSp(20),
//                                     maxValue: 5,
//                                     starSpacing: 2,
//                                     maxValueVisibility: true,
//                                     animationDuration:
//                                         Duration(milliseconds: 1000),
//                                     valueLabelVisibility: false,
//                                     starOffColor: AppTheme.strokeColor,
//                                     starColor: AppTheme.primaryColor,
//                                   ),
//                                   const SizedBox(
//                                     width: 8,
//                                   ),
//                                   Text(
//                                     "(${relatedProducts[index].ratingCount ?? ""})",
//                                     style:
//                                         AppTheme.lightTheme.textTheme.bodySmall,
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Text(
//                                 relatedProducts[index].title ?? "",
//                                 style: AppTheme.lightTheme.textTheme.bodyMedium
//                                     ?.copyWith(
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 maxLines: 1,
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Text(
//                                   '$currency ${relatedProducts[index].price ?? ""}',
//                                   style:
//                                       AppTheme.lightTheme.textTheme.bodyMedium),
//                             ],
//                           ),
//                         ),
//                       )),
//                   SizedBox(
//                     height: 12.sp,
//                   )
//                 ],
//               ));
//         },
//       ),
//     );
//   }
// }
