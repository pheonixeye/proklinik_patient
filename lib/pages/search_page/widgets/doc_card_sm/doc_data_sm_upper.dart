import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DocDataSmUpper extends StatelessWidget {
  const DocDataSmUpper({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text.rich(
                  TextSpan(
                    text: context.loc.doctor,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.green.shade500,
                    ),
                    children: [
                      const TextSpan(text: " "),
                      TextSpan(
                        text: l.isEnglish ? doctor.name_en : doctor.name_ar,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  l.isEnglish ? doctor.title_en : doctor.title_ar,
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                //TODO: Fetch from somewhere
                subtitle: Text(
                  "Overall Rating From 129 Visitors",
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.mainFontColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
