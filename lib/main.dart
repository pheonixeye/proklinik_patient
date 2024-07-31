import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';
// ignore: depend_on_referenced_packages
// import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:patient/core/localization/app_localizations.dart';
import 'package:patient/providers/_main.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/utils/utils_keys.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  if (kIsWeb) {
    MetaSEO().config();
  }
  runApp(const AppProvider());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return MaterialApp.router(
          scaffoldMessengerKey: UtilsKeys.scaffoldMessengerKey,
          title: "ProKliniK Patients",
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          locale: l.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          // builder: (context, child) {
          //   child = EasyLoading.init()(context, child);
          //   return child;
          // },
          theme: AppTheme.theme,
        );
      },
    );
  }
}
