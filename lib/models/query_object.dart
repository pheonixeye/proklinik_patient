// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class QueryObject extends Equatable {
  final String type;
  final String spec;
  final String gov;
  final String city;
  final String page;
  final String availability;
  final String fees;
  final String location;
  final String sort;

  const QueryObject({
    required this.type,
    required this.spec,
    required this.gov,
    required this.city,
    required this.page,
    required this.availability,
    required this.fees,
    required this.location,
    required this.sort,
  });

  QueryObject copyWith({
    String? type,
    String? spec,
    String? gov,
    String? city,
    String? page,
    String? availability,
    String? fees,
    String? location,
    String? sort,
  }) {
    return QueryObject(
      type: type ?? this.type,
      spec: spec ?? this.spec,
      gov: gov ?? this.gov,
      city: city ?? this.city,
      page: page ?? this.page,
      availability: availability ?? this.availability,
      fees: fees ?? this.fees,
      location: location ?? this.location,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'spec': spec,
      'gov': gov,
      'city': city,
      'page': page,
      'av': availability,
      'fe': fees,
      'lo': location,
      'so': sort,
    };
  }

  // ignore: non_constant_identifier_names
  factory QueryObject.empty() {
    return const QueryObject(
      type: '',
      spec: '',
      gov: '',
      city: '',
      page: '',
      availability: '',
      fees: '',
      location: '',
      sort: '',
    );
  }

  factory QueryObject.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return QueryObject.empty();
    }
    return QueryObject(
      type: map['type'] as String,
      spec: map['spec'] as String,
      gov: map['gov'] as String,
      city: map['city'] as String,
      page: map['page'] as String,
      availability: map['av'] as String,
      fees: map['fe'] as String,
      location: map['lo'] as String,
      sort: map['so'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      type,
      spec,
      gov,
      city,
      page,
    ];
  }
}
