import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/switch_lang.dart';

class LanguageBtn extends StatelessWidget {
  const LanguageBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        heroTag: 'language-btn',
        onPressed: () {
          context.switchLanguage();
        },
        child: const Icon(Icons.language),
      ),
    );
  }
}
