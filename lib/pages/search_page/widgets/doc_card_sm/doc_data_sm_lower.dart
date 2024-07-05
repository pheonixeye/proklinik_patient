import 'package:flutter/material.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_data_xl.dart';
import 'package:patient/theme/app_theme.dart';

class DocDataSmLower extends StatelessWidget {
  const DocDataSmLower({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const SecondaryDataItemXl(
            iconData: Icons.medical_services,
            title: "Speciality : ",
            data: "Urology",
          ),
          const SecondaryDataItemXl(
            iconData: Icons.pin_drop,
            title: "Maadi : ",
            data: "Zahraa El Maadi - El Nada Tower - First Floor",
          ),
          const SecondaryDataItemXl(
            iconData: Icons.monetization_on,
            title: "Fees : ",
            data: "250 EGP",
          ),
          const SecondaryDataItemXl(
            iconData: Icons.timer,
            title: "Waiting Time : ",
            data: "30 Minutes",
          ),
          const SecondaryDataItemXl(
            iconData: Icons.phone,
            title: "18888 : ",
            data: "Cost Of Regular Call",
          ),
          // const SizedBox(height: 10),
          const Spacer(),

          ///reserve now row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    color: AppTheme.greyBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Available Today From 09:00 P.M.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: AppTheme.secondaryOrangeColor,
                  ),
                  onPressed: () {
                    //TODO: nav to book page
                  },
                  child: const Text(
                    "Book",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
