import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/models/doctor.dart';

class DocImageSm extends StatelessWidget {
  const DocImageSm({super.key, required this.doctor});
  final Doctor doctor;

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
          image: DecorationImage(
            image: AssetImage(
              Assets.doctorAvatar(doctor.synd_id),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
