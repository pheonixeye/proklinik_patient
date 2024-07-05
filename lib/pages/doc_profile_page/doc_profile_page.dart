import 'package:flutter/material.dart';
import 'package:patient/providers/doc_profile_px.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class DocProfilePage extends StatelessWidget {
  const DocProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Consumer<PxDocProfile>(
          builder: (context, d, _) {
            final _profileData = d.doctor;
            while (_profileData == null) {
              return const CentralLoading();
            }
            return Center(
              child: Text(_profileData),
            );
          },
        ),
        const FooterSection()
      ],
    );
  }
}
