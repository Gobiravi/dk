import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/check_out/order_summary_model.dart';
import 'package:dikla_spirit/model/check_out/shipping_address_list_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/check_out/state/checkout_state.dart';
import 'package:dio/dio.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepProgressScreen extends ConsumerWidget {
  final bool isJewel;
  StepProgressScreen(this.isJewel, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stepProvider);
    final checkoutTotalValue =
        ref.watch(checkoutTotal.select((value) => value));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          currentStep == 1
              ? "Add Billing Details"
              : currentStep == 1
                  ? "Place order"
                  : "Order Confirmation",
          style: AppTheme.lightTheme.textTheme.titleMedium
              ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              // ref.invalidate(getShippingAddressApiProvider);
              // ref.invalidate(getOrderSummaryApiProvider);
              ref.read(stepProvider.notifier).updateStep(1);
              resetFields(ref);
              context.pop();
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      StepProgressWidget(currentStep: currentStep),
                      SizedBox(height: 26),
                      Visibility(
                          visible: currentStep == 1,
                          child: AddressWidget(isJewel)),
                      Visibility(
                          visible: currentStep == 2,
                          child: OrderSummaryWidget(isJewel)),
                      Visibility(
                          visible: currentStep == 3,
                          child: OrderConfirmedWidget()),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentStep == 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        final isVirtualFormValid =
                            ref.read(virtualFormValidProvider);

                        if (isVirtualFormValid) {
                          final fName = ref.read(firstNameProviderAddress);
                          final lName = ref.read(lastNameProviderAddress);
                          final email = ref.read(emailProviderAddress);
                          final phone = ref.read(phoneProviderAddress);
                          final country = ref.read(selectedCountryProvider);

                          ref
                              .read(addShippingAddressApiProvider(
                                  ShippingAddressParam(
                            firstName: fName,
                            lastName: lName,
                            email: email,
                            phone: phone,
                            country: country.name,
                          )).future)
                              .then((onValue) {
                            if (onValue.status!) {
                              ref
                                  .read(stepProvider.notifier)
                                  .updateStep(currentStep + 1);
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
                ),
                Visibility(
                  visible: currentStep == 3,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        if (currentStep < 3) {
                          ref
                              .read(stepProvider.notifier)
                              .updateStep(currentStep + 1);
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
                                "Continue Shopping",
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
                ),
                Visibility(
                  visible: currentStep == 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: ScreenUtil().setHeight(114.sp),
                        decoration: ShapeDecoration(
                          color: AppTheme.appBarAndBottomBarColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.sp),
                              topRight: Radius.circular(12.sp),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 21.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium
                                        ?.copyWith(
                                            fontSize: 16.sp,
                                            color: AppTheme.textColor),
                                  ),
                                  Text(
                                    checkoutTotalValue,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium
                                        ?.copyWith(
                                            fontSize: 16.sp,
                                            color: AppTheme.textColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            InkWell(
                              onTap: () {
                                makePayment(context, ref);
                              },
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
                                    "Place Order",
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: AppTheme
                                                .appBarAndBottomBarColor,
                                            fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //         if (currentStep > 1) {
                //           ref
                //               .read(stepProvider.notifier)
                //               .updateStep(currentStep - 1);
                //         }
                //       },
                //       child: Text('Previous Step'),
                //     ),
                //     SizedBox(width: 16),
                //     ElevatedButton(
                //       onPressed: () {
                //         if (currentStep < 3) {
                //           ref
                //               .read(stepProvider.notifier)
                //               .updateStep(currentStep + 1);
                //         }
                //       },
                //       child: Text('Next Step'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      final dio = Dio();

      const String secretKey =
          "sk_test_51PsAs8FUDgzMNUwF1rhct1HowoyR3LlRoHOnuVPxtcMHW2uyjVD2rrbNDJjRT3wmXlvwoF1slgsFp7BcmWqbfXhg00Mla8itUu";

      // Convert amount to smallest currency unit (Stripe expects cents)
      final int amountInCents = (double.parse(amount) * 100).toInt();

      // Encode data as x-www-form-urlencoded
      final Map<String, dynamic> body = {
        'amount': amountInCents.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: body,
      );

      print('✅ Payment Intent Created: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print(
          '❌ Stripe Error Response: ${e.response?.data}'); // Prints Stripe's exact error
      return null;
    }
  }

  Future<void> makePayment(BuildContext context, WidgetRef ref) async {
    try {
      // Create payment intent data
      paymentIntent = await createPaymentIntent('100.0', 'INR');
      // initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Client secret key from payment data
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.system,
          googlePay: const PaymentSheetGooglePay(
              //     // Currency and country code
              //     // is accourding to India
              testEnv: true,
              currencyCode: "INR",
              merchantCountryCode: "IN"),
          // Merchant Name
          merchantDisplayName: 'Dikla Spirit',
          // return URl if you want to add
          // returnURL: 'flutterstripe://redirect',
        ),
      );
      //Display payment sheet
      if (context.mounted) {
        displayPaymentSheet(context, ref);
      }
    } catch (e) {
      print("exception $e");
      if (e is StripeConfigException) {
        print("Stripe exception ${e.message}");
      } else {
        print("exception $e");
      }
    }
  }

  Map<String, dynamic>? paymentIntent;

  displayPaymentSheet(BuildContext context, WidgetRef ref) async {
    final currentStep = ref.watch(stepProvider);
    try {
      // "Display payment sheet";
      await Stripe.instance.presentPaymentSheet();
      // Show when payment is done
      // Displaying snackbar for it
      if (context.mounted) {
        ConstantMethods.showSnackbar(context, "Paid Successfully");
        if (currentStep < 3) {
          ref.read(stepProvider.notifier).updateStep(currentStep + 1);
        }
      }
      paymentIntent = null;
    } on StripeException catch (e) {
      if (context.mounted) {
        print('Error: $e');
        ConstantMethods.showSnackbar(context, "Payment Cancelled",
            isFalse: true);
      }
    } catch (e) {
      if (context.mounted) {
        print('Error: $e');
        ConstantMethods.showSnackbar(context, e.toString(), isFalse: true);
      }
    }
  }

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(getShippingAddressApiProvider);
  }

  resetFields(WidgetRef ref) {
    ref.read(firstNameProviderAddress.notifier).state = "";
    ref.read(lastNameProviderAddress.notifier).state = "";
    ref.read(emailProviderAddress.notifier).state = "";
    ref.read(phoneProviderAddress.notifier).state = "";
    if (isJewel) {
      ref.read(countryRegionProvider.notifier).state = "";
      ref.read(streetAddressProvider.notifier).state = "";
      ref.read(appartmentProvider.notifier).state = "";
      ref.read(postalCodeProvider.notifier).state = "";
      ref.read(townCityProvider.notifier).state = "";
      ref.read(shippingPhoneProvider.notifier).state = "";
    }
  }
}

class StepProgressWidget extends StatelessWidget {
  final int currentStep;

  const StepProgressWidget({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.sp),
          child: Row(
            children: [
              _buildStepCircle(isActive: currentStep >= 1, stepNumber: 1),
              SizedBox(
                width: 9.sp,
              ),
              _buildLine(isCompleted: currentStep >= 2),
              SizedBox(
                width: 9.sp,
              ),
              _buildStepCircle(isActive: currentStep >= 2, stepNumber: 2),
              SizedBox(
                width: 9.sp,
              ),
              _buildLine(isCompleted: currentStep >= 3),
              SizedBox(
                width: 9.sp,
              ),
              _buildStepCircle(isActive: currentStep >= 3, stepNumber: 3),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Address"),
              Spacer(),
              _buildLabel("Order Summary"),
              Spacer(),
              _buildLabel("Payment"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle({required bool isActive, required int stepNumber}) {
    return CircleAvatar(
      radius: 15.sp,
      backgroundColor: isActive ? Colors.transparent : AppTheme.strokeColor,
      child: isActive
          ? SvgPicture.asset(
              "${Constants.imagePathCheckOut}step_over.svg",
              height: 20.sp,
            )
          : Text(
              stepNumber.toString(),
              style: AppTheme.lightTheme.textTheme.labelSmall
                  ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
    );
  }

  Widget _buildLine({required bool isCompleted}) {
    return Expanded(
      child: Container(
        height: 0.5,
        color: isCompleted ? AppTheme.primaryColor : AppTheme.subTextColor,
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
        fontSize: 12.sp,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class OrderSummaryWidget extends HookConsumerWidget {
  final bool isJewel;
  const OrderSummaryWidget(this.isJewel, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currentCurrencySymbolProvider);
    final orderSummary = ref.watch(getOrderSummaryApiProvider);
    final fName = ref.watch(firstNameProviderAddress);
    final lName = ref.watch(lastNameProviderAddress);
    final phone = ref.watch(phoneProviderAddress);
    final country = ref.watch(countryProviderAddress);
    final appartment = ref.watch(appartmentProvider);
    final city = ref.watch(townCityProvider);
    final street = ref.watch(streetAddressProvider);
    final zipCode = ref.watch(postalCodeProvider);
    return orderSummary.when(
      data: (data) {
        switch (data.status) {
          case true:
            final datum = data.data ?? OrderSummaryModelData();
            final product = datum.product ?? [];
            SchedulerBinding.instance.addPostFrameCallback(
              (timeStamp) {
                ref.read(checkoutTotal.notifier).state =
                    double.parse(datum.total.toString()).toStringAsFixed(2);
              },
            );

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  Container(
                    width: ScreenUtil().screenWidth,
                    // height: 95.sp,
                    decoration: ShapeDecoration(
                      color: AppTheme.appBarAndBottomBarColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: AppTheme.strokeColor),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.sp),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isJewel
                                    ? "$appartment,$street,$city,$zipCode"
                                    : country.name,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                              ),
                              InkWell(
                                onTap: () {
                                  context.push("/address_list");
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: AppTheme.primaryColor,
                                  size: 14.sp,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                fName + lName,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        color: AppTheme.teritiaryTextColor),
                              ),
                              SizedBox(
                                width: 12.sp,
                              ),
                              Text(
                                "${country.dialCode} $phone",
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        color: AppTheme.teritiaryTextColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.sp,
                  ),
                  orderDetailsWidget(currency: currency, product: product),
                  SizedBox(
                    height: 27.sp,
                  ),
                  summaryWidget(currency: currency, datum: datum),
                  SizedBox(
                    height: 24.sp,
                  ),
                  Container(
                    width: ScreenUtil().screenWidth,
                    height: 110.sp,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 14),
                    decoration: ShapeDecoration(
                      color: AppTheme.appBarAndBottomBarColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: AppTheme.strokeColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: SizedBox(
                      child: TextField(
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppTheme.teritiaryTextColor),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Special notes on order..",
                            hintStyle: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w100,
                                    color: AppTheme.teritiaryTextColor)),
                        maxLines: 3,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.sp,
                  ),
                  Container(
                    width: ScreenUtil().screenWidth,
                    // height: 130.sp,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFF0D3E2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Type',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 48.sp,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppTheme.teritiaryTextColor),
                              borderRadius: BorderRadius.circular(6.sp),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "${Constants.imagePathCheckOut}stripe.svg",
                                      height: 12.sp,
                                    ),
                                    SizedBox(
                                      width: 9.sp,
                                    ),
                                    Text('Stripe Payment',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall),
                                  ],
                                ),
                                SvgPicture.asset(
                                  "${Constants.imagePathCheckOut}radio.svg",
                                  height: 12.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150.sp,
                  )
                ],
              ),
            );
          case false:
            if (data.statusCode == 402) {
              refreshApi(ref);
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 80.sp,
                    color: AppTheme.primaryColor,
                  ),
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
                      return ref.refresh(getOrderSummaryApiProvider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          default:
            return SizedBox();
        }
      },
      error: (error, stackTrace) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 80.sp,
              color: AppTheme.primaryColor,
            ),
            SizedBox(height: 16.h),
            Text(
              error.toString(),
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textColor,
              ),
            ),
            SizedBox(height: 14.h),
            ElevatedButton(
              onPressed: () {
                return ref.refresh(getOrderSummaryApiProvider);
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
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
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

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(getOrderSummaryApiProvider);
  }
}

Widget orderDetailsWidget(
    {String? currency, List<OrderSummaryModelDataProduct>? product}) {
  return Container(
    // width: 396,
    // height: 250.sp,
    padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 15.sp),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFFF0D3E2)),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Order Details',
          style: AppTheme.lightTheme.textTheme.titleMedium
              ?.copyWith(fontSize: 16.sp),
        ),
        SizedBox(
          height: 18.sp,
        ),
        SizedBox(
          height: 170.sp,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: product?.length, //cart.length ?? 0,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.0.sp, right: 12.sp, top: 12.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.sp),
                              child: CachedNetworkImage(
                                imageUrl: product?[index].image ?? "",
                                height: 72.sp,
                                width: 72.sp,
                              ),
                            ),
                            SizedBox(
                              width: 26.sp,
                            ),
                            SizedBox(
                              width: 160.sp,
                              child: Text(
                                product?[index].name ?? "",
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(fontSize: 14.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "$currency ${product?[index].price.toString()}",
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.sp,
                  ),
                  ConstantMethods.customDivider(width: 0.40)
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget summaryWidget({String? currency, OrderSummaryModelData? datum}) {
  return Container(
    // height: 180.sp,
    width: ScreenUtil().screenWidth,
    padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
    decoration: ShapeDecoration(
      color: AppTheme.appBarAndBottomBarColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: AppTheme.strokeColor),
        borderRadius: BorderRadius.circular(10.sp),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: AppTheme.lightTheme.textTheme.titleMedium
              ?.copyWith(fontSize: 16.sp),
        ),
        SizedBox(
          height: 8.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal:',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.teritiaryTextColor,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "$currency ${double.parse(datum!.subtotal.toString()).toStringAsFixed(2)}",
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.teritiaryTextColor,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 8.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping:',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.teritiaryTextColor,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "$currency ${datum.shippingCost.toString()}",
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.teritiaryTextColor,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 16.sp,
        ),
        Divider(
          height: 0.7,
          color: AppTheme.teritiaryTextColor,
        ),
        SizedBox(
          height: 16.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Estimated Total:',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.subTextColor,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "$currency ${double.parse(datum.total.toString()).toStringAsFixed(2)}",
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.subTextColor,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    ),
  );
}

class AddressWidget extends HookConsumerWidget {
  final bool isShippingVisible;
  AddressWidget(this.isShippingVisible, {super.key});
  final formKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fNameProvider = ref.watch(firstNameProviderAddress);
    final lNameProvider = ref.watch(lastNameProviderAddress);
    final emailProviderValid = ref.watch(emailValidProviderAddress);
    final selectedCountry = ref.watch(countryProviderAddress);
    final phoneProviderValid = ref.watch(phoneValidProviderAddress);
    // final phoneProvider = ref.watch(phoneProviderAddress);
    final shippingAddressList = ref.watch(getShippingAddressApiProvider);
    return shippingAddressList.when(
      data: (data) {
        if (data.data != null && data.data!.isNotEmpty) {
          SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
              final defaultValue = data.data?.firstWhere(
                (element) => element.isDefault!,
              );
              if (defaultValue != null) {
                ref.read(firstNameProviderAddress.notifier).state =
                    defaultValue.firstName ?? "";
                ref.read(lastNameProviderAddress.notifier).state =
                    defaultValue.lastName ?? "";
                ref.read(phoneProviderAddress.notifier).state =
                    defaultValue.phone ?? "";
                ref.read(selectedCountryProvider.notifier).state = CountryCode(
                    name: defaultValue.country ?? "", code: "", dialCode: "");
                if (isShippingVisible) {
                  ref.read(countryRegionProvider.notifier).state =
                      defaultValue.country ?? "";
                  ref.read(streetAddressProvider.notifier).state =
                      defaultValue.address2 ?? "";
                  ref.read(appartmentProvider.notifier).state =
                      defaultValue.address1 ?? "";
                  ref.read(postalCodeProvider.notifier).state =
                      defaultValue.postcode ?? "";
                  ref.read(townCityProvider.notifier).state =
                      defaultValue.city ?? "";
                  ref.read(shippingPhoneProvider.notifier).state =
                      defaultValue.phone ?? "";
                }
                ref.read(stepProvider.notifier).updateStep(2);
              }
            },
          );
        }
        switch (data.status) {
          case true:
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                    child: Text(
                      'Contact Informatiom',
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      onChanged: () {
                        // final isValid = formKey.currentState?.validate() ?? false;
                        // ref.read(virtualFormValidProvider.notifier).state =
                        //     isValid;
                      },
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: AppTheme.cursorColor,
                            cursorWidth: 1.0,
                            cursorHeight: 18.h,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'First Name',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.teritiaryTextColor),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontSize: 11.sp,
                                                color: AppTheme.errorBorder),
                                      ),
                                    ],
                                  ),
                                ),
                                suffixIcon:
                                    ref.watch(firstNameValidProviderAddress)
                                        ? Icon(Icons.check,
                                            color: AppTheme.primaryColor)
                                        : SizedBox(),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: fNameProvider.isNotEmpty
                                            ? AppTheme.primaryColor
                                            : AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.errorBorder,
                                        width: 1.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.errorBorder,
                                        width: 1.0)),
                                errorStyle: AppTheme
                                    .lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                        color: AppTheme.errorBorder,
                                        fontSize: 11.sp),
                                fillColor: AppTheme.appBarAndBottomBarColor),
                            onChanged: (value) {
                              ref
                                  .read(firstNameProviderAddress.notifier)
                                  .state = value;
                              if (value.trim().isNotEmpty) {
                                ref
                                    .read(
                                        firstNameValidProviderAddress.notifier)
                                    .state = true;
                              } else {
                                ref
                                    .read(
                                        firstNameValidProviderAddress.notifier)
                                    .state = false;
                              }
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            cursorColor: AppTheme.cursorColor,
                            cursorWidth: 1.0,
                            cursorHeight: 18.h,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Last Name',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.teritiaryTextColor),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontSize: 11.sp,
                                                color: AppTheme.errorBorder),
                                      ),
                                    ],
                                  ),
                                ),
                                suffixIcon:
                                    ref.watch(lastNameValidProviderAddress)
                                        ? Icon(Icons.check,
                                            color: AppTheme.primaryColor)
                                        : SizedBox(),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: lNameProvider.isNotEmpty
                                            ? AppTheme.primaryColor
                                            : AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.errorBorder,
                                        width: 1.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.errorBorder,
                                        width: 1.0)),
                                errorStyle: AppTheme
                                    .lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                        color: AppTheme.errorBorder,
                                        fontSize: 11.sp),
                                fillColor: AppTheme.appBarAndBottomBarColor),
                            onChanged: (value) {
                              ref.read(lastNameProviderAddress.notifier).state =
                                  value;
                              // Update validation state dynamically
                              ref
                                  .read(lastNameValidProviderAddress.notifier)
                                  .state = value.trim().isNotEmpty;
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            cursorColor: AppTheme.cursorColor,
                            cursorWidth: 1.0,
                            cursorHeight: 18.h,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Email',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.teritiaryTextColor),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontSize: 11.sp,
                                                color: AppTheme.errorBorder),
                                      ),
                                    ],
                                  ),
                                ),
                                suffixIcon: ref.watch(emailValidProviderAddress)
                                    ? Icon(Icons.check,
                                        color: AppTheme.primaryColor)
                                    : SizedBox(),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: emailProviderValid
                                            ? AppTheme.primaryColor
                                            : AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.strokeColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.errorBorder,
                                        width: 1.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.errorBorder,
                                        width: 1.0)),
                                errorStyle: AppTheme
                                    .lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                        color: AppTheme.errorBorder,
                                        fontSize: 11.sp),
                                fillColor: AppTheme.appBarAndBottomBarColor),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              ref.read(emailProviderAddress.notifier).state =
                                  value;
                              // Update validation state dynamically
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                              ref
                                  .read(emailValidProviderAddress.notifier)
                                  .state = emailRegex.hasMatch(value);
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final picked = await countryPicker.showPicker(
                                      context: context);
                                  // Null check
                                  if (picked != null) {
                                    ref
                                        .read(countryProviderAddress.notifier)
                                        .updateCountry(picked);
                                  }
                                },
                                child: Container(
                                    width: 108.sp,
                                    height: 48.sp,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xFFF0D3E2)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(9.5.sp),
                                            child: Image.asset(
                                              selectedCountry.flagUri,
                                              fit: BoxFit.cover,
                                              width: 19.sp,
                                              height: 19.sp,
                                              package: selectedCountry
                                                  .flagImagePackage,
                                            ),
                                          ),
                                          Text(
                                            selectedCountry.dialCode,
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 16.sp,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 8.sp,
                              ),
                              Expanded(
                                child: TextFormField(
                                  cursorColor: AppTheme.cursorColor,
                                  cursorWidth: 1.0,
                                  cursorHeight: 18.h,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      label: RichText(
                                        text: TextSpan(
                                          text: 'Phone Number',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 11.sp,
                                                      color:
                                                          AppTheme.errorBorder),
                                            ),
                                          ],
                                        ),
                                      ),
                                      suffixIcon: ref.watch(phoneValidProviderAddress)
                                          ? Icon(Icons.check,
                                              color: AppTheme.primaryColor)
                                          : SizedBox(),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: phoneProviderValid
                                                  ? AppTheme.primaryColor
                                                  : AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.strokeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.sp)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.errorBorder,
                                              width: 1.0)),
                                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                                      errorStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                                      fillColor: AppTheme.appBarAndBottomBarColor),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    ref
                                        .read(phoneProviderAddress.notifier)
                                        .state = value;
                                    // Update validation state dynamically
                                    final phoneRegex = RegExp(
                                        r'^\d{10}$'); // Example: 10-digit phone number
                                    ref
                                        .read(
                                            phoneValidProviderAddress.notifier)
                                        .state = phoneRegex.hasMatch(value);
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Phone number is required';
                                    }
                                    final phoneRegex = RegExp(r'^\d{10}$');
                                    if (!phoneRegex.hasMatch(value)) {
                                      return 'Enter a valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          Visibility(
                              visible: isShippingVisible,
                              child: ShippingAddressWidget()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.sp,
                  )
                ],
              ),
            );
          case false:
            if (data.statusCode == 402) {
              refreshApi(ref);
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 80.sp,
                    color: AppTheme.primaryColor,
                  ),
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
                      refreshApi(ref);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          default:
            return SizedBox();
        }
      },
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: 80.sp,
                color: AppTheme.primaryColor,
              ),
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
                  refreshApi(ref);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Retry',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
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

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(getShippingAddressApiProvider);
  }
}

