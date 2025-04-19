import 'package:equatable/equatable.dart';
import 'package:patient/models/clinic/clinic.dart';
import 'package:patient/models/doctor/doctor.dart';

class SearchResponseModel extends Equatable {
  final Clinic clinic;
  final Doctor doctor;
  final int total_count;
  final int total_pages;
  final int clinic_waiting_time;
  final int doctor_views;
  final int doctor_rating;

  const SearchResponseModel({
    required this.clinic,
    required this.doctor,
    required this.total_count,
    required this.total_pages,
    required this.clinic_waiting_time,
    required this.doctor_views,
    required this.doctor_rating,
  });

  SearchResponseModel copyWith({
    Clinic? clinic,
    Doctor? doctor,
    int? total_count,
    int? total_pages,
    int? clinic_waiting_time,
    int? doctor_views,
    int? doctor_rating,
  }) {
    return SearchResponseModel(
      clinic: clinic ?? this.clinic,
      doctor: doctor ?? this.doctor,
      total_count: total_count ?? this.total_count,
      total_pages: total_pages ?? this.total_pages,
      clinic_waiting_time: clinic_waiting_time ?? this.clinic_waiting_time,
      doctor_views: doctor_views ?? this.doctor_views,
      doctor_rating: doctor_rating ?? this.doctor_rating,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'clinic': clinic.toJson(),
      'doctor': doctor.toJson(),
      'total_count': total_count,
      'total_pages': total_pages,
      'clinic_waiting_time': clinic_waiting_time,
      'doctor_views': doctor_views,
      'doctor_rating': doctor_rating,
    };
  }

  factory SearchResponseModel.fromJson(Map<String, dynamic> map) {
    return SearchResponseModel(
      clinic: Clinic.fromJson(map['clinic'] as Map<String, dynamic>),
      doctor: Doctor.fromJson(map['doctor'] as Map<String, dynamic>),
      total_count: map['total_count'] as int,
      total_pages: map['total_pages'] as int,
      clinic_waiting_time: map['clinic_waiting_time'] as int,
      doctor_views: map['doctor_views'] as int,
      doctor_rating: map['doctor_rating'] as int,
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
        doctor_views,
        doctor_rating,
      ];
}
