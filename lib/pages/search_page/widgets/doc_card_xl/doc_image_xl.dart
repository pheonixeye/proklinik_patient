import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';

class DocImageXl extends StatelessWidget {
  const DocImageXl({super.key});

  //TODO: accept doctor image

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 150,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            width: 125,
            height: 125,
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
        ],
      ),
    );
  }
}
