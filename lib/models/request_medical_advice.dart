import 'package:flutter/material.dart';

class RequestMedicalAdvice {
  final String illness;
  final String doctorsName;
  final String date;


  RequestMedicalAdvice(
      {@required this.illness,
        @required this.doctorsName,
        @required this.date,
      });

  factory RequestMedicalAdvice.fromJson(Map<String, dynamic> json) {
    return RequestMedicalAdvice(
      illness: json['illness'],
      date: json['date'],
      doctorsName: json['doctorsName'],
    );
  }
}
