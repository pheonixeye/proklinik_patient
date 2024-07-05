import 'package:flutter/material.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/book_row_sm.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_data_xl.dart';

class DocDataSmLower extends StatelessWidget {
  const DocDataSmLower({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          SecondaryDataItemXl(
            iconData: Icons.medical_services,
            title: "Speciality : ",
            data: "Urology",
          ),
          SecondaryDataItemXl(
            iconData: Icons.pin_drop,
            title: "Maadi : ",
            data: "Zahraa El Maadi - El Nada Tower - First Floor",
          ),
          SecondaryDataItemXl(
            iconData: Icons.monetization_on,
            title: "Fees : ",
            data: "250 EGP",
          ),
          SecondaryDataItemXl(
            iconData: Icons.timer,
            title: "Waiting Time : ",
            data: "30 Minutes",
          ),
          SecondaryDataItemXl(
            iconData: Icons.phone,
            title: "18888 : ",
            data: "Cost Of Regular Call",
          ),
          // const SizedBox(height: 10),
          Spacer(),

          ///reserve now row
          BookRowSm(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
