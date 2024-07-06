import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/theme/app_theme.dart';

class AboutCardXl extends StatelessWidget {
  const AboutCardXl({super.key});

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
            "About The Doctor",
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
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                        "- MD Pediatric and Neonatology. - Pediatric and Neonatology Consultant. - Consultant of Pulmonology, Asthma, Allergy, Immunology and Vaccinology. - Member of Scientific Council of Egyptian board of Pediatric. - Member of American Academy of Pediatric. - Consultant at Police Hospitals. - Consultant at Wadi Elneel Hospital. - Consultant at Air Force Specialized Hospital."),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
