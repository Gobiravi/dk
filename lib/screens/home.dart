import 'package:dikla_spirit/model/providers.dart';
import 'package:dikla_spirit/screens/side_menu.dart';
import 'package:dikla_spirit/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeWidget extends ConsumerWidget {
  final Widget child;
  const HomeWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.read(scaffoldKeyProvider);
    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenuScreen(
        context1: context,
      ),
      body: child,
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
