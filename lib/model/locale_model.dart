import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleModel extends StateNotifier<Locale> {
  LocaleModel(super.locale);
  void set(Locale locale) {
    state = locale;
    Locale(locale.languageCode);
  }
}
