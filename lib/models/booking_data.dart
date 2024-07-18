// ignore_for_file:  non_constant_identifier_names, constant_identifier_names

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
  final Status? status;

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
    this.status,
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
      status: Status.attended,
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
      status: value.status,
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
    Status? status,
    int? day,
    int? month,
    int? year,
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
      type: type ?? this.type,
      attended: attended ?? this.attended,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      status: status ?? this.status,
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
      'status': status?.value,
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
      'status': status?.value,
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
      model: map['model'] == null
          ? null
          : ServerResponseModel.fromJson(map['model']) as ServerResponseModel?,
      type: map['type'] as String?,
      attended: map['attended'] as bool,
      year: map['year'] as int,
      month: map['month'] as int,
      day: map['day'] as int,
      status: Status.fromString(map['status'] as String?),
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
      status: Status.fromString(map['status'] as String?),
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
      status,
    ];
  }

  //#visit update url(/visit_id)
  String get visitUpdateUrl => 'visit/$month/$year/$id';
  //#review sumbission update url(/doc_id/clinic_id/visit_id)
  String get reviewSubmissionUrl =>
      'review/$month/$year/$doc_id/$clinic_id/$id';
}

enum Status {
  unknown('unknown'),
  attended('attended'),
  not_attended('not-attended'),
  cancel_by_doctor('cancel-by-doctor'),
  cancel_by_patient('cancel-by-patient');

  final String value;

  const Status(this.value);

  static Status fromString(String? value) {
    return switch (value) {
      'unknown' => Status.unknown,
      'attended' => Status.attended,
      'not-attended' => Status.not_attended,
      'cancel-by-doctor' => Status.cancel_by_doctor,
      'cancel-by-patient' => Status.cancel_by_patient,
      _ => Status.unknown,
    };
  }
}
