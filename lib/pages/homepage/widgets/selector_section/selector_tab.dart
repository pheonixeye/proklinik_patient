import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';

class SelectorTab extends StatelessWidget {
  const SelectorTab({
    super.key,
    required this.title,
    required this.iconData,
    required this.selected,
  });
  final String title;
  final IconData iconData;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? Colors.green.shade800 : Colors.green.shade50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Icon(
                  iconData,
                  color: selected ? Colors.white : Colors.black,
                  size: context.isMobile ? 18 : null,
                ),
                SizedBox(height: context.isMobile ? 10 : 20),
                Text(
                  title,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontSize: context.isMobile ? 12 : null,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
