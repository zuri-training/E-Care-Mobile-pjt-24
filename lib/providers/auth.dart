import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/services/api.dart';
import 'package:e_care_mobile/util/AppException.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/api_service.dart';
import 'package:e_care_mobile/util/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
  Error,
  Initial,
  Loading,
  Completed,
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  Status _verifiedStatus = Status.Initial;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  Status get verifiedStatus => _verifiedStatus;

  Status _state = Status.Initial;

  Status get state => _state;

  void setState(Status state) {
    _state = state;
    notifyListeners();
  }

  var dio = Dio();
  var authService = AuthService();

  /*Future<dynamic> login(String email, String password) async {

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var responseJson;

    try {
      Map data = {
        "email": email,
        "password": password,
      };
      var response = await http.post(Uri.parse('https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/login')
          , body: data);
      //return response?.data;
      responseJson = _returnResponse(response, 'login');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
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

  dynamic _returnResponse(http.Response response, String req) {
    var result;
    switch (response.statusCode) {
      case 200:
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
        var responseJson = json.decode(response.body.toString());
        var userData = responseJson['data'];
        // store user data in user object
        User authUser = User.fromJson(userData);
        // save using shared prefs
        UserPreferences().saveUser(authUser);

        if (req == 'login') {
          _loggedInStatus = Status.LoggedIn;
          notifyListeners();
        } else {
          _registeredInStatus = Status.Registered;
          notifyListeners();
        }


        print(responseJson);
        result = {'status': true, 'message': 'Successful', 'user': authUser};
        return result;
      case 400:
        //_loggedInStatus = Status.NotLoggedIn;
        if (req == 'login') {
          _loggedInStatus = Status.NotLoggedIn;
        } else {
          _registeredInStatus = Status.NotRegistered;
        }
        notifyListeners();
        throw BadRequestException(response.body.toString());

      case 401:
      case 403:
        //_loggedInStatus = Status.NotLoggedIn;
        if (req == 'login') {
          _loggedInStatus = Status.NotLoggedIn;
        } else {
          _registeredInStatus = Status.NotRegistered;
        }
        notifyListeners();
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        //_loggedInStatus = Status.NotLoggedIn;
      if (req == 'login') {
        _loggedInStatus = Status.NotLoggedIn;
      } else {
        _registeredInStatus = Status.NotRegistered;
      }
        notifyListeners();
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }


  Future<dynamic> register(String email, String password, String firstname,
      String lastname, String dob) async {

    _registeredInStatus = Status.Registering;
    notifyListeners();

    var responseJson;
    try {
      Map data = {
        'email': email,
        'password': password,
        'firstname': firstname,
        'lastname': lastname,
        'dob': dob,
      };
      var response = await http.post(Uri.parse('https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/register')
          , body: data);
      // TODO Implement _returnResponse for register
      responseJson = _returnResponse(response, 'register');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }*/

  AppException _failure;

  AppException get failure => _failure;

  void _setFailure(AppException failure) {
    _failure = failure;
    notifyListeners();
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    var result;
    //_loggedInStatus = Status.Authenticating;
    _state = Status.Loading;
    notifyListeners();
    try {
      var response = await authService.login(email, password);

      var token = response['data']['token'];

      print('auth.dart:  $token');
      User user = UserProvider().user;
      var dd = user.email;
      print('user $user');
      print('user email: $dd');

      Map<String, dynamic> userData = {
        'patientId': user.patientId,
        'firstname': user.firstname,
        'surname': user.surname,
        'email': user.email,
        'dob': user.dob,
        'token': token
      };

      // store user data in user object
      User authUser = User.fromJson(userData);
      // save using shared prefs
      //UserPreferences().saveUser(authUser);
      //_loggedInStatus = Status.LoggedIn;
      _state = Status.Completed;
      notifyListeners();
      //print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': authUser};
      return result;
    } on AppException catch (e) {
      _setFailure(e);
      print(e);
      //_loggedInStatus = Status.Error;
      _state = Status.Error;
      notifyListeners();
      result = {
        'status': false,
        'message': 'Registration failed',
        //'data': responseData
      };
    }

    //return result;
  }

  Future<Map<String, dynamic>> signUp(String email, String password,
      String firstname, String surname, String dob) async {
    var result;
    _registeredInStatus = Status.Registering;
    notifyListeners();
    try {
      print('im here');
      var response =
          await authService.register(email, password, firstname, surname, dob);
      //var responseJson = json.decode(response['data']);
      //print('auth.dart json:  $responseJson');

      var patientId = response['data'];

      print('auth.dart:  $patientId');

      Map<String, dynamic> userData = {
        'patientId': patientId.toString(),
        'firstname': firstname,
        'surname': surname,
        'email': email,
        'dob': dob,
      };

      // store user data in user object
      User authUser = User.fromJson(userData);
      print(authUser.token);
      // save using shared prefs
      //print('auth user $authUser');
      //]UserPreferences().saveUser(authUser);

      _registeredInStatus = Status.Registered;
      notifyListeners();
      print('registerstatus: $_registeredInStatus');
      result = {
        'status': true,
        'message': 'Successfully registered',
        'user': authUser
      };
      return result;
    } on AppException catch (e) {
      _setFailure(e);
      print(e);
      result = {
        'status': false,
        'message': 'Registration failed',
        //'data': responseData
      };
      _registeredInStatus = Status.Error;
      notifyListeners();
    }

    return result;
  }

  Future<Map<String, dynamic>> activate(String otp) async {
    var result;
    _verifiedStatus = Status.Loading;
    notifyListeners();
    try {
      print('im here');
      var response = await authService.activateUser(otp);
      //var responseJson = json.decode(response['data']);
      //print('auth.dart json:  $responseJson');

      var token = response['data'];

      print('auth.dart:  $token');
      User user = UserProvider().user;
      var dd = user.email;
      print('user $user');
      print('user email: $dd');

      Map<String, dynamic> userData = {
        'patientId': user.patientId.toString(),
        'firstname': user.firstname,
        'surname': user.surname,
        'email': user.email,
        'dob': user.dob,
        'token': token.toString()
      };

      // store user data in user object
      User authUser = User.fromJson(userData);
      print(authUser.firstname);
      print(authUser.token);

      // save using shared prefs
      //UserPreferences().saveUser(authUser);

      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString("token", token);
      //print(UserPreferences().getUser());

      _verifiedStatus = Status.Completed;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successfully verified',
        'user': authUser
      };
      return result;
    } on AppException catch (e) {
      _setFailure(e);
      print(e);
      result = {
        'status': false,
        'message': 'Registration failed',
        //'data': responseData
      };
      _registeredInStatus = Status.Error;
      notifyListeners();
    }

    return result;
  }
}
