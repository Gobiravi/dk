import 'package:dikla_spirit/l10n/app_localizations.dart';
import 'package:dikla_spirit/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocaleChangeWidget extends HookConsumerWidget {
  const LocaleChangeWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var localization = AppLocalizations.of(context);
    final loc = ref.watch(changeLocaleProvider);
    return DropdownButton(
      value: loc.languageCode,
      items: [
        DropdownMenuItem(
          value: "en",
          child: Text(localization.pageSettingsInputLanguage("en")),
        ),
        DropdownMenuItem(
          value: "he",
          child: Text(localization.pageSettingsInputLanguage("he")),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          ref.read(changeLocaleProvider.notifier).set(Locale(value));
        }
      },
    );
  }
}
