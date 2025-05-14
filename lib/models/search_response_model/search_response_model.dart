import 'package:equatable/equatable.dart';
import 'package:proklinik_patient/models/clinic/clinic.dart';
import 'package:proklinik_patient/models/doctor/doctor.dart';
import 'package:proklinik_patient/models/doctor/doctor_website_info.dart';

class SearchResponseModel extends Equatable {
  final Doctor doctor;
  final DoctorWebsiteInfo doctor_website_info;
  final Clinic clinic;
  final int total_count;
  final int total_pages;
  final int clinic_waiting_time;

  const SearchResponseModel({
    required this.clinic,
    required this.doctor,
    required this.total_count,
    required this.total_pages,
    required this.clinic_waiting_time,
    required this.doctor_website_info,
  });

  SearchResponseModel copyWith({
    Clinic? clinic,
    Doctor? doctor,
    int? total_count,
    int? total_pages,
    int? clinic_waiting_time,
    DoctorWebsiteInfo? doctor_website_info,
  }) {
    return SearchResponseModel(
      clinic: clinic ?? this.clinic,
      doctor: doctor ?? this.doctor,
      total_count: total_count ?? this.total_count,
      total_pages: total_pages ?? this.total_pages,
      clinic_waiting_time: clinic_waiting_time ?? this.clinic_waiting_time,
      doctor_website_info: doctor_website_info ?? this.doctor_website_info,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'clinic': clinic.toJson(),
      'doctor': doctor.toJson(),
      'total_count': total_count,
      'total_pages': total_pages,
      'clinic_waiting_time': clinic_waiting_time,
      'doctor_website_info': doctor_website_info.toJson(),
    };
  }

  factory SearchResponseModel.fromJson(Map<String, dynamic> map) {
    return SearchResponseModel(
      clinic: Clinic.fromJson(map['clinic'] as Map<String, dynamic>),
      doctor: Doctor.fromJson(map['doctor'] as Map<String, dynamic>),
      total_count: map['total_count'] as int,
      total_pages: map['total_pages'] as int,
      clinic_waiting_time: map['clinic_waiting_time'] as int,
      doctor_website_info: DoctorWebsiteInfo.fromJson(
          map['doctor_website_info'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        clinic,
        doctor,
        total_count,
        total_pages,
        clinic_waiting_time,
        doctor_website_info,
      ];
}
