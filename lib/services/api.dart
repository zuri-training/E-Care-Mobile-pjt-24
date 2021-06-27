import 'dart:async';

import 'package:dio/dio.dart';
import 'package:e_care_mobile/screens/login.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_care_mobile/models/signup_model.dart';
import 'dart:convert';
import '../util/api_service.dart';

// Creates a new patient user
class AuthService {
  var _dataStream;
  var dio = Dio();

  Future<SignUpModel> createUser(String firstname, String lastname,
      String email, String dob, String password) async {
    //var url = WEATHER_API_URL + location;
    final request =
        await http.MultipartRequest('POST', Uri.parse(ApiUrl.register));
    request.fields.addAll({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'dob': dob,
      'password': password
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      _dataStream =
          SignUpModel.fromJson(jsonDecode(response.stream.toString()));
      return SignUpModel.fromJson(jsonDecode(response.stream.toString()));
    } else {
      print(response.reasonPhrase);
    }
  }

  createUsers(String firstname, String lastname, String email, String dob,
      String password) async {
    /*final request = http.MultipartRequest(
        'POST', Uri.parse(ApiUrl.register));
    request.fields.addAll({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'dob': dob,
      'password': password,
    });
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));



    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return SignUpModel.fromJson(jsonDecode(response.stream.toString()));
    } else {
      print(response.reasonPhrase);
    }*/
  }

  /*handleAuthStr() {
    return StreamBuilder<SignUpModel>(
      stream: _dataStream,
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          print('snapshot.hasData');
          return PatientDashboard();
        } else if (snapshot.hasError) {
          print('error');
          //return Text('${snapshot.error}');
        } else {
          return Login();
        }

        return CircularProgressIndicator();
      },
    );
  }*/

  // Create user
  Future<dynamic> signUp(String email, String password, String firstname,
      String lastname, String dob) async {
    var dios = Dio();
    try {
      var formData = FormData.fromMap({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'dob': dob,
        'password': password,
        //'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      var response = await dios.post(
          'https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/create',
          data: formData);
      //print('api: $response');
      return response?.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        //print(e.response.headers);
        //print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        //print(e.request);
        print(e.message);
      }
    }
  }

  /*dio.options.connectTimeout = 50000;
  dio.options.receiveTimeout = 30000;
  dio.options.sendTimeout = 30000;*/
  // user login
  Future<dynamic> login(String email, String password) async {
    try {
      var response = await dio.post(
          'https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/login',
          data: {
            'email': email,
            'password': password,
          });
      return response?.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        //print(e.response.headers);
        //print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        //print(e.request);
        print(e.message);
      }
    }
    /*Map data = {
      'email': email,
      'password': password
    };
    var response = await http.post(
      Uri.parse(ApiUrl.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return json.decode(response?.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }*/
  }

  // Activate user
  Future<dynamic> activateUser(otp) async {
    try {
      var response = await dio.post(
          'https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/activate-patient-account/$otp',
          data: null);
      print('api: $response');
      return response?.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        //print(e.response.headers);
        //print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        //print(e.request);
        print(e.message);
      }
    }
  }

  // forgot password
  Future<dynamic> forgotPassword(String email) async {
    String url = ApiUrl.forgotPassword + '/$email';
    try {
      var response = await dio.post(url, data: null);
      return response?.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        //print(e.response.headers);
        //print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        //print(e.request);
        print(e.message);
      }
    }
  }

  // forgot password
  Future<dynamic> resetPassword(String token, String newPassword) async {
    try {
      var response = await dio.post(ApiUrl.resetPassword,
          data: {'token': token, 'newPassword': newPassword});
      return response?.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        //print(e.response.headers);
        //print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        //print(e.request);
        print(e.message);
      }
    }
  }
}
