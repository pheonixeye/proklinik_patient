import 'package:flutter/foundation.dart';

class PxDocProfile extends ChangeNotifier {
  final String docId;

  PxDocProfile({required this.docId}) {
    _init();
  }

  String? _doctor;
  String? get doctor => _doctor;

  Future<void> _init() async {
    if (kDebugMode) {
      print("PxDocProfile().init($_doctor)");
    }
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        _doctor = docId;
        notifyListeners();
        if (kDebugMode) {
          print("PxDocProfile().init($_doctor)");
        }
      },
    );
  }
}
