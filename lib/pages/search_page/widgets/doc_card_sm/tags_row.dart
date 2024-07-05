import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class _TagRowData {
  final String titleEn;
  final String titleAr;
  final IconData iconData;

  const _TagRowData({
    required this.titleEn,
    required this.titleAr,
    required this.iconData,
  });
}

const List<_TagRowData> _dummyData = [
  _TagRowData(
    titleEn: "Friendly",
    titleAr: "ودود",
    iconData: Icons.eco,
  ),
  _TagRowData(
    titleEn: "Good Listener",
    titleAr: "مستمع جيد",
    iconData: FontAwesomeIcons.earListen,
  ),
  _TagRowData(
    titleEn: "Informative",
    titleAr: "شرحه مفصل",
    iconData: Icons.message,
  ),
];

class TagsRowXlSm extends StatelessWidget {
  const TagsRowXlSm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            ..._dummyData.map(
              (e) => TagRowCard(data: e),
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
  final _TagRowData data;

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
