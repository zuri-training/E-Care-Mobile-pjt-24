import 'dart:convert';
import 'package:e_care_mobile/models/patient.dart';
import 'package:http/http.dart' as http;

//api link
var url = 'https://harvest-rigorous-bambiraptor.glitch.me/';

Future<Patient> registerPatient(
  //these are the user registration fields
  String userId,
  String patientName,
  String email,
  String profileImage,
  String dateofBirth,
  String password,
) async {
  //make a post request, basically trying to send the values to the server
  final response = await http.post(
    Uri.parse(
      '{$url}/api/v1/patient/create',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'userId': userId,
        'patientName': patientName,
        'email': email,
        'profileImage': profileImage,
        'dateofBirth': dateofBirth,
        'password': password,
      },
    ),
  );
  if (response.statusCode == 201) {
    return Patient.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Patient');
  }
}
