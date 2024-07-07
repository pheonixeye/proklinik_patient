import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/models/doctor.dart';

class DocImageXl extends StatelessWidget {
  const DocImageXl({super.key, required this.doctor});
  final Doctor doctor;

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
              image: DecorationImage(
                image: AssetImage(
                  Assets.doctorAvatar(doctor.synd_id),
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
