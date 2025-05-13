// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:proklinik_patient/models/app_constants_model/_models/visit_status.dart';
import 'package:proklinik_patient/models/app_constants_model/_models/visit_type.dart';
import 'package:proklinik_patient/models/clinic/clinic.dart';
import 'package:proklinik_patient/models/doctor/doctor.dart';
import 'package:proklinik_patient/models/visit/visit_shift.dart';

class Visit extends Equatable {
  final String id;
  final String patient_name;
  final String patient_phone;
  final String patient_email;
  final Doctor doctor;
  final Clinic clinic;
  final String patient_id;
  final VisitType? visit_type;
  final VisitStatus visit_status;
  final VisitShift visit_shift;
  final int day;
  final int month;
  final int year;
  final DateTime visit_date;
  final DateTime created;

  const Visit({
    required this.id,
    required this.patient_name,
    required this.patient_phone,
    required this.patient_email,
    required this.doctor,
    required this.clinic,
    required this.patient_id,
    required this.visit_type,
    required this.visit_status,
    required this.visit_shift,
    required this.day,
    required this.month,
    required this.year,
    required this.visit_date,
    required this.created,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'patient_name': patient_name,
      'patient_phone': patient_phone,
      'patient_email': patient_email,
      'doctor': doctor.toJson(),
      'clinic': clinic.toJson(),
      'patient_id': patient_id,
      'visit_type': visit_type?.toJson(),
      'visit_status': visit_status.toJson(),
      'visit_shift': visit_shift.toJson(),
      'day': day,
      'month': month,
      'year': year,
      'visit_date': visit_date.toIso8601String(),
      'created': created.toIso8601String(),
    };
  }

  factory Visit.fromJson(Map<String, dynamic> map) {
    return Visit(
      id: map['id'] as String,
      patient_name: map['patient_name'] as String,
      patient_phone: map['patient_phone'] as String,
      patient_email: map['patient_email'] as String,
      doctor: Doctor.fromJson(map['doctor'] as Map<String, dynamic>),
      clinic: Clinic.fromJson(map['clinic'] as Map<String, dynamic>),
      patient_id: map['patient_id'] as String,
      visit_type: map['visit_type'] != null
          ? VisitType.fromJson(map['visit_type'] as Map<String, dynamic>)
          : null,
      visit_status:
          VisitStatus.fromJson(map['visit_status'] as Map<String, dynamic>),
      visit_shift:
          VisitShift.fromJson(map['visit_shift'] as Map<String, dynamic>),
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
      visit_date: DateTime.parse(map['visit_date'] as String),
      created: DateTime.parse(map['created'] as String),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      patient_name,
      patient_phone,
      patient_email,
      doctor,
      clinic,
      patient_id,
      visit_type,
      visit_status,
      visit_shift,
      day,
      month,
      year,
      visit_date,
      created,
    ];
  }

  Visit copyWith({
    String? id,
    String? patient_name,
    String? patient_phone,
    String? patient_email,
    Doctor? doctor,
    Clinic? clinic,
    String? patient_id,
    VisitType? visit_type,
    VisitStatus? visit_status,
    VisitShift? visit_shift,
    int? day,
    int? month,
    int? year,
    DateTime? visit_date,
    DateTime? created,
  }) {
    return Visit(
      id: id ?? this.id,
      patient_name: patient_name ?? this.patient_name,
      patient_phone: patient_phone ?? this.patient_phone,
      patient_email: patient_email ?? this.patient_email,
      doctor: doctor ?? this.doctor,
      clinic: clinic ?? this.clinic,
      patient_id: patient_id ?? this.patient_id,
      visit_type: visit_type ?? this.visit_type,
      visit_status: visit_status ?? this.visit_status,
      visit_shift: visit_shift ?? this.visit_shift,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      visit_date: visit_date ?? this.visit_date,
      created: created ?? this.created,
    );
  }
}
