import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ZodiacSignScreen extends ConsumerStatefulWidget {
  const ZodiacSignScreen({super.key});

  @override
  ConsumerState<ZodiacSignScreen> createState() => _ZodiacSignScreenState();
}

class _ZodiacSignScreenState extends ConsumerState<ZodiacSignScreen> {
  ZodiacSignModel? tempSelectedZodiac; // Temporary selection

  final List<ZodiacSignModel> zodiacSigns = [
    ZodiacSignModel(
        name: "Aries",
        dateRange: "Mar 21 - Apr 19",
        imagePath: "${Constants.imagePathZodiacSign}aries.svg"),
    ZodiacSignModel(
        name: "Taurus",
        dateRange: "Apr 20 - May 20",
        imagePath: "${Constants.imagePathZodiacSign}taurus.svg"),
    ZodiacSignModel(
        name: "Gemini",
        dateRange: "May 21 - Jun 20",
        imagePath: "${Constants.imagePathZodiacSign}gemini.svg"),
    ZodiacSignModel(
        name: "Cancer",
        dateRange: "Jun 21 - Jul 22",
        imagePath: "${Constants.imagePathZodiacSign}cancer.svg"),
    ZodiacSignModel(
        name: "Leo",
        dateRange: "Jul 23 - Aug 22",
        imagePath: "${Constants.imagePathZodiacSign}leo.svg"),
    ZodiacSignModel(
        name: "Virgo",
        dateRange: "Aug 23 - Sep 22",
        imagePath: "${Constants.imagePathZodiacSign}virgo.svg"),
    ZodiacSignModel(
        name: "Libra",
        dateRange: "Sep 23 - Oct 22",
        imagePath: "${Constants.imagePathZodiacSign}libra.svg"),
    ZodiacSignModel(
        name: "Scorpio",
        dateRange: "Oct 23 - Nov 21",
        imagePath: "${Constants.imagePathZodiacSign}scorpio.svg"),
    ZodiacSignModel(
        name: "Sagittarius",
        dateRange: "Nov 22 - Dec 21",
        imagePath: "${Constants.imagePathZodiacSign}sagittarius.svg"),
    ZodiacSignModel(
        name: "Capricorn",
        dateRange: "Dec 22 - Jan 19",
        imagePath: "${Constants.imagePathZodiacSign}capricorn.svg"),
    ZodiacSignModel(
        name: "Aquarius",
        dateRange: "Jan 20 - Feb 18",
        imagePath: "${Constants.imagePathZodiacSign}aquarius.svg"),
    ZodiacSignModel(
        name: "Pisces",
        dateRange: "Feb 19 - Mar 20",
        imagePath: "${Constants.imagePathZodiacSign}pisces.svg"),
  ];

  @override
  void initState() {
    super.initState();
    // Set tempSelectedZodiac to the currently saved selection
    tempSelectedZodiac = ref.read(selectedZodiacProvider);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final selectedZodiac = ref.watch(selectedZodiacProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg"),
        ),
        title: Text(
          localization.zodiac_sign,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            fontSize: 17.sp,
            color: AppTheme.textColor,
            letterSpacing: -0.45,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 21.h),
              Text(localization.select_your_zodiac_sign,
                  style: AppTheme.lightTheme.textTheme.bodyLarge),
              SizedBox(height: 30.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: GridView.builder(
                    itemCount: zodiacSigns.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.56,
                    ),
                    itemBuilder: (context, index) {
                      final zodiac = zodiacSigns[index];
                      final isSelected =
                          tempSelectedZodiac?.name.toLowerCase() ==
                              zodiac.name.toLowerCase();

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            tempSelectedZodiac = zodiac;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 92.h,
                              width: 92.h,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.pink[100]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  zodiac.imagePath,
                                  height: 65.h,
                                  width: 65.h,
                                  colorFilter: ColorFilter.mode(
                                    isSelected
                                        ? AppTheme.textColor
                                        : AppTheme.strokeColor,
                                    BlendMode.modulate,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              zodiac.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              zodiac.dateRange,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    ref.read(selectedZodiacProvider.notifier).state =
                        tempSelectedZodiac;
                    context.pop();
                  },
                  child: Container(
                    height: 60.sp,
                    decoration: const ShapeDecoration(
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
                            localization.save_changes,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.appBarAndBottomBarColor,
                              fontSize: 14.sp,
                            ),
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
}

class ZodiacSignModel {
  final String name;
  final String dateRange;
  final String imagePath;

  ZodiacSignModel(
      {required this.name, required this.dateRange, required this.imagePath});
}

final selectedZodiacProvider = StateProvider<ZodiacSignModel?>((ref) => null);
