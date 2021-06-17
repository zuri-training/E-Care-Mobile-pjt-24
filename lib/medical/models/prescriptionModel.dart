import 'package:flutter/cupertino.dart';

class DoctorsFeedback {
  String patientName;
  String prescription;
  String dosage;
  String doctorsAdvice;

  DoctorsFeedback(
      {@required this.patientName,
      @required this.prescription,
      @required this.dosage,
      @required this.doctorsAdvice});
}
