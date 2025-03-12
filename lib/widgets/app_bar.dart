import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarState extends ConsumerState<CustomAppBar> {
  @override
  void didUpdateWidget(covariant CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _updateWishlistCount();
    // ref.watch(wishlistDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final scaffoldKey = ref.read(scaffoldKeyProvider);
    return AppBar(
      actions: [
        Row(
          children: [
            InkWell(
              onTap: () {
                context.push("/search_widget");
              },
              child: SvgPicture.asset(
                "assets/images/search.svg",
                height: 20.sp,
              ),
            ),
            SizedBox(
              width: 16.sp,
            ),
            WishlistWidget(),
            SizedBox(
              width: 20.sp,
            ),
          ],
        )
      ],
      leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: SvgPicture.asset("${Constants.imagePathHome}menu.svg")),
      title: Text(
        localization.title,
        style: const TextStyle(color: AppTheme.primaryColor),
      ),
      // CustomText(
      //     localization.title, ThemeData.light().textTheme.titleLarge!),
      centerTitle: true,
    );
  }

  // void _updateWishlistCount() async {
  //   final wishlistData = ref.watch(wishListApiProvider);
  //   wishlistData.when(
  //     data: (data) {
  //       if (data.data != null) {
  //         setState(() {
  //           if (data.data!.wishlist!.isNotEmpty) {
  //             _wishlistCount = data.data!.wishlist!.length;
  //           }
  //         });
  //       }
  //     },
  //     error: (_, __) {},
  //     loading: () {},
  //   );
  // }
}

class WishlistWidget extends HookConsumerWidget {
  WishlistWidget({super.key});

  int _wishlistCount = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishListData = ref.watch(wishListApiProvider);
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
            onTap: () {
              wishListData.whenData(
                (value) {
                  final data = value.data ?? WishlistModelData(wishlist: []);
                  if (data.wishlist != null && data.wishlist!.isNotEmpty) {
                    ConstantMethods.wishlistPopUP(context, wishListData);
                  } else {
                    context.push("/wishlist");
                  }
                },
              );
            },
            child: wishListData.when(
              data: (data) {
                if (data.data != null) {
                  _wishlistCount = data.data?.wishlist?.length ?? 0;
                  return Badge(
                    label: Text("$_wishlistCount"),
                    largeSize: 13.sp,
                    smallSize: 13.sp,
                    textColor: AppTheme.textColor,
                    backgroundColor: AppTheme.secondaryColor,
                    textStyle: AppTheme.lightTheme.textTheme.bodySmall
                        ?.copyWith(fontSize: 9.sp),
                    child: SvgPicture.asset(
                      "assets/images/wishlist.svg",
                      height: 18.sp,
                    ),
                  );
                }
                return SizedBox();
              },
              error: (_, __) {
                return Badge(
                  label: Text("$_wishlistCount"),
                  largeSize: 13.sp,
                  smallSize: 5.sp,
                  textColor: AppTheme.textColor,
                  backgroundColor: AppTheme.secondaryColor,
                  child: SvgPicture.asset(
                    "assets/images/wishlist.svg",
                    height: 18.sp,
                  ),
                );
              },
              loading: () {
                return SizedBox();
              },
            ));
      },
    );
  }
}
