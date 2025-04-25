import 'package:equatable/equatable.dart';

class ContactUsModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String message;

  const ContactUsModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  ContactUsModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? message,
  }) {
    return ContactUsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
    };
  }

  factory ContactUsModel.fromJson(Map<String, dynamic> map) {
    return ContactUsModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      message: map['message'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, phone, message];
}
