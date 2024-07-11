import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:patient/theme/app_theme.dart';

class Slogan extends StatelessWidget {
  const Slogan({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: context.isMobile ? 40 : 100),
            Expanded(
              flex: 2,
              child: Text(
                context.loc.slogan,
                style: TextStyle(
                  fontSize: context.isMobile ? 24 : 42,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mainFontColor,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            SizedBox(width: context.isMobile ? 40 : 100),
            Text.rich(
              TextSpan(
                text: context.loc.subSlogan,
                children: [
                  const TextSpan(text: "  "),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        html.window.open("tel:+2018888", "Call Us", "_blank");
                      },
                    //todo: Check style
                    text: context.loc.hotline.toArabicNumber(context),
                    style: TextStyle(
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: context.isMobile ? 18 : 32,
                fontWeight: FontWeight.normal,
                color: AppTheme.mainFontColor,
              ),
            ),
          ],
        ),
        SizedBox(height: context.isMobile ? 10 : 20),
      ],
    );
  }
}
