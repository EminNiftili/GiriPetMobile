import 'dart:ffi';

class User {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;

  const User(
      {required int this.id,
      required String this.fullName,
      required String this.email,
      required String this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }
}
