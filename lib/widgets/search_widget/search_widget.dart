import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/home_widgets.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:dikla_spirit/widgets/search_widget/search_notifier.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
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
              Stack(
                children: [],
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
                            style: AppTheme.lightTheme.textTheme.headlineLarge
                                ?.copyWith(fontSize: 18.sp)),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                            'Sorry, we couldn’t find any matching\nresult for your Search',
                            textAlign: TextAlign.center,
                            style: AppTheme.lightTheme.textTheme.bodySmall
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
                                  width: 1, color: AppTheme.subTextColor),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Explore Catgories',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                      fontSize: 12.sp,
                                      color: AppTheme.appBarAndBottomBarColor,
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
                Flexible(
                  fit: FlexFit.loose, // Adjusts the ListView height dynamically
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.appBarAndBottomBarColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Text(
                            'Product Suggestion',
                            style: AppTheme.lightTheme.textTheme.titleMedium
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
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 15.h),
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
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 10
                                              .w), // Add spacing between image and text
                                      Expanded(
                                        // Prevents text from overflowing
                                        child: Text(
                                          searchResults[index].title ?? "",
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall,
                                          overflow: TextOverflow
                                              .ellipsis, // Handle long text
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 27.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  'Recent Purchase\nFrom Dikla Spirit',
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
                      return HomeFastResultsWidget(data.data?.products ?? [],
                          WishListType.searchRecentPurchase);
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
              )
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
