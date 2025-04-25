import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';

class HomepageBtn extends StatelessWidget {
  const HomepageBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: AppTheme.appBarColor,
              width: 0.3,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          //todo: go to homepage
          GoRouter.of(context).goNamed(
            AppRouter.home,
            pathParameters: defaultPathParameters(context),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 24,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_rounded,
                color: AppTheme.mainFontColor,
              ),
              const SizedBox(width: 5),
              Text(
                context.loc.homepage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.mainFontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
