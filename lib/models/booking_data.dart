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
  final bool attended;
  final String? type;
  final int year;
  final int month;
  final int day;

  const BookingData({
    required this.id,
    required this.user_name,
    required this.user_phone,
    this.user_email,
    required this.doc_id,
    required this.clinic_id,
    required this.date_time,
    this.model,
    this.type,
    required this.attended,
    required this.year,
    required this.month,
    required this.day,
  });

  factory BookingData.empty() {
    return BookingData(
      id: "",
      user_name: "",
      user_phone: "",
      doc_id: "",
      clinic_id: "",
      date_time: "",
      user_email: "",
      model: null,
      type: '',
      attended: true,
      year: DateTime.now().year,
      month: DateTime.now().month,
      day: DateTime.now().day,
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
      type: '',
      attended: true,
      year: DateTime.now().year,
      month: DateTime.now().month,
      day: DateTime.now().day,
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
    String? type,
    bool? attended,
  }) {
    final now = DateTime.now();
    // ignore: no_leading_underscores_for_local_identifiers
    final _d = DateTime.tryParse(this.date_time) ??
        DateTime(now.year, now.month, now.day);
    return BookingData(
      id: id ?? this.id,
      user_name: user_name ?? this.user_name,
      user_phone: user_phone ?? this.user_phone,
      user_email: user_email ?? this.user_email,
      doc_id: doc_id ?? this.doc_id,
      clinic_id: clinic_id ?? this.clinic_id,
      date_time: date_time ?? this.date_time,
      model: model ?? this.model,
      type: type ?? this.type,
      attended: attended ?? this.attended,
      year: _d.year,
      month: _d.month,
      day: _d.day,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_name': user_name,
      'user_phone': user_phone,
      'user_email': user_email,
      'doc_id': doc_id,
      'clinic_id': clinic_id,
      'date_time': date_time,
      'model': model,
      'type': type,
      "attended": attended,
      'year': year,
      'month': month,
      'day': day,
    };
  }

  Map<String, dynamic> toPocketbaseJson() {
    return <String, dynamic>{
      'user_name': user_name,
      'user_phone': user_phone,
      'user_email': user_email,
      'doc_id': doc_id,
      'clinic_id': clinic_id,
      'date_time': date_time,
      'type': type,
      "attended": attended,
      'year': year,
      'month': month,
      'day': day,
    };
  }

  factory BookingData.fromJson(Map<String, dynamic> map) {
    return BookingData(
      id: map['id'] as String,
      user_name: map['user_name'] as String,
      user_phone: map['user_phone'] as String,
      user_email:
          map['user_email'] != null ? map['user_email'] as String : null,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String,
      date_time: map['date_time'] as String,
      model: ServerResponseModel.fromJson(map['model']) as ServerResponseModel?,
      type: map['type'] as String?,
      attended: map['attended'] as bool,
      year: map['year'] as int,
      month: map['month'] as int,
      day: map['day'] as int,
    );
  }

  factory BookingData.fromPocketbaseJson(
    Map<String, dynamic> map,
    ServerResponseModel? model,
  ) {
    return BookingData(
      id: map['id'] as String,
      user_name: map['user_name'] as String,
      user_phone: map['user_phone'] as String,
      user_email:
          map['user_email'] != null ? map['user_email'] as String : null,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String,
      date_time: map['date_time'] as String,
      model: model,
      type: map['type'] as String?,
      attended: map['attended'] as bool,
      year: map['year'] as int,
      month: map['month'] as int,
      day: map['day'] as int,
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
      attended,
      type,
      year,
      month,
      day,
    ];
  }
}
