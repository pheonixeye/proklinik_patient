import 'package:equatable/equatable.dart';
import 'package:patient/constants/weekdays.dart';

class ScheduleObject extends Equatable {
  final String dayEn;
  final int weekday;
  final List<BeginEnd> beginEnd;

  const ScheduleObject({
    required this.dayEn,
    required this.weekday,
    required this.beginEnd,
  });

  ScheduleObject copyWith({
    String? dayEn,
    int? weekday,
    List<BeginEnd>? beginEnd,
  }) {
    return ScheduleObject(
      dayEn: dayEn ?? this.dayEn,
      weekday: weekday ?? this.weekday,
      beginEnd: beginEnd ?? this.beginEnd,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dayEn': dayEn,
      'weekday': weekday,
      'beginEnd': beginEnd.map((x) => x.toJson()).toList(),
    };
  }

  factory ScheduleObject.fromJson(Map<String, dynamic> map) {
    return ScheduleObject(
      dayEn: map['dayEn'] as String,
      weekday: map['weekday'] as int,
      beginEnd: List<BeginEnd>.from(
        (map['beginEnd'] as List<dynamic>).map<BeginEnd>(
          (x) => BeginEnd.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  static Map<String, ScheduleObject> initialScheduleObjectList =
      Map.fromIterable(WEEKDAYS.entries.map((e) => MapEntry(
          e.value.en,
          ScheduleObject(
            dayEn: e.value.en,
            weekday: e.key,
            beginEnd: [
              BeginEnd.empty(),
            ],
          ))));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [dayEn, weekday, beginEnd];
}

class BeginEnd extends Equatable {
  final int startHour;
  final int startMin;
  final int endHour;
  final int endMin;

  const BeginEnd({
    required this.startHour,
    required this.startMin,
    required this.endHour,
    required this.endMin,
  });

  BeginEnd copyWith({
    int? startHour,
    int? startMin,
    int? endHour,
    int? endMin,
  }) {
    return BeginEnd(
      startHour: startHour ?? this.startHour,
      startMin: startMin ?? this.startMin,
      endHour: endHour ?? this.endHour,
      endMin: endMin ?? this.endMin,
    );
  }

  factory BeginEnd.empty() {
    return const BeginEnd(
      startHour: 0,
      startMin: 0,
      endHour: 0,
      endMin: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'startHour': startHour,
      'startMin': startMin,
      'endHour': endHour,
      'endMin': endMin,
    };
  }

  factory BeginEnd.fromJson(Map<String, dynamic> map) {
    return BeginEnd(
      startHour: map['startHour'] as int,
      startMin: map['startMin'] as int,
      endHour: map['endHour'] as int,
      endMin: map['endMin'] as int,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [startHour, startMin, endHour, endMin];
}
