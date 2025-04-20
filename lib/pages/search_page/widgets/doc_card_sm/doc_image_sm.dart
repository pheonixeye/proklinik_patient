import 'package:flutter/material.dart';
import 'package:patient/extensions/model_widgets_ext.dart';
import 'package:patient/models/doctor/doctor.dart';

class DocImageSm extends StatelessWidget {
  const DocImageSm({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: FutureBuilder<ImageProvider<Object>>(
        future: doctor.widgetImageProvider(),
        builder: (context, snapshot) {
          while (!snapshot.hasData) {
            return Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  padding: EdgeInsets.all(0),
                ),
              ),
            );
          }
          return Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: snapshot.data!,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
