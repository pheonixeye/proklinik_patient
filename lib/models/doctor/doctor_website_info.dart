import 'package:equatable/equatable.dart';
import 'package:proklinik_patient/models/doctor/doctor_tag.dart';

class DoctorWebsiteInfo extends Equatable {
  final String id;
  final String doc_id;
  final int views_count;
  final double average_rating;
  final int reviews_count;
  final List<DoctorTag> tags;

  const DoctorWebsiteInfo({
    required this.id,
    required this.doc_id,
    required this.views_count,
    required this.average_rating,
    required this.reviews_count,
    required this.tags,
  });

  DoctorWebsiteInfo copyWith({
    String? id,
    String? doc_id,
    int? views_count,
    double? average_rating,
    int? reviews_count,
    List<DoctorTag>? tags,
  }) {
    return DoctorWebsiteInfo(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      views_count: views_count ?? this.views_count,
      average_rating: average_rating ?? this.average_rating,
      reviews_count: reviews_count ?? this.reviews_count,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'views_count': views_count,
      'average_rating': average_rating,
      'reviews_count': reviews_count,
      'tags': tags.map((e) => e.toJson()).toList(),
    };
  }

  factory DoctorWebsiteInfo.fromJson(Map<String, dynamic> map) {
    return DoctorWebsiteInfo(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      views_count: map['views_count'] as int,
      average_rating: map['average_rating'] as double,
      reviews_count: map['reviews_count'] as int,
      tags: (map['tags'] as List<dynamic>)
          .map((e) => DoctorTag.fromJson(e))
          .toList(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      views_count,
      average_rating,
      reviews_count,
      tags,
    ];
  }
}
