import 'package:flutter/material.dart';

class BookAppointment {
  final String time;
  final String date;
  final String doctor;
  final String reasonForAppointment;

  BookAppointment(
      {@required this.time,
        @required this.date,
        @required this.doctor,
        @required this.reasonForAppointment,
   });

  factory BookAppointment.fromJson(Map<String, dynamic> json) {
    return BookAppointment(
      time: json['time'],
      date: json['date'],
      doctor: json['doctor'],
      reasonForAppointment: json['reasonForAppointment'],
    );
  }
}
