import 'package:flutter/material.dart';
import 'package:patient/theme/app_theme.dart';

class SortingRowXl extends StatelessWidget {
  const SortingRowXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          //TODO: search speciality
          Text(
            "Urology",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.mainFontColor,
            ),
          ),
          const SizedBox(width: 10),
          //TODO: number of results
          Text(
            "28 Doctors",
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.mainFontColor,
            ),
          ),
          const Spacer(flex: 3),
          Text(
            "Sorting :",
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.mainFontColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 0.1,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                dropdownColor: Colors.white,
                hint: const Text("Sort By"),
                elevation: 0,
                isExpanded: true,
                alignment: Alignment.center,
                icon: const Icon(
                  Icons.arrow_drop_down_circle_rounded,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(8),
                items: <String>[
                  "Best Match",
                  "Price : Low To High",
                  "Price : High To Low",
                  "Waiting Time",
                  "Top Rated"
                ].map((e) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  //TODO: implement sorting
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
