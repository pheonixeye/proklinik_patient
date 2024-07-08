// ignore_for_file:  non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:patient/models/server_response_model.dart';

class BookingData extends Equatable {
  final String id;
  final String user_name;
  final String user_phone;
  final String? user_email;
  final String doc_id;
  final String clinic_id;
  final String date_time;
  final ServerResponseModel? model;

  const BookingData({
    required this.id,
    required this.user_name,
    required this.user_phone,
    this.user_email,
    required this.doc_id,
    required this.clinic_id,
    required this.date_time,
    this.model,
  });

  factory BookingData.empty() {
    return const BookingData(
      id: "",
      user_name: "",
      user_phone: "",
      doc_id: "",
      clinic_id: "",
      date_time: "",
      user_email: "",
      model: null,
    );
  }

  factory BookingData.withoutModel(BookingData value) {
    return BookingData(
      id: value.id,
      user_name: value.user_name,
      user_phone: value.user_phone,
      doc_id: value.doc_id,
      clinic_id: value.clinic_id,
      date_time: value.date_time,
      user_email: value.user_email,
      model: null,
    );
  }

  BookingData copyWith({
    String? id,
    String? user_name,
    String? user_phone,
    String? user_email,
    String? doc_id,
    String? clinic_id,
    String? date_time,
    ServerResponseModel? model,
  }) {
    return BookingData(
      id: id ?? this.id,
      user_name: user_name ?? this.user_name,
      user_phone: user_phone ?? this.user_phone,
      user_email: user_email ?? this.user_email,
      doc_id: doc_id ?? this.doc_id,
      clinic_id: clinic_id ?? this.clinic_id,
      date_time: date_time ?? this.date_time,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'user_name': user_name,
      'user_phone': user_phone,
      'user_email': user_email,
      'doc_id': doc_id,
      'clinic_id': clinic_id,
      'date_time': date_time,
      'model': model,
    };
  }

  factory BookingData.fromJson(Map<String, dynamic> map) {
    return BookingData(
      id: map['_id'] as String,
      user_name: map['user_name'] as String,
      user_phone: map['user_phone'] as String,
      user_email:
          map['user_email'] != null ? map['user_email'] as String : null,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String,
      date_time: map['date_time'] as String,
      model: map['model'] as ServerResponseModel,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      user_name,
      user_phone,
      user_email,
      doc_id,
      clinic_id,
      date_time,
      // model,
    ];
  }
}
