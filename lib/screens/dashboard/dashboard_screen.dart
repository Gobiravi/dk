import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/wishlist/state/wishlist_state.dart';
import 'package:dikla_spirit/widgets/app_bar.dart';
import 'package:dikla_spirit/widgets/home_widgets.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashboardState = ref.watch(dashboardNotifierProvider);
    final notifier = ref.read(dashboardNotifierProvider.notifier);
    useEffect(() {
      notifier.fetchDashboardData();
      return null;
    }, const []);
    return dashboardState.when(
      loaded: (data) {
        return Scaffold(appBar: CustomAppBar(), body: DashboardBody(data));
      },
      error: (error) {
        SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) {
            ConstantMethods.showSnackbar(context, error.toString());
          },
        );
        if (error == "No internet connection") {
          return NoInternetWidget(
            onRetry: () {
              notifier.fetchDashboardData();
            },
          );
        } else {
          return ConstantMethods.buildErrorUI(
            ref,
            onPressed: () async {
              await ApiUtils.refreshToken();
              notifier.fetchDashboardData();
            },
          );
        }
      },
      loading: () {
        final spinkit = SpinKitPumpingHeart(
          color: AppTheme.appBarAndBottomBarColor,
          size: ScreenUtil().setHeight(50),
        );
        return Center(child: spinkit);
      },
    );
  }
}

class DashboardBody extends HookConsumerWidget {
  final DashboardModel dashboardModel;
  const DashboardBody(this.dashboardModel, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    Future.microtask(
      () {
        final currency =
            CurrencySymbol.fromString(dashboardModel.data?.currency ?? "USD");
        ref.read(currentCurrencySymbolProvider.notifier).state =
            currency.symbol;
        ref
            .read(wishlistProvider.notifier)
            .initializeFastResults(dashboardModel.data?.fastResult ?? []);
        ref
            .read(wishlistProvider.notifier)
            .initializeQuickSolutions(dashboardModel.data?.quickSolution ?? []);
      },
    );
    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .refresh(dashboardNotifierProvider.notifier)
            .fetchDashboardData();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            dashboardModel.data?.menu != null &&
                    dashboardModel.data!.menu.isNotEmpty
                ? HomeMenuWidget(dashboardModel.data!.menu)
                : ConstantMethods.noDataWidget(title: "No Menu Found"),
            dashboardModel.data!.topbanner != null &&
                    dashboardModel.data!.topbanner.isNotEmpty
                ? HomeBestSellingWidget(dashboardModel.data!.topbanner)
                : ConstantMethods.noDataWidget(title: "No Best Selling Found"),
            SizedBox(
              height: 34.0.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.fastResults,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      localization.viewAll,
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          fontSize: 13.sp, color: AppTheme.secondaryTextColor),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 19.0.sp,
            ),
            dashboardModel.data!.fastResult != null &&
                    dashboardModel.data!.fastResult.isNotEmpty
                ? HomeFastResultsWidget(
                    dashboardModel.data!.fastResult, WishListType.fast)
                : ConstantMethods.noDataWidget(title: "No Fast Results Found"),
            SizedBox(
              height: 35.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                children: [
                  Text(
                    localization.elevateExperience,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.sp,
            ),
            HomeElevateExperienceWidget(),
            SizedBox(
              height: 44.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.moreFromDikla,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            dashboardModel.data!.moreFrom != null &&
                    dashboardModel.data!.moreFrom.isNotEmpty
                ? HomeMoreFromDiklaWidget(dashboardModel.data!.moreFrom)
                : ConstantMethods.noDataWidget(
                    title: "No More From Dikla Found"),
            SizedBox(
              height: 38.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                children: [
                  Text(
                    localization.bestSellingService,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 23.sp,
            ),
            dashboardModel.data!.bestSelling != null &&
                    dashboardModel.data!.bestSelling.isNotEmpty
                ? HomeBestSellingServiceWidget(dashboardModel.data!.bestSelling)
                : ConstantMethods.noDataWidget(title: "No Best Selling Found"),
            SizedBox(
              height: 22.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Text(
                localization.homeReviewHeader,
                style: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
            ),
            SizedBox(
              height: 28.sp,
            ),
            dashboardModel.data!.reviews != null &&
                    dashboardModel.data!.reviews.isNotEmpty
                ? HomeReviewListWidget(dashboardModel.data!.reviews)
                : ConstantMethods.noDataWidget(title: "No Reviews Found"),
            SizedBox(
              height: 31.0.sp,
            ),
            ElevatedButton(
              onPressed: () {
                context.pushNamed("our_reviews");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.appBgColor, // Transparent background
                // foregroundColor: Colors.blue, // Text color
                side: BorderSide(
                  color: AppTheme.subTextColor, // Border color
                  width: 1.0, // Border width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      ScreenUtil().setSp(8)), // Border radius
                ),
              ),
              child: Text(
                localization.checkMoreReviews,
                style: AppTheme.lightTheme.textTheme.labelSmall,
              ),
            ),
            SizedBox(
              height: 50.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.quickSolutions,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      localization.viewAll,
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          fontSize: 13.sp, color: AppTheme.secondaryTextColor),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            dashboardModel.data!.quickSolution != null &&
                    dashboardModel.data!.quickSolution.isNotEmpty
                ? HomeQuickSolutionstsWidget(dashboardModel.data!.quickSolution)
                : ConstantMethods.noDataWidget(
                    title: "No Quick solutions Found"),
            SizedBox(
              height: 39.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.homeGuidance,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.sp,
            ),
            HomeGuidanceWidget(),
            SizedBox(
              height: 48.sp,
            ),
            Image.asset(
              "assets/images/logo.png",
              height: ScreenUtil().setHeight(60),
              width: ScreenUtil().setWidth(60),
            ),
            SizedBox(
              height: 6.5.sp,
            ),
            Text(
              "Loreum Ipsum Dolor Sir Amet",
              style: AppTheme.lightTheme.textTheme.bodySmall
                  ?.copyWith(fontSize: 9.sp),
            ),
            SizedBox(
              height: 40.sp,
            ),
          ],
        ),
      ),
    );
  }
}
