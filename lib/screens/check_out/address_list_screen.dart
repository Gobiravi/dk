import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/check_out/shipping_address_list_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

final selectedAddresObject = StateProvider<GetShippingAddressModelData>((ref) {
  return GetShippingAddressModelData();
});

final selectedAddresId = StateProvider<int>((ref) {
  return 0;
});

class AddressListScreen extends HookConsumerWidget {
  const AddressListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresList = ref.watch(getShippingAddressApiProvider);
    final selectedObject = ref.watch(selectedAddresObject);
    final selectedId = ref.watch(selectedAddresId);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Select Address",
            style: AppTheme.lightTheme.textTheme.titleMedium
                ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        ),
        body: SafeArea(
          child: addresList.when(
            data: (data) {
              final datum = data.data ?? [];
              switch (data.status!) {
                case true:
                  if (datum.isNotEmpty) {
                    return SizedBox(
                      width: ScreenUtil().screenWidth,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 28.sp),
                                Text(
                                  'Saved Address',
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(fontSize: 17.sp),
                                ),
                                SizedBox(height: 22.sp),
                                Flexible(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap:
                                              true, // Dynamically adjust height based on content
                                          physics:
                                              const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                                          itemCount: datum.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 16.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  ref
                                                      .read(selectedAddresObject
                                                          .notifier)
                                                      .state = datum[index];
                                                },
                                                child: Container(
                                                  width:
                                                      ScreenUtil().screenWidth,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.sp,
                                                      vertical: 16.sp),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color: AppTheme
                                                        .appBarAndBottomBarColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: AppTheme
                                                              .strokeColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.sp),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            "${Constants.imagePathCheckOut}map.svg",
                                                            height: 22.sp,
                                                          ),
                                                          SizedBox(
                                                              width: 14.sp),
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                    .screenWidth *
                                                                0.6,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  datum[index]
                                                                          .firstName ??
                                                                      "",
                                                                  style: AppTheme
                                                                      .lightTheme
                                                                      .textTheme
                                                                      .headlineLarge
                                                                      ?.copyWith(
                                                                          fontSize:
                                                                              14.sp),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        5.sp),
                                                                Text(
                                                                  "${datum[index].address1 != null ? '${datum[index].address1}, ' : ''}"
                                                                  "${datum[index].address2 != null ? '${datum[index].address2}, ' : ''}"
                                                                  "${datum[index].city != null ? '${datum[index].city}, ' : ''}"
                                                                  "${datum[index].country ?? "---"}",
                                                                  style: AppTheme
                                                                      .lightTheme
                                                                      .textTheme
                                                                      .bodyLarge
                                                                      ?.copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: AppTheme
                                                                        .teritiaryTextColor,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                          radioTheme:
                                                              RadioThemeData(
                                                            fillColor:
                                                                WidgetStateProperty
                                                                    .resolveWith<
                                                                            Color>(
                                                                        (states) {
                                                              if (states.contains(
                                                                  WidgetState
                                                                      .selected)) {
                                                                return AppTheme
                                                                    .primaryColor; // Selected color
                                                              }
                                                              return AppTheme
                                                                  .strokeColor; // Unselected ring color
                                                            }),
                                                          ),
                                                        ),
                                                        child: Radio(
                                                          value:
                                                              datum[index].id,
                                                          groupValue:
                                                              selectedId,
                                                          onChanged: (value) {
                                                            ref
                                                                .read(selectedAddresObject
                                                                    .notifier)
                                                                .state = datum[index];
                                                            ref
                                                                .read(selectedAddresId
                                                                    .notifier)
                                                                .state = datum[
                                                                        index]
                                                                    .id ??
                                                                0;
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.sp),
                                  child: InkWell(
                                    onTap: () {
                                      context.push("/address_widget");
                                    },
                                    child: Container(
                                      width: ScreenUtil().screenWidth,
                                      height: 38.sp,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: AppTheme.subTextColor),
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "${Constants.imagePathCheckOut}add.svg",
                                              height: 14.sp,
                                            ),
                                            SizedBox(
                                              width: 8.sp,
                                            ),
                                            Text(
                                              'Add New Address',
                                              style: AppTheme.lightTheme
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                fontSize: 14.sp,
                                                color: AppTheme.subTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80.sp,
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:
                                _buildSaveButton(ref, selectedObject, context),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return _buildSaveButton(ref, selectedObject, context);
                  }
                case false:
                  if (data.statusCode == 402) {
                    refreshApi(ref);
                  }
                  return _buildErrorUI(ref);
                default:
                  return SizedBox();
              }
            },
            error: (error, stackTrace) => _buildErrorUI(ref),
            loading: () {
              return _buildShimmerLoading(context);
            },
          ),
        ));
  }

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(getShippingAddressApiProvider);
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0.sp),
      child: Skeletonizer(
        enabled: true, // Enable the shimmer effect
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
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

  Widget _buildSaveButton(
      WidgetRef ref, GetShippingAddressModelData data, BuildContext context) {
    return InkWell(
      onTap: () {
        ref
            .read(putShippingAddressApiProvider(ShippingAddressParam(
                    firstName: data.firstName ?? "",
                    lastName: data.lastName ?? "",
                    email: "",
                    isDefault: true,
                    phone: data.phone ?? "",
                    country: data.country ?? "",
                    id: data.id.toString()))
                .future)
            .then((onValue) {
          if (onValue.status!) {
          } else {
            if (context.mounted) {
              ConstantMethods.showSnackbar(context, onValue.message ?? "");
            }
          }
        });
      },
      child: Container(
        height: 60.sp,
        decoration: ShapeDecoration(
          color: AppTheme.appBarAndBottomBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.sp),
                topRight: Radius.circular(12.sp)),
          ),
        ),
        child: Center(
          child: Container(
            width: ScreenUtil().screenWidth * 0.9,
            height: 36.sp,
            decoration: ShapeDecoration(
              color: AppTheme.subTextColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: AppTheme.subTextColor),
                borderRadius: BorderRadius.circular(8.sp),
              ),
            ),
            child: Center(
              child: Text(
                "Save Address",
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.appBarAndBottomBarColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorUI(WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 80.sp, color: AppTheme.primaryColor),
        SizedBox(height: 16.h),
        Text(
          'Something went wrong',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.textColor,
          ),
        ),
        SizedBox(height: 14.h),
        ElevatedButton(
          onPressed: () {
            return ref.refresh(getShippingAddressApiProvider);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            'Retry',
            style: AppTheme.lightTheme.textTheme.labelMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
