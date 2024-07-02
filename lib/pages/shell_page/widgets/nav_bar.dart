import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/switch_lang.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/router/router.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return AppBar(
          automaticallyImplyLeading: false,
          title: InkWell(
            mouseCursor: context.isMobile ? null : SystemMouseCursors.click,
            onTap: context.isMobile
                ? null
                : () {
                    GoRouter.of(context).go("/${l.lang}");
                  },
            child: Row(
              children: [
                SizedBox(width: context.isMobile ? 10 : 50),
                Image.asset(
                  Assets.icon,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 20),
                const Text(
                  "ProKliniK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: context.isMobile
              ? [
                  Builder(
                    builder: (context) {
                      return IconButton.outlined(
                        style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: const Icon(Icons.menu),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                ]
              : [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        context.go("/${l.lang}/${AppRouter.signup}");
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(context.loc.signup),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        context.go("/${l.lang}/${AppRouter.login}");
                      },
                      child: Text(context.loc.login),
                    ),
                  ),
                  const VerticalDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        context.go("/${l.lang}/${AppRouter.forproviders}");
                      },
                      child: Text(context.loc.forProviders),
                    ),
                  ),
                  const VerticalDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        context.go("/${l.lang}/${AppRouter.contactus}");
                      },
                      child: Text(context.loc.contactUs),
                    ),
                  ),
                  const VerticalDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<PxLocale>(
                      builder: (context, l, _) {
                        return TextButton(
                          onPressed: () {
                            context.switchLanguage();
                          },
                          child: Text(l.lang == "en" ? "عربي" : "English"),
                        );
                      },
                    ),
                  ),
                  const VerticalDivider(),
                  const SizedBox(width: 100),
                ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
