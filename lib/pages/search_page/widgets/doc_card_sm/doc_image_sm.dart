import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';

class DocImageSm extends StatelessWidget {
  const DocImageSm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
          ),
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: AssetImage(
              Assets.icon,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
