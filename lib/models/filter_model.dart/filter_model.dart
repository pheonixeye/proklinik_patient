// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  final String name_en;
  final String name_ar;
  final String value;

  const FilterModel({
    required this.name_en,
    required this.name_ar,
    required this.value,
  });

  @override
  List<Object?> get props => [
        name_en,
        name_ar,
        value,
      ];

  //degree filter
  factory FilterModel.degreeAny() {
    return const FilterModel(
      name_en: 'Any',
      name_ar: 'الكل',
      value: '',
    );
  }
  factory FilterModel.degreeSpecialist() {
    return const FilterModel(
      name_en: 'Specialist',
      name_ar: 'اخصائى',
      value: 'Specialist',
    );
  }
  factory FilterModel.degreeConsultant() {
    return const FilterModel(
      name_en: 'Consultant',
      name_ar: 'استشارى',
      value: 'Consultant',
    );
  }
  //availability filter
  factory FilterModel.availabilityAny() {
    return const FilterModel(
      name_en: 'Any',
      name_ar: 'اى تاريخ',
      value: 'any',
    );
  }
  factory FilterModel.availabilityToday() {
    return const FilterModel(
      name_en: 'Today',
      name_ar: 'اليوم',
      value: 'today',
    );
  }
  factory FilterModel.availabilityTomorrow() {
    return const FilterModel(
      name_en: 'Tommorow',
      name_ar: 'غدا',
      value: 'tommorow',
    );
  }
  //location filter
  factory FilterModel.locationAny() {
    return const FilterModel(
      name_en: 'Any',
      name_ar: 'كل المسافات',
      value: 'any',
    );
  }
  factory FilterModel.locationWithinOne() {
    return const FilterModel(
      name_en: 'Within 1 Km',
      name_ar: 'مسافة واحد كيلو',
      value: '1',
    );
  }
  factory FilterModel.locationWithinThree() {
    return const FilterModel(
      name_en: 'Within 3 Km',
      name_ar: 'مسافة ثلاثة كيلو',
      value: '3',
    );
  }
  factory FilterModel.locationWithinFive() {
    return const FilterModel(
      name_en: 'Within 5 Km',
      name_ar: 'مسافة خمسة كيلو',
      value: '5',
    );
  }

  static final List<FilterModel> degreeFilterItems = [
    FilterModel.degreeAny(),
    FilterModel.degreeSpecialist(),
    FilterModel.degreeConsultant(),
  ];

  static final List<FilterModel> availabilityFilterItems = [
    FilterModel.availabilityAny(),
    FilterModel.availabilityToday(),
    FilterModel.availabilityTomorrow(),
  ];

  static final List<FilterModel> distanceFilterItems = [
    FilterModel.locationAny(),
    FilterModel.locationWithinOne(),
    FilterModel.locationWithinThree(),
    FilterModel.locationWithinFive(),
  ];
}

enum AvailabilityFilterEnum {
  any('any'),
  today('today'),
  tommorow('tommorow');

  final String value;

  const AvailabilityFilterEnum(this.value);

  factory AvailabilityFilterEnum.fromString(String value) {
    return switch (value) {
      'today' => today,
      'tommorow' => tommorow,
      _ => any,
    };
  }
}
