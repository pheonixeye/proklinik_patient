import 'package:equatable/equatable.dart';

class Query extends Equatable {
  final String type;
  final String spec;
  final String gov;
  final String city;
  final String page;
  final String availability;
  final String fees;
  final String degree;
  final String sort;

  const Query({
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

  Query copyWith({
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
    return Query(
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
  factory Query.empty() {
    return const Query(
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

  factory Query.nonFiltered({required String spec}) {
    return Query(
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

  factory Query.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return Query.empty();
    }
    return Query(
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

  String get specialityQuery => "speciality_id = '$spec'";

  String get governorateQuery =>
      gov.isNotEmpty ? "&& governorate_id = '$gov'" : '';

  String get cityQuery => city.isNotEmpty ? "&& city_id = '$city'" : '';

  String get baseQueryFilter => '$specialityQuery $governorateQuery $cityQuery';

  int get pageNumber => int.parse(page);

  String get availabilityQuery {
    final _today = DateTime.now();
    final _availableToday =
        '&& schedule.available = true && schedule.intday = ${_today.weekday}';
    final _availableTommorow =
        '&& schedule.available = true && schedule.intday = ${_today.weekday == 7 ? 1 : _today.weekday + 1}';
    return switch (availability) {
      'today' => _availableToday,
      'tomorrow' => _availableTommorow,
      _ => '',
    };
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
}
