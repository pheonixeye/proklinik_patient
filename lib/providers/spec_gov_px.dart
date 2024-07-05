import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/models/city.dart';
import 'package:patient/models/governorate.dart';
import 'package:patient/models/speciality.dart';

class PxSpecGov extends ChangeNotifier {
  PxSpecGov() {
    _init();
  }

  Future<void> _init() async {
    final specData = rootBundle.loadString(Assets.specialities);
    final govData = rootBundle.loadString(Assets.governorates);

    final List<String> collectedData = await Future.wait([
      specData,
      govData,
    ]);

    // print(_collectedDate);

    final String specs = collectedData[0];
    final String govs = collectedData[1];

    final List<dynamic> specStructure = json.decode(specs);
    final List<dynamic> govStructure = json.decode(govs);

    // print(specStructure);

    _governorates = govStructure.map((e) => Governorate.fromJson(e)).toList();
    _specialities = specStructure.map((e) => Speciality.fromJson(e)).toList();
    notifyListeners();
  }

  List<Speciality>? _specialities;
  List<Speciality>? get specialities => _specialities;

  List<Governorate>? _governorates;
  List<Governorate>? get governorates => _governorates;

  List<City>? _cities;
  List<City>? get cities => _cities;

  Speciality? _speciality;
  Speciality? get speciality => _speciality;

  Governorate? _governorate;
  Governorate? get governorate => _governorate;

  City? _city;
  City? get city => _city;

  void selectSpeciality(Speciality value) {
    _speciality = value;
    notifyListeners();
  }

  void selectGovernorate(Governorate value) {
    _governorate = value;
    notifyListeners();
    _city = null;
    _cities = null;
    notifyListeners();
    _cities = value.cities;
    notifyListeners();
  }

  void selectCity(City value) {
    _city = value;
    notifyListeners();
  }
}
