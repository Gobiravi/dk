import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:dikla_spirit/widgets/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    PushNotificationService.initialize(context);

    // print(Platform.localeName.substring(0, 2));
    Future.delayed(const Duration(seconds: 3)).then((onValue) async {
      String? isOnboardDone = await SecureStorage.get("isOnboardDone");
      if (mounted) {
        if (isOnboardDone != null && isOnboardDone.toLowerCase() == "true") {
          final id = await SecureStorage.get('user_id');
          if (context.mounted) {
            // if (id != null && id.isNotEmpty) {
            //   context.goNamed("dashboard");
            // } else {
            context.goNamed("login_options");
            // }
          }
        } else {
          context.goNamed("onboarding");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  "${Constants.imagePath}logo.png",
                  height: 142.sp,
                ),
                Text(
                  "DIKLA SPIRIT",
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryColor,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.80),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
