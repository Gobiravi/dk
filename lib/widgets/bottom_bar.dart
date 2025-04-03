import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/model/shop_list_model.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/customWidgets.dart';
import 'package:dikla_spirit/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomBottomBar extends ConsumerStatefulWidget {
  const CustomBottomBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomBottomBarState();
}

class _CustomBottomBarState extends ConsumerState<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final indexOfBottomNavbar = ref.watch(indexOfBottomNavbarProvider);
    final shopListModel = ref.watch(shopListApiProvider);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      child: SizedBox(
        height: 90.sp,
        child: BottomNavigationBar(
            currentIndex: indexOfBottomNavbar,
            type: BottomNavigationBarType.fixed,
            iconSize: 19.sp,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset("${Constants.imagePath}home.svg"),
                  ),
                  label: localization.home,
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset(
                        "${Constants.imagePath}home_active.svg"),
                  )),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset("${Constants.imagePath}shop.svg"),
                  ),
                  label: localization.shop,
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset(
                        "${Constants.imagePath}shop_active.svg"),
                  )),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset("${Constants.imagePath}cart.svg"),
                  ),
                  label: localization.cart,
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset(
                        "${Constants.imagePath}cart_active.svg"),
                  )),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child:
                        SvgPicture.asset("${Constants.imagePath}account.svg"),
                  ),
                  label: localization.myAccount,
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset(
                        "${Constants.imagePath}account_active.svg"),
                  )),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset("${Constants.imagePath}chat.svg"),
                  ),
                  label: localization.chat,
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 4.sp, bottom: 3.sp),
                    child: SvgPicture.asset("${Constants.imagePath}chat.svg"),
                  ))
            ],
            showUnselectedLabels: true,
            unselectedLabelStyle: AppTheme.lightTheme.textTheme.bodySmall
                ?.copyWith(fontSize: 10.sp),
            selectedLabelStyle: AppTheme.lightTheme.textTheme.bodySmall
                ?.copyWith(fontSize: 10.sp),
            onTap: (value) {
              _onTapBottomBar(context, value, shopListModel);
              ref
                  .read(indexOfBottomNavbarProvider.notifier)
                  .update((state) => value);
            }),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    if (location.startsWith('/dashboard')) return 0;
    // if (location.startsWith('/profile')) return 1;
    if (location.startsWith('/cart')) return 2;
    if (location.startsWith('/cart')) return 3;
    return 0;
  }

  void _onTapBottomBar(BuildContext context, int index,
      AsyncValue<ShopListModel> shopListModel) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        showShopList(shopListModel);
        break;
      case 2:
        ref.refresh(myCartApiProvider);
        context.go('/cart');
        break;
      case 3:
        final scaffoldKey = ref.read(scaffoldKeyProvider);
        scaffoldKey.currentState?.openDrawer();
        break;
      case 4:
        break;
    }
  }

  // showShopList(AsyncValue<ShopListModel> shopListModel) {
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return Consumer(
  //         builder: (context, ref, child) {
  //           return Container(
  //               decoration: const BoxDecoration(
  //                   color: AppTheme.appBarAndBottomBarColor,
  //                   borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(12.0),
  //                       topRight: Radius.circular(12.0))),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(
  //                             Icons.close,
  //                             color: Colors.transparent,
  //                           )),
  //                       CustomText("Shop Categories",
  //                           ThemeData.light().textTheme.labelMedium!),
  //                       IconButton(
  //                           onPressed: () {
  //                             ref
  //                                 .read(indexOfBottomNavbarProvider.notifier)
  //                                 .state = 0;
  //                             context.pop();
  //                           },
  //                           icon: const Icon(
  //                             Icons.close,
  //                             color: AppTheme.textColor,
  //                           ))
  //                     ],
  //                   ),
  //                   const Divider(),
  //                   SizedBox(
  //                     height: ScreenUtil().screenHeight / 2.15,
  //                     child: Padding(
  //                       padding: EdgeInsets.only(
  //                           left: 18.0.sp,
  //                           top: 20.0.sp,
  //                           right: 18.0.sp,
  //                           bottom: 16.sp),
  //                       child: shopListModel.when(
  //                         data: (data) {
  //                           return Column(
  //                             children: [
  //                               Expanded(
  //                                 child: GridView.builder(
  //                                   scrollDirection: Axis.vertical,
  //                                   gridDelegate:
  //                                       SliverGridDelegateWithFixedCrossAxisCount(
  //                                           crossAxisCount: 2,
  //                                           crossAxisSpacing: 12.0,
  //                                           mainAxisSpacing: 10.0,
  //                                           childAspectRatio: 0.8,
  //                                           mainAxisExtent:
  //                                               ScreenUtil().setHeight(90)),
  //                                   itemCount: data.data?.menus?.length,
  //                                   itemBuilder: (context, index) {
  //                                     return GestureDetector(
  //                                       onTap: () {
  //                                         int digitCount = data
  //                                             .data!.menus![index].id!
  //                                             .replaceAll(RegExp(r'\D'), '')
  //                                             .length;
  //                                         ref
  //                                             .read(indexOfBottomNavbarProvider
  //                                                 .notifier)
  //                                             .state = 0;
  //                                         context.pop();
  //                                         if (data.data!.menus![index]
  //                                                     .children !=
  //                                                 null &&
  //                                             data.data!.menus![index].children!
  //                                                 .isNotEmpty) {
  //                                           showSubCategoryList(
  //                                               data.data!.menus![index]
  //                                                       .children ??
  //                                                   [],
  //                                               data.data!.menus![index]
  //                                                       .title ??
  //                                                   "");
  //                                         } else {
  //                                           ref
  //                                               .read(
  //                                                   indexOfBottomNavbarProvider
  //                                                       .notifier)
  //                                               .update((state) => 0);
  //                                           if (digitCount > 3) {
  //                                             context.push("/product_detail",
  //                                                 extra: {
  //                                                   "id": data
  //                                                       .data!.menus![index].id
  //                                                       .toString(),
  //                                                   "isMoonJewelry": false,
  //                                                   "name": data
  //                                                           .data!
  //                                                           .menus![index]
  //                                                           .title ??
  //                                                       ""
  //                                                 });
  //                                           } else {
  //                                             context.push("/product", extra: {
  //                                               "id": data.data!.menus![index]
  //                                                       .id ??
  //                                                   "",
  //                                               "name": data.data!.menus![index]
  //                                                       .title ??
  //                                                   ""
  //                                             });
  //                                           }
  //                                         }
  //                                       },
  //                                       child: Container(
  //                                         decoration: ShapeDecoration(
  //                                           color: AppTheme
  //                                               .appBarAndBottomBarColor,
  //                                           shape: RoundedRectangleBorder(
  //                                             side: BorderSide(
  //                                                 width: 1,
  //                                                 color: AppTheme.strokeColor
  //                                                     .withOpacity(0.41)),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(12),
  //                                           ),
  //                                         ),
  //                                         child: Padding(
  //                                           padding: EdgeInsets.symmetric(
  //                                             horizontal: 8.sp,
  //                                           ),
  //                                           child: Row(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment
  //                                                     .spaceBetween,
  //                                             children: [
  //                                               Padding(
  //                                                 padding: EdgeInsets.only(
  //                                                     top: 8.sp),
  //                                                 child: Container(
  //                                                   // color: Colors.orange,
  //                                                   width: ScreenUtil()
  //                                                       .setWidth(75),
  //                                                   child: Text(
  //                                                     data.data!.menus![index]
  //                                                             .title ??
  //                                                         "",
  //                                                     style: ThemeData.light()
  //                                                         .textTheme
  //                                                         .labelMedium!,
  //                                                     softWrap: true,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                     maxLines: 2,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               Center(
  //                                                 child: ClipRRect(
  //                                                   borderRadius:
  //                                                       BorderRadius.all(
  //                                                           Radius.circular(
  //                                                               8.sp)),
  //                                                   child: CachedNetworkImage(
  //                                                     fit: BoxFit.cover,
  //                                                     imageUrl: data
  //                                                             .data!
  //                                                             .menus![index]
  //                                                             .image ??
  //                                                         "",
  //                                                     height: 66.sp,
  //                                                     width: 78.sp,
  //                                                     progressIndicatorBuilder:
  //                                                         (context, url,
  //                                                                 downloadProgress) =>
  //                                                             Center(
  //                                                       child: SizedBox(
  //                                                         height: ScreenUtil()
  //                                                             .setHeight(20),
  //                                                         width: ScreenUtil()
  //                                                             .setWidth(20),
  //                                                         child: CircularProgressIndicator(
  //                                                             value:
  //                                                                 downloadProgress
  //                                                                     .progress),
  //                                                       ),
  //                                                     ),
  //                                                     errorWidget: (context,
  //                                                             url, error) =>
  //                                                         const Icon(
  //                                                             Icons.error),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               ),
  //                               SizedBox(
  //                                 height: 30.sp,
  //                               ),
  //                               HomeFastResultsWidget(
  //                                   data.data?.bestSelling ?? [],
  //                                   WishListType.shopBestSellingWishlist),
  //                               SizedBox(
  //                                 height: 30.sp,
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                         error: (error, stackTrace) {
  //                           print("Shop List Error: ${stackTrace.toString()}");
  //                           return;
  //                         },
  //                         loading: () {
  //                           final spinkit = SpinKitPumpingHeart(
  //                             color: AppTheme.appBarAndBottomBarColor,
  //                             size: ScreenUtil().setHeight(50),
  //                           );
  //                           return Center(child: spinkit);
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ));
  //         },
  //       );
  //     },
  //   );
  // }

  showShopList(AsyncValue<ShopListModel> shopListModel) {
    showModalBottomSheet(
      isScrollControlled: true, // Allows full-screen height usage
      context: context,
      backgroundColor: Colors.transparent, // Removes default background
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            return DraggableScrollableSheet(
              initialChildSize: 0.7, // Start height (70% of screen)
              minChildSize: 0.5, // Minimum height (50% of screen)
              maxChildSize: 0.95, // Maximum height (95% of screen)
              expand: false, // Prevents expanding to full-screen
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.appBarAndBottomBarColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      /// Close Button & Title
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
                          CustomText(
                            "Shop Categories",
                            ThemeData.light().textTheme.labelMedium!,
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(indexOfBottomNavbarProvider.notifier)
                                  .state = 0;
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppTheme.textColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),

                      /// Scrollable Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 20.0.sp,
                            bottom: 16.sp,
                          ),
                          child: shopListModel.when(
                            data: (data) {
                              Future.microtask(
                                () {
                                  ref
                                      .read(wishlistProvider.notifier)
                                      .initializeShopBestSellingWishlist(
                                          data.data?.bestSelling ?? []);
                                },
                              );
                              return SingleChildScrollView(
                                controller:
                                    scrollController, // Enables sheet scrolling
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0.sp),
                                      child: GridView.builder(
                                        controller:
                                            scrollController, // Sync with draggable sheet
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12.0,
                                          mainAxisSpacing: 10.0,
                                          childAspectRatio: 0.8,
                                          mainAxisExtent:
                                              ScreenUtil().setHeight(90),
                                        ),
                                        itemCount: data.data?.menus?.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              int digitCount = data
                                                  .data!.menus![index].id!
                                                  .replaceAll(RegExp(r'\D'), '')
                                                  .length;
                                              ref
                                                  .read(
                                                      indexOfBottomNavbarProvider
                                                          .notifier)
                                                  .state = 0;
                                              context.pop();
                                              if (data.data!.menus![index]
                                                          .children !=
                                                      null &&
                                                  data.data!.menus![index]
                                                      .children!.isNotEmpty) {
                                                showSubCategoryList(
                                                    data.data!.menus![index]
                                                            .children ??
                                                        [],
                                                    data.data!.menus![index]
                                                            .title ??
                                                        "",
                                                    data.data?.bestSelling ??
                                                        []);
                                              } else {
                                                ref
                                                    .read(
                                                        indexOfBottomNavbarProvider
                                                            .notifier)
                                                    .update((state) => 0);
                                                if (digitCount > 3) {
                                                  context.push(
                                                      "/product_detail",
                                                      extra: {
                                                        "id": data.data!
                                                            .menus![index].id
                                                            .toString(),
                                                        "isMoonJewelry": false,
                                                        "name": data
                                                                .data!
                                                                .menus![index]
                                                                .title ??
                                                            ""
                                                      });
                                                } else {
                                                  context
                                                      .push("/product", extra: {
                                                    "id": data.data!
                                                            .menus![index].id ??
                                                        "",
                                                    "name": data
                                                            .data!
                                                            .menus![index]
                                                            .title ??
                                                        ""
                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              decoration: ShapeDecoration(
                                                color: AppTheme
                                                    .appBarAndBottomBarColor,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: AppTheme.strokeColor
                                                        .withOpacity(0.41),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.sp),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.sp),
                                                      child: SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(75),
                                                        child: Text(
                                                          data
                                                                  .data!
                                                                  .menus![index]
                                                                  .title ??
                                                              "",
                                                          style:
                                                              ThemeData.light()
                                                                  .textTheme
                                                                  .labelMedium!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.sp)),
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: data
                                                                  .data!
                                                                  .menus![index]
                                                                  .image ??
                                                              "",
                                                          height: 66.sp,
                                                          width: 78.sp,
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
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value:
                                                                    downloadProgress
                                                                        .progress,
                                                              ),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
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
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0.sp),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Best Selling  Products',
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color:
                                                        AppTheme.primaryColor,
                                                    fontSize: 22.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30.sp),
                                    HomeFastResultsWidget(
                                      data.data?.bestSelling ?? [],
                                      WishListType.shopBestSellingWishlist,
                                    ),
                                    SizedBox(height: 30.sp),
                                  ],
                                ),
                              );
                            },
                            error: (error, stackTrace) {
                              print(
                                  "Shop List Error: ${stackTrace.toString()}");
                              return Center(child: Text("Error loading shops"));
                            },
                            loading: () {
                              return Center(
                                child: SpinKitPumpingHeart(
                                  color: AppTheme.appBarAndBottomBarColor,
                                  size: ScreenUtil().setHeight(50),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // showSubCategoryList(List<ShopListModelMenusChildren> subCats, String title) {
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return Consumer(
  //         builder: (context, ref, child) {
  //           return Container(
  //             decoration: const BoxDecoration(
  //                 color: AppTheme.appBarAndBottomBarColor,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(12.0),
  //                     topRight: Radius.circular(12.0))),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     IconButton(
  //                         onPressed: () {},
  //                         icon: const Icon(
  //                           Icons.close,
  //                           color: Colors.transparent,
  //                         )),
  //                     CustomText(
  //                         title, ThemeData.light().textTheme.labelMedium!),
  //                     IconButton(
  //                         onPressed: () {
  //                           ref
  //                               .read(indexOfBottomNavbarProvider.notifier)
  //                               .state = 0;
  //                           context.pop();
  //                         },
  //                         icon: const Icon(
  //                           Icons.close,
  //                           color: AppTheme.textColor,
  //                         ))
  //                   ],
  //                 ),
  //                 const Divider(),
  //                 SizedBox(
  //                   height: ScreenUtil().screenHeight / 2.15,
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(top: 10.0),
  //                     child: ListView.separated(
  //                       separatorBuilder: (context, index) {
  //                         return Padding(
  //                           padding: const EdgeInsets.only(bottom: 8.0),
  //                           child: Divider(),
  //                         );
  //                       },
  //                       scrollDirection: Axis.vertical,
  //                       itemCount: subCats.length,
  //                       itemBuilder: (context, index) {
  //                         return Padding(
  //                           padding: const EdgeInsets.only(bottom: 8.0),
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               ref
  //                                   .read(indexOfBottomNavbarProvider.notifier)
  //                                   .state = 0;
  //                               context.pop();
  //                               context.push("/product", extra: {
  //                                 "id": subCats[index].id ?? "",
  //                                 "name": subCats[index].title ?? ""
  //                               });
  //                             },
  //                             child: Container(
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 8.0),
  //                                 child: Row(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     CustomText(
  //                                         subCats[index].title ?? "",
  //                                         ThemeData.light()
  //                                             .textTheme
  //                                             .labelSmall!
  //                                             .copyWith(fontSize: 16.sp)),
  //                                     Icon(
  //                                       Icons.arrow_forward_ios_sharp,
  //                                       color: AppTheme.textColor,
  //                                       size: 9.sp,
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  showSubCategoryList(List<ShopListModelMenusChildren> subCats, String title,
      List<DashboardModelFastResult> bestSelling) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.appBarAndBottomBarColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      /// Header with Close Button & Title
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
                          CustomText(
                            title,
                            ThemeData.light().textTheme.labelMedium!,
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(indexOfBottomNavbarProvider.notifier)
                                  .state = 0;
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppTheme.textColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),

                      /// Scrollable Content
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              /// Subcategory List
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const Padding(
                                      padding: EdgeInsets.only(bottom: 8.0),
                                      child: Divider(),
                                    );
                                  },
                                  itemCount: subCats.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(indexOfBottomNavbarProvider
                                                  .notifier)
                                              .state = 0;
                                          context.pop();
                                          context.push("/product", extra: {
                                            "id": subCats[index].id ?? "",
                                            "name": subCats[index].title ?? ""
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                subCats[index].title ?? "",
                                                ThemeData.light()
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(fontSize: 16.sp),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                color: AppTheme.textColor,
                                                size: 9.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0.sp, top: 20.sp),
                                child: Row(
                                  children: [
                                    Text(
                                      'Best Selling Products',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(
                                              color: AppTheme.primaryColor,
                                              fontSize: 22.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.sp),
                              HomeFastResultsWidget(
                                bestSelling,
                                WishListType.shopBestSellingWishlist,
                              ),
                              SizedBox(height: 30.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
