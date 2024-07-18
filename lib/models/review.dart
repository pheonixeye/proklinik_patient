// ignore_for_file:  non_constant_identifier_names

import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages

class Review extends Equatable {
  //todo: add doc_rel
  //todo: add clinic_rel
  final String id;
  final String doc_id;
  final String user_name;
  final String body;
  final String date_time;
  final int waiting_time;
  final String doc_rel;
  final String clinic_rel;
  final String? visit_id;
  final int stars;
  const Review({
    required this.id,
    required this.doc_id,
    required this.user_name,
    required this.body,
    required this.date_time,
    required this.waiting_time,
    required this.stars,
    required this.doc_rel,
    required this.clinic_rel,
    this.visit_id,
  });

  Review copyWith({
    String? id,
    String? doc_id,
    String? user_name,
    String? body,
    String? date_time,
    int? waiting_time,
    int? stars,
    String? doc_rel,
    String? clinic_rel,
    String? visit_id,
  }) {
    return Review(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      user_name: user_name ?? this.user_name,
      body: body ?? this.body,
      date_time: date_time ?? this.date_time,
      waiting_time: waiting_time ?? this.waiting_time,
      stars: stars ?? this.stars,
      doc_rel: doc_rel ?? this.doc_rel,
      clinic_rel: clinic_rel ?? this.clinic_rel,
      visit_id: visit_id ?? this.visit_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'user_name': user_name,
      'body': body,
      'date_time': date_time,
      'waiting_time': waiting_time,
      'stars': stars,
      'doc_rel': doc_rel,
      'clinic_rel': clinic_rel,
      'visit_id': visit_id,
    };
  }

  factory Review.initial() {
    return const Review(
      id: '',
      doc_id: '',
      user_name: '',
      body: '',
      date_time: '',
      waiting_time: 0,
      stars: 0,
      doc_rel: '',
      clinic_rel: '',
      visit_id: '',
    );
  }

  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      user_name: map['user_name'] as String,
      body: map['body'] as String,
      date_time: map['date_time'] as String,
      waiting_time: map['waiting_time'] as int,
      stars: map['stars'] as int,
      doc_rel: map['doc_rel'] as String,
      clinic_rel: map['clinic_rel'] as String,
      visit_id: map['visit_id'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      user_name,
      body,
      date_time,
      waiting_time,
      stars,
      doc_rel,
      clinic_rel,
      visit_id,
    ];
  }
}
