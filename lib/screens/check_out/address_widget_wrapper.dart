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
                          ref
                              .read(currentDefaultAddressProvider.notifier)
                              .state = GetShippingAddressModelData(
                            address1: onValue.data?.address1 ?? "",
                            address2: onValue.data?.address2 ?? "",
                            city: onValue.data?.city ?? "",
                            company: onValue.data?.company ?? "",
                            country: onValue.data?.country ?? "",
                            firstName: onValue.data?.firstName ?? "",
                            id: onValue.data?.id ?? 0,
                            isDefault: onValue.data?.isDefault ?? true,
                            lastName: onValue.data?.lastName ?? "",
                            phone: onValue.data?.phone ?? "",
                            postcode: onValue.data?.postcode ?? "",
                            state: onValue.data?.state ?? "",
                          );
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
    ref.read(firstNameValidProviderAddress.notifier).state = false;
    ref.read(lastNameProviderAddress.notifier).state = "";
    ref.read(lastNameValidProviderAddress.notifier).state = false;
    ref.read(emailProviderAddress.notifier).state = "";
    ref.read(emailValidProviderAddress.notifier).state = false;
    ref.read(phoneProviderAddress.notifier).state = "";
    ref.read(phoneValidProviderAddress.notifier).state = false;
    //Shipping
    ref.read(countryRegionProvider.notifier).state = "";
    ref.read(countryRegionValidProvider.notifier).state = false;
    ref.read(streetAddressProvider.notifier).state = "";
    ref.read(streetAddressValidProvider.notifier).state = false;
    ref.read(appartmentProvider.notifier).state = "";
    ref.read(appartmentValidProvider.notifier).state = false;
    ref.read(postalCodeProvider.notifier).state = "";
    ref.read(postalCodeValidProvider.notifier).state = false;
    ref.read(townCityProvider.notifier).state = "";
    ref.read(townCityValidProvider.notifier).state = false;
    ref.read(shippingPhoneProvider.notifier).state = "";
    ref.read(shippingPhoneValidProvider.notifier).state = false;

    ref.context.pop();
    return ref.refresh(getShippingAddressApiProvider);
  }
}
