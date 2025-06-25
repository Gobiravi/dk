import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/router.dart';
import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51PsAs8FUDgzMNUwFE0fdriiCfG0Zy5qEm1dbphRWAijVqINVt8OYVL8IUtkAopfp8TSBUXukI6OHUq9vVrnu6BbS00gDBQzQyc";
  // "pk_live_51PsAs8FUDgzMNUwF027RD94UBE2uMjVH7LEC6MS3kUDLp0Y9vQuCs9LQnXlVHUT6Yc0mktRuwTlXW7cKXaF3sOGQ0027QfJdwh";
  runApp(ProviderScope(
      child: ScreenUtilInit(
    designSize: const Size(430.0, 930.0),
    enableScaleText: () => false,
    enableScaleWH: () => false,
    minTextAdapt: true,
    builder: (context, child) {
      return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!);
    },
    child: const MyApp(),
  )));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(changeLocaleProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      locale: loc,
      routerConfig: CustomRouter.router,
      localeResolutionCallback: (locale, supportedLocales) {
        return locale;
      },
    );
  }
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
