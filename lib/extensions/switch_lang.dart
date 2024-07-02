import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/lang_ext.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

extension SwitchLanguage on BuildContext {
  void switchLanguage() {
    late final String newPath;
    final lang = GoRouter.of(this)
        .routerDelegate
        .currentConfiguration
        .pathParameters['lang'] as String;
    final currentPath =
        GoRouter.of(this).routerDelegate.currentConfiguration.uri.path;
    if (lang == 'en') {
      newPath = currentPath.replaceAll('/en', '/ar');
    } else {
      newPath = currentPath.replaceAll('/ar', '/en');
    }
    read<PxLocale>().setLang(lang.switchLang());
    read<PxLocale>().setLocale();
    GoRouter.of(this).go(newPath);
  }
}
