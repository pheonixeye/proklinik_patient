import 'package:flutter/material.dart';
import 'package:patient/theme/app_theme.dart';

class DocDataXl extends StatelessWidget {
  const DocDataXl({super.key});

  //TODO: accept doctor data and rating overall

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 400,
      child: Column(
        children: [
          const SizedBox(height: 40),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text.rich(
              TextSpan(
                text: "Doctor",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.green.shade500,
                ),
                children: [
                  const TextSpan(text: " "),
                  TextSpan(
                    text: "Kareem Zaher",
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
              "Urology and Andrology Specialist Surgeon",
              style: TextStyle(
                color: AppTheme.mainFontColor,
              ),
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
            subtitle: Text(
              "Overall Rating From 129 Visitors",
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.mainFontColor,
              ),
            ),
          ),
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
        ],
      ),
    );
  }
}

class SecondaryDataItemXl extends StatelessWidget {
  const SecondaryDataItemXl({
    super.key,
    required this.iconData,
    required this.title,
    required this.data,
  });
  final IconData iconData;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Icon(iconData, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: title,
                style: TextStyle(
                  color: AppTheme.mainFontColor,
                ),
                children: [
                  TextSpan(
                    text: data,
                    style: TextStyle(
                      color: Colors.green.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
