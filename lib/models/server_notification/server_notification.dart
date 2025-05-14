// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

enum NotificationType {
  new_booking,
  updated_booking,
  canceled_booking,
  new_review,
  new_contact_us,
}

class ServerNotification extends Equatable {
  final NotificationType type;
  final String id;
  const ServerNotification({
    required this.type,
    required this.id,
  });

  ServerNotification copyWith({
    NotificationType? type,
    String? id,
  }) {
    return ServerNotification(
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type.name,
      'id': id,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, id];
}
