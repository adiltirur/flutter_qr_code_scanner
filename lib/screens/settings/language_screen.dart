import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/const/colors.dart';
import '../../core/extensions/list.dart';
import '../../core/models/language.dart';
import '../../core/ui/components/radio_list.dart';

extension on Language {
  String get titleText {
    switch (this) {
      case Language.english:
        return 'general.english';

      case Language.german:
        return 'general.german';
    }
  }
}

class LanguageScreen extends StatelessWidget {
  final void Function(Language) onChangeLanguage;

  const LanguageScreen({
    required this.onChangeLanguage,
  });
  RadioListItem<Language> _buildLanguageItem(Language language) {
    return RadioListItem<Language>(
      value: language,
      text: language.titleText.tr(),
    );
  }

  Text _buildTitle() {
    return const Text(
      'language.title',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: WBColors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: WBColors.primary,
          centerTitle: false,
          title: _buildTitle().tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RadioList<Language>(
              items: Language.values.mapToList(_buildLanguageItem),
              value: Language.fromLanguageCode(context.locale.languageCode),
              onChanged: (language) async {
                context.setLocale(language.locale);
                onChangeLanguage(language);
              },
            ),
          ),
        ],
      ),
    );
  }
}
