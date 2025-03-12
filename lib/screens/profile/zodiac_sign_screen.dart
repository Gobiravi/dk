import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ZodiacSignScreen extends ConsumerWidget {
  ZodiacSignScreen({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final selectedZodiac = ref.watch(selectedZodiacProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 21.h,
            ),
            Text(localization.select_your_zodiac_sign,
                style: AppTheme.lightTheme.textTheme.bodyLarge),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: GridView.builder(
                  itemCount: zodiacSigns.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final zodiac = zodiacSigns[index];
                    final isSelected = zodiac == selectedZodiac;

                    return GestureDetector(
                      onTap: () {
                        ref.read(selectedZodiacProvider.notifier).state =
                            zodiac;
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.pink[100] : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child:
                                SvgPicture.asset(zodiac.imagePath, height: 40),
                          ),
                          SizedBox(height: 5),
                          Text(
                            zodiac.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            zodiac.dateRange,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
