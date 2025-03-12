import 'dart:convert';

import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/auth/common_model.dart';
import 'package:dikla_spirit/model/help/help_questions_model.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/widgets/no_net_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubmitRequestScreen extends HookConsumerWidget {
  const SubmitRequestScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final questions = ref.watch(helpQuestionsApiProvider);
    final selectedValue = ref.watch(selectedFirstQuestionProvider);
    final selectedChildValue = ref.watch(selectedChildQuestionProvider);
    final otherTextController = useTextEditingController();
    final moreDetailTextController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
        title: Text(
          localization.submit_request,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            fontSize: 17.sp,
            color: AppTheme.textColor,
            letterSpacing: -0.45,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: questions.when(
          data: (data) {
            if (!data.status! || data.data == null) return const SizedBox();
            switch (data.status) {
              case true:
                // Define "Other" option using a single instance
                final otherOption = HelpQuestionsModelData(
                  id: "other_option",
                  question: "Other",
                  children: [],
                );

                // Ensure no duplicate "Other" entry
                final List<HelpQuestionsModelData> questionList = [
                  ...data.data!,
                  if (!data.data!.any((q) => q.id == "other_option"))
                    otherOption,
                ];

                // Ensure selectedValue is valid
                final selectedItem =
                    questionList.contains(selectedValue) ? selectedValue : null;

                return Column(
                  children: [
                    Image.asset(
                      "assets/images/help/help.png",
                      height: 157.h,
                      width: ScreenUtil().screenWidth,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Submit a Request',
                      style: AppTheme.lightTheme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                        'Our support team is ready to assist with \nany issues you may have.',
                        textAlign: TextAlign.center,
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(fontSize: 14.sp)),
                    SizedBox(
                      height: 28.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: DropdownButtonFormField<HelpQuestionsModelData>(
                        value: selectedItem,
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontSize: 14.sp, color: AppTheme.subTextColor),
                        decoration: InputDecoration(
                          label: Text(
                            "How Can We help?",
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.strokeColor, width: 1.0),
                              borderRadius: BorderRadius.circular(8.sp)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.strokeColor, width: 1.0),
                              borderRadius: BorderRadius.circular(8.sp)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.strokeColor, width: 1.0),
                              borderRadius: BorderRadius.circular(8.sp)),
                          filled: true,
                          fillColor: AppTheme.appBarAndBottomBarColor,
                        ),
                        onChanged: (value) {
                          ref
                              .read(selectedFirstQuestionProvider.notifier)
                              .state = value;
                          ref
                              .read(selectedChildQuestionProvider.notifier)
                              .state = null;
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppTheme.subTextColor,
                        ),
                        items: questionList
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item.question ?? "")))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    if (selectedValue?.id != "other_option" &&
                        selectedValue?.children != null &&
                        selectedValue!.children!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child:
                            DropdownButtonFormField<HelpQuestionsModelChildren>(
                          value: selectedChildValue,
                          style: AppTheme.lightTheme.textTheme.bodyLarge
                              ?.copyWith(
                                  fontSize: 14.sp,
                                  color: AppTheme.subTextColor),
                          decoration: InputDecoration(
                            label: Text(
                              "Can you tell us more about the issue",
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.strokeColor, width: 1.0),
                                borderRadius: BorderRadius.circular(8.sp)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.strokeColor, width: 1.0),
                                borderRadius: BorderRadius.circular(8.sp)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.strokeColor, width: 1.0),
                                borderRadius: BorderRadius.circular(8.sp)),
                            filled: true,
                            fillColor: AppTheme.appBarAndBottomBarColor,
                          ),
                          onChanged: (childValue) {
                            ref
                                .read(selectedChildQuestionProvider.notifier)
                                .state = childValue;
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppTheme.subTextColor,
                          ),
                          items: selectedValue.children!
                              .map((child) => DropdownMenuItem(
                                    value: child,
                                    child: Text(child.childQuestion ?? ""),
                                  ))
                              .toList(),
                        ),
                      ),
                    if (selectedValue?.id == "other_option")
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: TextField(
                          cursorColor: AppTheme.cursorColor,
                          cursorWidth: 1.0,
                          cursorHeight: 18.h,
                          textAlignVertical: TextAlignVertical.top,
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                          controller: otherTextController,
                          decoration: InputDecoration(
                            labelText: "What is your query about",
                            labelStyle: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.subTextColor),
                            filled: true,
                            fillColor: AppTheme.appBarAndBottomBarColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.strokeColor, width: 1.0),
                                borderRadius: BorderRadius.circular(8.sp)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.strokeColor, width: 1.0),
                                borderRadius: BorderRadius.circular(8.sp)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.strokeColor, width: 1.0),
                                borderRadius: BorderRadius.circular(8.sp)),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          SizedBox(
                              height: 85.h,
                              child: TextField(
                                cursorColor: AppTheme.cursorColor,
                                cursorWidth: 1.0,
                                cursorHeight: 18.h,
                                textAlignVertical: TextAlignVertical.top,
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                controller: moreDetailTextController,
                                maxLines: null,
                                expands: true,
                                decoration: InputDecoration(
                                  labelText: "Can you give us more details?",
                                  labelStyle: AppTheme
                                      .lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.subTextColor,
                                  ),
                                  filled: true,
                                  fillColor: AppTheme.appBarAndBottomBarColor,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.strokeColor,
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
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: InkWell(
                        onTap: () {
                          ref
                              .read(submitHelpRequestApiProvider(
                                      SubmitRequestParams(
                                          selectedItem?.question ?? "",
                                          selectedItem?.id == "other_option"
                                              ? otherTextController.text
                                              : selectedChildValue
                                                      ?.childQuestion ??
                                                  "",
                                          moreDetailTextController.text))
                                  .future)
                              .then((onValue) {
                            if (onValue.status) {
                              ref
                                  .read(selectedChildQuestionProvider.notifier)
                                  .state = null;
                              ref
                                  .read(selectedFirstQuestionProvider.notifier)
                                  .state = null;
                              otherTextController.text = "";
                              moreDetailTextController.text = "";
                            }
                            if (context.mounted) {
                              ConstantMethods.showSnackbar(
                                  context, onValue.message ?? "");
                            }
                          });
                        },
                        child: Container(
                          width: ScreenUtil().screenWidth,
                          height: 40.h,
                          decoration: ShapeDecoration(
                            color: AppTheme.subTextColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                          child: Center(
                            child: Text('Submit',
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                        color:
                                            AppTheme.appBarAndBottomBarColor)),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              case false:
                if (data.statusCode == 402) {
                  return refreshApi(ref);
                }
                return ConstantMethods.buildErrorUI(
                  ref,
                  onPressed: () {
                    refreshApi(ref);
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
                  return ref.refresh(helpQuestionsApiProvider);
                },
              );
            }
            return ConstantMethods.buildErrorUI(
              ref,
              onPressed: () {
                refreshApi(ref);
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
        ),
      ),
    );
  }

  refreshApi(WidgetRef ref) async {
    await ApiUtils.refreshToken();
    return ref.refresh(helpQuestionsApiProvider);
  }
}

final selectedFirstQuestionProvider =
    StateProvider.autoDispose<HelpQuestionsModelData?>((ref) => null);

final selectedChildQuestionProvider =
    StateProvider.autoDispose<HelpQuestionsModelChildren?>((ref) => null);

final helpQuestionsApiProvider =
    FutureProvider<HelpQuestionsModel>((ref) async {
  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.helpQuestionsUrl,
      method: "GET",
      useAuth: true);
  return HelpQuestionsModel.fromJson(data);
});

// ================= Shipping Cart Api Provider ======================
final submitHelpRequestApiProvider =
    FutureProvider.family<CommonModel, SubmitRequestParams>((ref, param) async {
  var encodedParam = json.encode({
    "topic": param.topic,
    "about_issue": param.issue,
    "description": param.desc
  });

  final data = await ApiUtils.makeRequest(
      Constants.baseUrl + Constants.submitRequestUrl,
      method: "POST",
      jsonParams: encodedParam,
      isRaw: true,
      useAuth: true);
  return CommonModel.fromJson(data);
});

class SubmitRequestParams {
  String topic;
  String issue;
  String desc;
  SubmitRequestParams(this.topic, this.issue, this.desc);
}
