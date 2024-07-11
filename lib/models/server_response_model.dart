import 'package:equatable/equatable.dart';
import 'package:patient/models/clinic.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/review.dart';

class ServerResponseModel extends Equatable {
  final Doctor doctor;
  final Clinic clinic;
  final List<Review> reviews;

  const ServerResponseModel({
    required this.doctor,
    required this.clinic,
    required this.reviews,
  });

  ServerResponseModel copyWith({
    Doctor? doctor,
    Clinic? clinic,
    List<Review>? reviews,
  }) {
    return ServerResponseModel(
      doctor: doctor ?? this.doctor,
      clinic: clinic ?? this.clinic,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'doctor': doctor.toJson(),
      'clinic': clinic.toJson(),
      'reviews': reviews.map((x) => x.toJson()).toList(),
    };
  }

  factory ServerResponseModel.fromJson(Map<String, dynamic> map) {
    return ServerResponseModel(
      doctor: Doctor.fromJson(map['doctor'] as Map<String, dynamic>),
      clinic: Clinic.fromJson(map['clinic'] as Map<String, dynamic>),
      reviews: List<Review>.from(
        (map['reviews'] as List<dynamic>).map<Review>(
          (x) => Review.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [doctor, clinic, reviews];
}
