import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingOverlay extends ConsumerWidget {
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);

    return Stack(
      children: [
        // Main content of the screen
        child,

        // Conditionally show the loading overlay
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: AppTheme.textColor.withOpacity(0.5), // Background overlay
              child: Center(
                child: SpinKitPumpingHeart(
                  color: AppTheme.appBarAndBottomBarColor,
                  size: ScreenUtil().setHeight(50),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
