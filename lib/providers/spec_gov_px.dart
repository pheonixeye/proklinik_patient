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
    final _specData = rootBundle.loadString(Assets.specialities);
    final _govData = rootBundle.loadString(Assets.governorates);

    final List<String> _collectedData = await Future.wait([
      _specData,
      _govData,
    ]);

    // print(_collectedDate);

    final String _specs = _collectedData[0];
    final String _govs = _collectedData[1];

    final List<dynamic> specStructure = json.decode(_specs);
    final List<dynamic> govStructure = json.decode(_govs);

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
