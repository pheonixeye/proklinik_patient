import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/avatar_url_doctor_ext.dart';
import 'package:patient/models/doctor/doctor.dart';

class DocImageXl extends StatefulWidget {
  const DocImageXl({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<DocImageXl> createState() => _DocImageXlState();
}

class _DocImageXlState extends State<DocImageXl> {
  //todo: accept doctor image
  late final ImageProvider image;

  @override
  void initState() {
    if (widget.doctor.avatar.isEmpty) {
      image = AssetImage(Assets.doctorEmptyAvatar());
    } else {
      image = NetworkImage(widget.doctor.avatarUrl);
    }
    super.initState();
  }
  //http://127.0.0.1:8090/api/files/doctors/${doctor.id}/${doctor.avatar}?thumb=200x200

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
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