class ShippingAddressWidget extends HookConsumerWidget {
  const ShippingAddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryRegionProviderLocal = ref.watch(countryRegionProvider);
    final streetAddressProviderLocal = ref.watch(streetAddressProvider);
    final appartmentProviderLocal = ref.watch(appartmentProvider);
    final postalCodeProviderLocal = ref.watch(postalCodeProvider);
    final townCityProviderLocal = ref.watch(townCityProvider);
    final phoneProviderValidShipping = ref.watch(shippingPhoneValidProvider);
    final key = GlobalKey<FormState>();
    return Form(
      key: key,
      onChanged: () {
        // final isValid = key.currentState?.validate() ?? false;
        // ref.read(physicalFormValidProvider.notifier).state = isValid;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Details',
            style: AppTheme.lightTheme.textTheme.bodyLarge,
          ),
          SizedBox(
            height: 16.sp,
          ),
          TextFormField(
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: 'Country/Region',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor),
                    children: [
                      TextSpan(
                        text: '*',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontSize: 11.sp, color: AppTheme.errorBorder),
                      ),
                    ],
                  ),
                ),
                suffixIcon: ref.watch(countryRegionValidProvider)
                    ? Icon(Icons.check, color: AppTheme.primaryColor)
                    : SizedBox(),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: countryRegionProviderLocal.isNotEmpty
                            ? AppTheme.primaryColor
                            : AppTheme.strokeColor,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                errorStyle: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                fillColor: AppTheme.appBarAndBottomBarColor),
            onChanged: (value) {
              ref.read(countryRegionProvider.notifier).state = value;
              // Update validation state dynamically
              ref.read(countryRegionValidProvider.notifier).state =
                  value.trim().isNotEmpty;
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Country/Region is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextFormField(
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: 'Street Address',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor),
                    children: [
                      TextSpan(
                        text: '*',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontSize: 11.sp, color: AppTheme.errorBorder),
                      ),
                    ],
                  ),
                ),
                suffixIcon: ref.watch(streetAddressValidProvider)
                    ? Icon(Icons.check, color: AppTheme.primaryColor)
                    : SizedBox(),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: streetAddressProviderLocal.isNotEmpty
                            ? AppTheme.primaryColor
                            : AppTheme.strokeColor,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                errorStyle: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                fillColor: AppTheme.appBarAndBottomBarColor),
            onChanged: (value) {
              ref.read(streetAddressProvider.notifier).state = value;
              // Update validation state dynamically
              ref.read(streetAddressValidProvider.notifier).state =
                  value.trim().isNotEmpty;
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Street Address is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextFormField(
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: 'Appartment',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor),
                    children: [
                      TextSpan(
                        text: '*',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontSize: 11.sp, color: AppTheme.errorBorder),
                      ),
                    ],
                  ),
                ),
                suffixIcon: ref.watch(appartmentValidProvider)
                    ? Icon(Icons.check, color: AppTheme.primaryColor)
                    : SizedBox(),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: appartmentProviderLocal.isNotEmpty
                            ? AppTheme.primaryColor
                            : AppTheme.strokeColor,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                errorStyle: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                fillColor: AppTheme.appBarAndBottomBarColor),
            onChanged: (value) {
              ref.read(appartmentProvider.notifier).state = value;
              // Update validation state dynamically
              ref.read(appartmentValidProvider.notifier).state =
                  value.trim().isNotEmpty;
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Street Address is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextFormField(
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: 'Postcode/ZIP',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor),
                    children: [
                      TextSpan(
                        text: '*',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontSize: 11.sp, color: AppTheme.errorBorder),
                      ),
                    ],
                  ),
                ),
                suffixIcon: ref.watch(postalCodeValidProvider)
                    ? Icon(Icons.check, color: AppTheme.primaryColor)
                    : SizedBox(),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: postalCodeProviderLocal.isNotEmpty
                            ? AppTheme.primaryColor
                            : AppTheme.strokeColor,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                errorStyle: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                fillColor: AppTheme.appBarAndBottomBarColor),
            onChanged: (value) {
              ref.read(postalCodeProvider.notifier).state = value;
              // Update validation state dynamically
              ref.read(postalCodeValidProvider.notifier).state =
                  value.trim().isNotEmpty;
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Postcod/ZIP is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextFormField(
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: 'Town/City',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor),
                    children: [
                      TextSpan(
                        text: '*',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontSize: 11.sp, color: AppTheme.errorBorder),
                      ),
                    ],
                  ),
                ),
                suffixIcon: ref.watch(townCityValidProvider)
                    ? Icon(Icons.check, color: AppTheme.primaryColor)
                    : SizedBox(),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: townCityProviderLocal.isNotEmpty
                            ? AppTheme.primaryColor
                            : AppTheme.strokeColor,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                errorStyle: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                fillColor: AppTheme.appBarAndBottomBarColor),
            onChanged: (value) {
              ref.read(townCityProvider.notifier).state = value;
              // Update validation state dynamically
              ref.read(townCityValidProvider.notifier).state =
                  value.trim().isNotEmpty;
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Town/City is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextFormField(
            cursorColor: AppTheme.cursorColor,
            cursorWidth: 1.0,
            cursorHeight: 18.h,
            style: AppTheme.lightTheme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: 'Phone Number',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor),
                    children: [
                      TextSpan(
                        text: '*',
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontSize: 11.sp, color: AppTheme.errorBorder),
                      ),
                    ],
                  ),
                ),
                suffixIcon: ref.watch(shippingPhoneValidProvider)
                    ? Icon(Icons.check, color: AppTheme.primaryColor)
                    : SizedBox(),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: phoneProviderValidShipping
                            ? AppTheme.primaryColor
                            : AppTheme.strokeColor,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.strokeColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.sp)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                errorStyle: AppTheme.lightTheme.textTheme.bodyLarge
                    ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                fillColor: AppTheme.appBarAndBottomBarColor),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              ref.read(shippingPhoneProvider.notifier).state = value;
              // Update validation state dynamically
              final phoneRegex =
                  RegExp(r'^\d{10}$'); // Example: 10-digit phone number
              ref.read(shippingPhoneValidProvider.notifier).state =
                  phoneRegex.hasMatch(value);
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }
              final phoneRegex = RegExp(r'^\d{10}$');
              if (!phoneRegex.hasMatch(value)) {
                return 'Enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(
            height: 22.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 15.sp,
                height: 15.sp,
                decoration: ShapeDecoration(
                  color: AppTheme.appBarAndBottomBarColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppTheme.primaryColor),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(
                width: 3.sp,
              ),
              Text(
                'Save Default',
                style: AppTheme.lightTheme.textTheme.bodySmall
                    ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 36.sp,
          )
        ],
      ),
    );
  }
}

