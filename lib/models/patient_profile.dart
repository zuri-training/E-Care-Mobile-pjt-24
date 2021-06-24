import 'package:flutter/material.dart';

class PatientProfile {
  final String imagePath;
  final String name;
  final String status;
  final bool isDarkMode;

  const PatientProfile({
    @required this.imagePath,
    @required this.name,
    @required this.status,
    @required this.isDarkMode,
  });
}
