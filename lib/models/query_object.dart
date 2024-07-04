import 'package:equatable/equatable.dart';

class QueryObject extends Equatable {
  final String type;
  final String spec;
  final String gov;
  final String city;
  final String page;

  const QueryObject({
    required this.type,
    required this.spec,
    required this.gov,
    required this.city,
    required this.page,
  });

  QueryObject copyWith({
    String? type,
    String? spec,
    String? gov,
    String? city,
    String? page,
  }) {
    return QueryObject(
      type: type ?? this.type,
      spec: spec ?? this.spec,
      gov: gov ?? this.gov,
      city: city ?? this.city,
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'spec': spec,
      'gov': gov,
      'city': city,
      'page': page,
    };
  }

  factory QueryObject._Empty() {
    return const QueryObject(
      type: '',
      spec: '',
      gov: '',
      city: '',
      page: '',
    );
  }

  factory QueryObject.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return QueryObject._Empty();
    }
    return QueryObject(
      type: map['type'] as String,
      spec: map['spec'] as String,
      gov: map['gov'] as String,
      city: map['city'] as String,
      page: map['page'] as String,
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