class OrderConfirmedWidget extends HookConsumerWidget {
  const OrderConfirmedWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currentCurrencySymbolProvider);
    final product = ref.read(getOrderSummaryApiProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "${Constants.imagePathAuth}success.svg",
                height: 62.sp,
              ),
              SizedBox(
                width: 22.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thank you!',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Text(
                    'Your order #BE12345 has been placed.',
                    style: AppTheme.lightTheme.textTheme.bodySmall
                        ?.copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  SizedBox(
                    width: ScreenUtil().screenWidth * 0.7,
                    child: Text(
                      'I’m here with you, hand in hand, at everystep and on every journey.',
                      style: AppTheme.lightTheme.textTheme.bodySmall
                          ?.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 24.sp,
          ),
          Text(
            'We sent an email to company@website.com with your order confirmation and bill. ',
            style: AppTheme.lightTheme.textTheme.bodySmall,
          ),
          SizedBox(
            height: 30.sp,
          ),
          Container(
            width: ScreenUtil().screenWidth,
            // height: 177,
            padding: EdgeInsets.all(18.sp),
            decoration: ShapeDecoration(
              color: AppTheme.appBarAndBottomBarColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: AppTheme.strokeColor),
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping',
                    style: AppTheme.lightTheme.textTheme.titleMedium
                        ?.copyWith(fontSize: 18.sp)),
                SizedBox(
                  height: 14.sp,
                ),
                Text('User',
                    style: AppTheme.lightTheme.textTheme.headlineLarge
                        ?.copyWith(fontSize: 14.sp)),
                SizedBox(
                  height: 12.sp,
                ),
                Text('client name',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor)),
                SizedBox(
                  height: 4.sp,
                ),
                Text('Phone',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor)),
                SizedBox(
                  height: 11.sp,
                ),
                Text('address',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.teritiaryTextColor)),
              ],
            ),
          ),
          SizedBox(
            height: 24.sp,
          ),
          product.when(
            data: (data) {
              return orderDetailsWidget(
                  currency: currency, product: data.data?.product ?? []);
            },
            error: (_, __) {
              return SizedBox();
            },
            loading: () {
              return SizedBox();
            },
          ),
          SizedBox(
            height: 24.sp,
          ),
          product.when(
            data: (data) {
              return summaryWidget(currency: currency, datum: data.data);
            },
            error: (_, __) {
              return SizedBox();
            },
            loading: () {
              return SizedBox();
            },
          ),
          SizedBox(
            height: 28.sp,
          ),
          Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.only(
                top: 30.sp, right: 26.sp, left: 26.sp, bottom: 26.sp),
            decoration: ShapeDecoration(
              color: AppTheme.appBarAndBottomBarColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: AppTheme.strokeColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'To start processing your service, please visit your\n',
                        style: TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 14,
                          fontFamily: 'Noto Sans Hebrew',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Order Details',
                        style: TextStyle(
                          color: Color(0xFFC1768D),
                          fontSize: 14,
                          fontFamily: 'Noto Sans Hebrew',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: ' page and complete the required form.',
                        style: TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 14,
                          fontFamily: 'Noto Sans Hebrew',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.sp,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      ref.read(stepProvider.notifier).updateStep(1);
                      context.go("/my_orders");
                    },
                    child: Container(
                      width: 133.sp,
                      height: 32.sp,
                      decoration: ShapeDecoration(
                        color: AppTheme.appBarAndBottomBarColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: AppTheme.subTextColor),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Visit Order Detail',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80.sp,
          )
        ],
      ),
    );
  }
}
