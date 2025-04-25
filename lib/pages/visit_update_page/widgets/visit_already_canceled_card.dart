import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/homepage_btn/homepage_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisitAlreadyCanceledCard extends StatelessWidget {
  const VisitAlreadyCanceledCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 60,
        vertical: context.isMobile ? 20 : 60,
      ),
      child: Center(
        child: Column(
          children: [
            Card.outlined(
              elevation: 2,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: context.isMobile ? 30 : 60),
                        Icon(
                          FontAwesomeIcons.faceSurprise,
                          size: context.isMobile ? 36 : 72,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          context.loc.bookingAlreadyCanceled,
                          style: TextStyle(
                            color: AppTheme.mainFontColor,
                            fontSize: context.isMobile ? 18 : 36,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          context.loc.thankYouForUsingProklinik,
                          style: TextStyle(
                            color: AppTheme.mainFontColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(height: context.isMobile ? 30 : 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const HomepageBtn(),
          ],
        ),
      ),
    );
  }
}
