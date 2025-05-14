import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/pages/homepage/widgets/features_section/features_section.dart';
import 'package:proklinik_patient/pages/homepage/widgets/offers_section/offers_section.dart';
import 'package:proklinik_patient/pages/homepage/widgets/selector_section/main_selector.dart';
import 'package:proklinik_patient/pages/homepage/widgets/slogan/slogan.dart';
import 'package:proklinik_patient/pages/homepage/widgets/speciality_row/speciality_row.dart';
import 'package:proklinik_patient/widgets/footer_section/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      cacheExtent: 5000,
      children: [
        SizedBox(height: context.isMobile ? 30 : 60),
        const Slogan(),
        const MainAppSelector(),
        const SpecialityRow(),
        const FeaturesSection(),
        const OffersSection(),
        const FooterSection(),
      ],
    );
  }
}
