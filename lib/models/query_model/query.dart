import 'package:equatable/equatable.dart';
import 'package:proklinik_patient/models/filter_model.dart/filter_model.dart';
import 'package:proklinik_patient/models/sorting_model/sorting_model.dart';

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
  final String lo;
  final String lon;
  final String lat;

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
    required this.lo,
    required this.lon,
    required this.lat,
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
    String? lo,
    String? lon,
    String? lat,
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
      lo: lo ?? this.lo,
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
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
      'lo': lo,
      'lon': lon,
      'lat': lat,
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
      lo: '',
      lon: '0',
      lat: '0',
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
      lo: 'any',
      lon: '0',
      lat: '0',
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
      sort: map['so'] ?? "best_match",
      lo: map['lo'] ?? 'any',
      lon: map['lon'] ?? '0',
      lat: map['lat'] ?? '0',
    );
  }

  String get specialityFilter => "speciality_id = '$spec'";

  String get governorateFilter =>
      gov.isNotEmpty ? "&& governorate_id = '$gov'" : '';

  String get cityFilter => city.isNotEmpty ? "&& city_id = '$city'" : '';

  String get baseFilter => '$specialityFilter $governorateFilter $cityFilter';

  int get pageNumber => int.parse(page);

  String get availabilityFilter {
    final _today = DateTime.now();
    final String _searchIndex = switch (availability) {
      'today' => '${_today.weekday - 1}', //(index = intday-1)
      'tommorow' => _today.weekday == 7 ? '0' : '${_today.weekday}',
      _ => '',
    };

    final _availableToday = '&& schedule.$_searchIndex.available = true';
    final _availableTommorow = '&& schedule.$_searchIndex.available = true';

    return switch (AvailabilityFilterEnum.fromString(availability)) {
      AvailabilityFilterEnum.today => _availableToday,
      AvailabilityFilterEnum.tommorow => _availableTommorow,
      _ => '',
    };
  }

  String get degreeFilter => switch (degree) {
        'any' || '' => '',
        _ => "&& doc_id.degree_id = '$degree'",
      };

  String get distanceFilter => switch (lo) {
        'any' || '' => '',
        _ => "&& geoDistance(location.lon, location.lat, $lon, $lat) <= '$lo'",
      };

  String get sortingQuery => switch (SortingModelEnum.fromString(sort)) {
        SortingModelEnum.bestMatch => '-created',
        SortingModelEnum.waitingTime =>
          '+clinic_waiting_time_via_clinic_id.waiting_time',
        SortingModelEnum.topRated =>
          '-doc_id.doctor_website_info_via_doc_id.average_rating',
        SortingModelEnum.any => '-created',
      };

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
      lo,
      lon,
      lat,
    ];
  }
}
