import 'package:flutter/material.dart';

class Patient {
  final String userId;
  final String profileImage;
  final String email;
  final String patientName;
  final String dateofBirth;
  final String password;

  Patient(
      {@required this.userId,
      this.profileImage,
      @required this.email,
      @required this.patientName,
      @required this.dateofBirth,
      @required this.password});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      userId: json['userId'],
      profileImage: json['profileImage'],
      email: json['email'],
      patientName: json['patientName'],
      dateofBirth: json['dateofBirth'],
      password: json['password'],
    );
  }
}
