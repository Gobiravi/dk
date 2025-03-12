import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/check_out/shipping_address_list_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/check_out/state/checkout_state.dart';
import 'package:dikla_spirit/screens/check_out/step_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddressWidgetWrapper extends HookConsumerWidget {
  const AddressWidgetWrapper({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Address",
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
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Stack(
            children: [
              AddressWidget(true),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    final isVirtualFormValid =
                        ref.read(virtualFormValidProvider);
                    final isPhysicalFormValid =
                        ref.read(physicalFormValidProvider);

                    if (isVirtualFormValid && isPhysicalFormValid) {
                      final fName = ref.read(firstNameProviderAddress);
                      final lName = ref.read(lastNameProviderAddress);
                      final email = ref.read(emailProviderAddress);
                      final phone = ref.read(phoneProviderAddress);
                      // final country = ref.read(selectedCountryProvider);
                      final countryRegion = ref.read(countryRegionProvider);
                      final streetAddress = ref.read(streetAddressProvider);
                      final appartmentData = ref.read(appartmentProvider);
                      final zipCode = ref.read(postalCodeProvider);
                      final city = ref.read(townCityProvider);
                      ref
                          .read(addShippingAddressApiProvider(
                                  ShippingAddressParam(
                                      firstName: fName,
                                      lastName: lName,
                                      email: email,
                                      phone: phone,
                                      country: countryRegion,
                                      address1: streetAddress,
                                      address2: appartmentData,
                                      city: city,
                                      postCode: zipCode,
                                      isDefault: true))
                              .future)
                          .then((onValue) {
                        if (onValue.status!) {
                          // ref
                          //     .read(stepProvider.notifier)
                          //     .updateStep(currentStep + 1);
                          resetFields(ref);
                          if (context.mounted) {
                            ConstantMethods.showSnackbar(
                                context, onValue.message ?? "");
                          }
                        } else {
                          if (context.mounted) {
                            ConstantMethods.showSnackbar(
                                context, onValue.message ?? "");
                          }
                        }
                      });
                    } else {
                      ConstantMethods.showSnackbar(
                          context, "Kindly, Fill all fields");
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
                            "Add Address",
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                    color: AppTheme.appBarAndBottomBarColor,
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
        ),
      ),
    );
  }

  resetFields(WidgetRef ref) {
    ref.read(firstNameProviderAddress.notifier).state = "";
    ref.read(lastNameProviderAddress.notifier).state = "";
    ref.read(emailProviderAddress.notifier).state = "";
    ref.read(phoneProviderAddress.notifier).state = "";
    //Shipping
    ref.read(countryRegionProvider.notifier).state = "";
    ref.read(streetAddressProvider.notifier).state = "";
    ref.read(appartmentProvider.notifier).state = "";
    ref.read(postalCodeProvider.notifier).state = "";
    ref.read(townCityProvider.notifier).state = "";
    ref.read(shippingPhoneProvider.notifier).state = "";
  }
}
