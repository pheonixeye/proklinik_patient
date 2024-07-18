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
  final String degree;
  final String sort;

  const QueryObject({
    required this.type,
    required this.spec,
    required this.gov,
    required this.city,
    required this.page,
    required this.availability,
    required this.fees,
    required this.degree,
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
    String? degree,
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
      degree: degree ?? this.degree,
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
      'deg': degree,
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
      page: '1',
      availability: '',
      fees: '',
      degree: '',
      sort: '',
    );
  }

  factory QueryObject.nonFiltered({required String spec}) {
    return QueryObject(
      type: 'clinic',
      spec: spec,
      gov: '',
      city: '',
      page: '1',
      availability: 'any',
      fees: 'any',
      degree: 'any',
      sort: 'best-match',
    );
  }

  factory QueryObject.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return QueryObject.empty();
    }
    return QueryObject(
      type: map['type'] as String,
      spec: map['spec'] as String,
      gov: map['gov'] ?? "",
      city: map['city'] ?? "",
      page: map['page'] ?? "1",
      availability: map['av'] ?? "any",
      fees: map['fe'] ?? "any",
      degree: map['deg'] ?? "any",
      sort: map['so'] ?? "best-match",
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
      availability,
      fees,
      degree,
      sort,
    ];
  }

  ({String filter, String sort}) toPocketbaseQuery() {
    //TODO: finish implementation
    final filterBuffer = StringBuffer();
    final sortingBuffer = StringBuffer();

    //#spec
    filterBuffer.write("speciality_en = '$spec'");
    //#gov
    if (gov.isNotEmpty) {
      filterBuffer.write(" && ");
      filterBuffer.write("destinations ~ '$gov'");
    }
    //#area
    if (city.isNotEmpty) {
      filterBuffer.write(" && ");
      filterBuffer.write("destinations ~ '$city'");
    }

    //#degree
    if (degree == "any") {
    } else if (degree == "Specialist") {
      filterBuffer.write(" && ");
      filterBuffer.write("degree_en = 'Specialist'");
    } else if (degree == "Consultant") {
      filterBuffer.write(" && ");
      filterBuffer.write("degree_en = 'Consultant'");
    }

    //#sorting(best-match / top-rated)
    if (sort == 'best-match') {
    } else if (sort == 'top-rated') {
      sortingBuffer.write("+rating");
    }
    return (
      filter: filterBuffer.toString(),
      sort: sortingBuffer.toString(),
    );
  }
}
