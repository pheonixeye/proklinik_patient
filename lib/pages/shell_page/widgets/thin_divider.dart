import 'package:flutter/material.dart';

class ThinDivider extends StatelessWidget {
  const ThinDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(
        height: 1,
        thickness: 2,
        color: Colors.white,
      ),
    );
  }
}
