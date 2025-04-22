// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:equatable/equatable.dart';

class SortingModel extends Equatable {
  static const String best_match = 'best_match';
  static const String waiting_time = 'waiting_time';
  static const String top_rated = 'top_rated';

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
      value: SortingModel.best_match,
    );
  }

  factory SortingModel.waitingTime() {
    return const SortingModel(
      id: "4",
      en: "Waiting Time",
      ar: "اقل وقت انتظار",
      value: SortingModel.waiting_time,
    );
  }

  factory SortingModel.topRated() {
    return const SortingModel(
      id: "5",
      en: "Top Rated",
      ar: "اعلي التقييمات",
      value: SortingModel.top_rated,
    );
  }
}

List<SortingModel> sortingParameters = [
  SortingModel.bestMatch(),
  SortingModel.waitingTime(),
  SortingModel.topRated(),
];

enum SortingModelEnum {
  bestMatch(SortingModel.best_match),
  waitingTime(SortingModel.waiting_time),
  topRated(SortingModel.top_rated),
  any(SortingModel.best_match);

  final String value;
  const SortingModelEnum(this.value);

  factory SortingModelEnum.fromString(String value) {
    return switch (value) {
      SortingModel.best_match => SortingModelEnum.bestMatch,
      SortingModel.waiting_time => SortingModelEnum.waitingTime,
      SortingModel.top_rated => SortingModelEnum.topRated,
      _ => SortingModelEnum.any,
    };
  }
}
