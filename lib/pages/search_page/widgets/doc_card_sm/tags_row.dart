import 'package:flutter/material.dart';
import 'package:proklinik_patient/constants/tags.dart';
import 'package:proklinik_patient/models/doctor/doctor_tag.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class TagsRowXlSm extends StatelessWidget {
  const TagsRowXlSm({super.key, required this.tags});
  final List<DoctorTag> tags;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            ...tags.map(
              (e) => TagRowCard(
                  data: ALLTAGS.firstWhere((t) => t.titleEn == e.name_en)),
            ),
          ],
        ),
      ),
    );
  }
}

class TagRowCard extends StatelessWidget {
  const TagRowCard({
    super.key,
    // ignore: library_private_types_in_public_api
    required this.data,
  });
  // ignore: library_private_types_in_public_api
  final TagRowData data;

  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    data.iconData,
                    color: Colors.green,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    l.isEnglish ? data.titleEn : data.titleAr,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.mainFontColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
