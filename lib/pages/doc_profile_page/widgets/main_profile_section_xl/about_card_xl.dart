import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AboutCardXl extends StatelessWidget {
  const AboutCardXl({super.key, required this.model});
  final SearchResponseModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          initiallyExpanded: true,
          title: Text(
            context.loc.aboutTheDoctor,
            style: TextStyle(
              color: AppTheme.mainFontColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(
            FontAwesomeIcons.userDoctor,
            color: Colors.green,
            size: 16,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Consumer<PxLocale>(
                builder: (context, l, _) {
                  return Row(
                    children: [
                      Flexible(
                        child: Text(
                          l.isEnglish
                              ? model.doctor.about_en
                              : model.doctor.about_ar,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
