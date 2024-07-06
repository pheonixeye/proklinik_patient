import 'package:flutter/material.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/main_profile_section_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/side_profile_section_xl/side_profile_section_xl.dart';
import 'package:patient/providers/doc_profile_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class DocProfilePage extends StatelessWidget {
  const DocProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxDocProfile>(
      builder: (context, d, _) {
        final _profileData = d.doctor;
        while (_profileData == null) {
          return const CentralLoading();
        }
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.greyBackgroundColor,
          ),
          child: ListView(
            shrinkWrap: true,
            children: const [
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(
                    flex: 90,
                  ),

                  ///main doctor profile info section
                  MainProfileSectionXl(),

                  ///central space
                  SizedBox(width: 15),

                  ///booking info section
                  SideProfileSectionXl(),
                  Spacer(
                    flex: 90,
                  ),
                ],
              ),
              SizedBox(height: 10),
              FooterSection()
            ],
          ),
        );
      },
    );
  }
}
