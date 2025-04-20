import 'package:flutter/material.dart';
import 'package:patient/extensions/model_widgets_ext.dart';
import 'package:patient/models/doctor/doctor.dart';

class DocImageXl extends StatelessWidget {
  const DocImageXl({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 150,
      child: Column(
        children: [
          const SizedBox(height: 50),
          FutureBuilder<ImageProvider<Object>>(
            future: doctor.widgetImageProvider(),
            builder: (context, snapshot) {
              while (!snapshot.hasData) {
                return Container(
                  width: 125,
                  height: 125,
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
                width: 125,
                height: 125,
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
        ],
      ),
    );
  }
}
