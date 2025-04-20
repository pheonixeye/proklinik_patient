import 'package:equatable/equatable.dart';

class DoctorTag extends Equatable {
  final String name_en;
  final String name_ar;

  const DoctorTag({
    required this.name_en,
    required this.name_ar,
  });

  DoctorTag copyWith({
    String? name_en,
    String? name_ar,
  }) {
    return DoctorTag(
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name_en': name_en,
      'name_ar': name_ar,
    };
  }

  factory DoctorTag.fromJson(Map<String, dynamic> map) {
    return DoctorTag(
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name_en, name_ar];
}
