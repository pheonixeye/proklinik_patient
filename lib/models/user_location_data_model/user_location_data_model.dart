import 'package:equatable/equatable.dart';

class UserLocationDataModel extends Equatable {
  final String lon;
  final String lat;
  final String lo;
  const UserLocationDataModel({
    required this.lon,
    required this.lat,
    required this.lo,
  });

  UserLocationDataModel copyWith({
    String? lon,
    String? lat,
    String? lo,
  }) {
    return UserLocationDataModel(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
      lo: lo ?? this.lo,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lon': lon,
      'lat': lat,
      'lo': lo,
    };
  }

  factory UserLocationDataModel.fromJson(Map<String, dynamic> map) {
    return UserLocationDataModel(
      lon: map['lon'] as String,
      lat: map['lat'] as String,
      lo: map['lo'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [lon, lat, lo];
}
