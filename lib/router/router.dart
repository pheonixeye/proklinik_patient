import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/models/query_object.dart';
import 'package:patient/pages/book_page/book_page.dart';
import 'package:patient/pages/contact_us_page/contact_us_page.dart';
import 'package:patient/pages/for_provider_page/for_provider_page.dart';
import 'package:patient/pages/homepage/homepage.dart';
import 'package:patient/pages/loading_root_page/loading_root_page.dart';
import 'package:patient/pages/pt_login_page/pt_login_page.dart';
import 'package:patient/pages/pt_signup_page/pt_signup_page.dart';
import 'package:patient/pages/search_page/search_page.dart';
import 'package:patient/pages/shell_page/shell_page.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/search_px.dart';
import 'package:patient/utils/utils_keys.dart';
import 'package:provider/provider.dart';

const _langs = ["en", "ar"];

/// GoRouter configuration
///
class AppRouter {
  AppRouter();
  static const String loading = "/";
  static const String home = ":lang";
  static const String src = "src";
  static const String book = "book";
  static const String signup = "signup";
  static const String login = "login";
  static const String forproviders = "forproviders";
  static const String contactus = "contactus";

  static final router = GoRouter(
    refreshListenable: Listenable.merge(
      [
        PxLocale(),
        PxSearchController(
          query: QueryObject.fromJson(
            const {},
          ),
        ),
      ],
    ),
    navigatorKey: UtilsKeys.navigatorKey,
    initialLocation: loading,
    redirect: (context, state) {
      if (kDebugMode) {
        print(state.fullPath);
      }
      final lang = state.pathParameters['lang'];
      if (lang == null) {
        context.read<PxLocale>().setLang("en");
        return "/en${state.fullPath}";
      } else if (!_langs.contains(lang)) {
        context.read<PxLocale>().setLang("en");
        return "/en${state.fullPath}";
      } else {
        context.read<PxLocale>().setLang(lang);
        return null;
      }
    },
    routes: [
      GoRoute(
        path: loading,
        name: loading,
        builder: (context, state) {
          return LoadingRootPage(
            key: state.pageKey,
          );
        },
        routes: [
          ShellRoute(
            pageBuilder: (context, state, child) {
              return MaterialPage(
                child: ShellPage(
                  key: state.pageKey,
                  child: child,
                ),
              );
            },
            routes: [
              GoRoute(
                name: home,
                path: home,
                builder: (context, state) {
                  return HomePage(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: signup,
                    name: signup,
                    builder: (context, state) {
                      return PatientSignUpPage(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: login,
                    name: login,
                    builder: (context, state) {
                      return PatientLoginPage(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: forproviders,
                    name: forproviders,
                    builder: (context, state) {
                      return ForProvidersPage(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: contactus,
                    name: contactus,
                    builder: (context, state) {
                      return ContactUsPage(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    name: src,
                    path: src,
                    builder: (context, state) {
                      final query = state.uri.queryParameters;
                      final obj = QueryObject.fromJson(query);
                      final key = ValueKey((obj, state.pageKey));
                      if (kDebugMode) {
                        print("GoRoute($src)=$key");
                      }
                      return ChangeNotifierProvider(
                        key: key,
                        create: (context) => PxSearchController(
                          query: QueryObject.fromJson(query),
                        ),
                        builder: (context, child) {
                          return SearchPage(
                            key: key,
                          );
                        },
                      );
                    },
                    routes: [
                      GoRoute(
                        name: book,
                        path: book,
                        builder: (context, state) {
                          return BookPage(
                            key: state.pageKey,
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
