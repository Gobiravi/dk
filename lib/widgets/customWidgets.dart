import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomText extends ConsumerWidget {
  final String text;
  final TextStyle style;

  const CustomText(this.text, this.style, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      text,
      style: style,
    );
  }
}
