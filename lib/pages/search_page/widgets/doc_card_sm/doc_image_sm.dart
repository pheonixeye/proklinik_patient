import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/models/doctor.dart';

class DocImageSm extends StatefulWidget {
  const DocImageSm({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<DocImageSm> createState() => _DocImageSmState();
}

class _DocImageSmState extends State<DocImageSm> {
  //todo: accept doctor image
  late final ImageProvider image;

  @override
  void initState() {
    if (widget.doctor.avatar == null || widget.doctor.avatar!.isEmpty) {
      image = AssetImage(Assets.doctorEmptyAvatar());
    } else {
      image = NetworkImage("${widget.doctor.avatarUrl}");
    }
    super.initState();
  }

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
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
