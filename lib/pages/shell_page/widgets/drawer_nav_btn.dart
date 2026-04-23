import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_patient/extensions/switch_lang.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class DrawerNavBtn extends StatelessWidget {
  const DrawerNavBtn({
    super.key,
    this.routePath,
    required this.title,
    this.icondata,
    this.isForLanguage = false,
  });
  final String? routePath;
  final String title;
  final IconData? icondata;
  final bool isForLanguage;

  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return InkWell(
          onTap: isForLanguage
              ? () {
                  context.switchLanguage();
                  Scaffold.of(context).closeEndDrawer();
                }
              : () {
                  GoRouter.of(context).go("/${l.lang}/${routePath ?? ''}");
                  Scaffold.of(context).closeEndDrawer();
                },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 18,
                  child: icondata == null
                      ? const SizedBox()
                      : Icon(
                          icondata,
                          size: 18,
                        ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
