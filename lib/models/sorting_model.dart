// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SortingModel extends Equatable {
  final String id;
  final String en;
  final String ar;
  final String value;
  const SortingModel({
    required this.id,
    required this.en,
    required this.ar,
    required this.value,
  });

  @override
  List<Object?> get props => [id, en, ar, value];

  factory SortingModel.bestMatch() {
    return const SortingModel(
      id: "1",
      en: "Best Match",
      ar: "الاكثر تطابقا",
      value: "best-match",
    );
  }

  factory SortingModel.priceLowToHigh() {
    return const SortingModel(
      id: "2",
      en: "Price : Low To High",
      ar: "الاقل سعرا",
      value: "low-high",
    );
  }

  factory SortingModel.priceHighToLow() {
    return const SortingModel(
      id: "3",
      en: "Price : High To Low",
      ar: "الاكثر سعرا",
      value: "high-low",
    );
  }

  factory SortingModel.waitingTime() {
    return const SortingModel(
      id: "4",
      en: "Waiting Time",
      ar: "اقل وقت انتظار",
      value: "waiting-time",
    );
  }

  factory SortingModel.topRated() {
    return const SortingModel(
      id: "5",
      en: "Top Rated",
      ar: "اعلي التقييمات",
      value: "top-rated",
    );
  }
}

List<SortingModel> sortingParameters = [
  SortingModel.bestMatch(),
  SortingModel.priceLowToHigh(),
  SortingModel.priceHighToLow(),
  SortingModel.waitingTime(),
  SortingModel.topRated(),
];

enum SortingModelEnum {
  priceHighToLow('high-low'),
  priceLowToHigh('low-high'),
  waitingTime('waiting-time'),
  empty('');

  final String value;
  const SortingModelEnum(this.value);

  factory SortingModelEnum.fromString(String value) {
    return switch (value) {
      'high-low' => SortingModelEnum.priceHighToLow,
      'low-high' => SortingModelEnum.priceLowToHigh,
      'waiting-time' => SortingModelEnum.waitingTime,
      _ => SortingModelEnum.empty,
    };
  }
}
