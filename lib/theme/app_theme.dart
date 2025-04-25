import 'package:flutter/material.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class AppTheme {
  const AppTheme();

  static final appBarColor = Colors.green.shade500.withValues(alpha: 0.9);
  static final secondaryOrangeColor =
      Colors.orange.shade500.withValues(alpha: 0.9);

  static final _theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    primaryColor: Colors.green,
    useMaterial3: true,
    fontFamily: "IBM",
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        overlayColor: WidgetStatePropertyAll(Colors.amber.shade500),
        surfaceTintColor: WidgetStatePropertyAll(Colors.amber.shade500),
        mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.white,
      thickness: 3,
      space: 3,
      indent: 20,
      endIndent: 20,
    ),
    appBarTheme: AppBarTheme(
      color: appBarColor,
      elevation: 8,
      centerTitle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  static get theme => _theme;

  static RoundedRectangleBorder localizedCardBorder(
    BuildContext context,
    int index,
  ) {
    final isEnglish = context.read<PxLocale>().lang == "en";
    const borderRadius = 16.0;
    if (index == 1 || index == 2) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      );
    }
    if (isEnglish && index == 0) {
      return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
        ),
      );
    } else if (isEnglish && index == 3) {
      return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );
    } else if (!isEnglish && index == 0) {
      return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );
    } else {
      return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
        ),
      );
    }
  }

  static BoxDecoration searchContainerDecoration = BoxDecoration(
    border: Border.all(
      width: 3,
      color: Colors.green.shade800,
    ),
  );

  static Color mainFontColor = Colors.blueGrey.shade500;

  static const Color greyBackgroundColor = Color(0xffEEF0F2);
}
