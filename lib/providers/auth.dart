import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:e_care_mobile/Authentication/authentication.dart';
import 'package:e_care_mobile/Authentication/error_handler.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/services/api.dart';
import 'package:e_care_mobile/util/AppException.dart';
import 'package:firebase_auth/firebase_auth.dart' as users;

import 'package:flutter/material.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/shared_preference.dart';
import 'package:image_picker/image_picker.dart';
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
  Status _passwordStatus = Status.Initial;
  Status _resetPasswordStatus = Status.Initial;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  Status get verifiedStatus => _verifiedStatus;

  Status get passwordStatus => _passwordStatus;

  Status get resetPasswordStatus => _resetPasswordStatus;

  /*Status _state = Status.Initial;

  Status get state => _state;

  void _setState(Status state) {
    _state = state;
    notifyListeners();
  }*/

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

  /// Login
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    var result;
    // Set login status to authenticating
    _loggedInStatus = Status.Authenticating;
    //_state = Status.Loading;
    // Notify Listeners
    notifyListeners();
    try {
      // Login Request with email and password
      var response = await authService.login(email, password);
      print('auth response: $response');
      // Get token from response
      var token = response['data']['token'];

      // Retrieve patient info using token
      var info = await getPatient(token);
      // Patient id
      var patientId = info['data']['_id'];
      // Patient email
      var userEmail = info['data']['email'];
      // Patient first name
      var firstname = info['data']['firstname'];
      // Patient surname
      var surname = info['data']['lastname'];
      // Patient date of birth
      var dob = info['data']['dob'];

      print('auth.dart:  $token');

      Map<String, dynamic> userData = {
        '_id': patientId, //user.patientId,
        'firstname': firstname, //user.firstname,
        'lastname': surname, //user.surname,
        'email': userEmail, //user.email,
        'dob': dob, //user.dob,
        'token': token
      };

      // store user data in user object
      User authUser = User.fromJson(userData);
      if (_stayLoggedIn) {
        // save using shared prefs
        UserPreferences().saveUser(authUser);
      }
      result = {'status': true, 'message': 'Successful', 'user': authUser};
      // Change login status to logged in
      _loggedInStatus = Status.LoggedIn;
      //_state = Status.Completed;
      // Notify Listeners
      notifyListeners();


      return result;
    } on AppException catch (e) {
      _setFailure(e);
      print(e);
      _loggedInStatus = Status.Error;
      //_state = Status.Error;
      notifyListeners();
      result = {
        'status': false,
        'message': 'Registration failed',
        //'data': responseData
      };
    }

    //return result;
  }

  /// Get single patient data
  Future<Map<String, dynamic>> getPatient(token) async {
    try {
      // Request
      var info = await authService.getPatients(token);
      print('info $info');
      return info;
    } on AppException catch (e) {
      _setFailure(e);
    }
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
      print('res: $response');

      var patientId = response['data']['patientId'];

      print('auth.dart:  $patientId');

      Map<String, dynamic> userData = {
        '_id': patientId.toString(),
        'firstname': firstname,
        'lastname': surname,
        'email': email,
        'dob': dob,
        'token': ''
      };

      // store user data in user object
      User authUser = User.fromJson(userData);
      print(authUser.email);
      //print('token $(authUser.token)');
      // save using shared prefs
      //print('auth user $authUser');
      await UserPreferences().saveUser(authUser);
      var uu = await UserPreferences().getUser();
      print(uu.token);
      //Provider.of<UserProvider>(context, listen: false).setUser(user);

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
      result = {
        'status': false,
        'message': e,
        //'data': responseData
      };
      print('result: $result');
      print('failure: $failure');
      _registeredInStatus = Status.Error;
      notifyListeners();
    }

    //return result;
  }

  /*var response = await authService
      .activateUser(otp)
      .then((value) async => await uploadData(user.patientId,
  user.firstname, user.surname, user.email, user.dob))
      .catchError((e) {
  _setFailure(e);
  });*/
  Future<Map<String, dynamic>> activate(String otp) async {
    var result;
    print('ok o');
    _verifiedStatus = Status.Loading;
    notifyListeners();
    try {
      print('im here');
      var user = await UserPreferences().getUser();
      var response = await authService.activateUser(otp);
      print('otp: $response');
      await uploadData(
          user.patientId, user.firstname, user.surname, user.email, user.dob);

      var token = response['data']['token'].toString();

      print('auth.dart:  $token');
      //User user = UserProvider().user;
      var userEmail = user.email;
      print('iser $userEmail');
      /*print('user $user');
      print('user email: $dd');*/

      Map<String, dynamic> userData = {
        '_id': user.patientId.toString(),
        'firstname': user.firstname,
        'lastname': user.surname,
        'email': user.email,
        'dob': user.dob,
        'token': token.toString()
      };

      // store user data in user object
      User authUser = User.fromJson(userData);

      // save using shared prefs
      await UserPreferences().saveUser(authUser);
      /*// Shared preference instance
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Save token in shared prefs
      prefs.setString("token", token);
      print(UserPreferences().getUser());*/
      // Verification Successful
      _verifiedStatus = Status.Completed;
      // Notify Listeners
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
        'message': e,
        //'data': responseData
      };
      // Verification failed
      _verifiedStatus = Status.Error;
      // Notify Listeners
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    var result;
    print('ok o');
    _passwordStatus = Status.Loading;
    notifyListeners();
    try {
      print('im here');
      var response = await authService.forgotPassword(email);
      //var responseJson = json.decode(response['data']);
      print('auth.dart :  $response');

      // Reset Successful
      _passwordStatus = Status.Completed;
      // Notify Listeners
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successfully verified',
        'email': 'userEmail'
      };
      return result;
    } on AppException catch (e) {
      _setFailure(e);
      print(e);
      result = {
        'status': false,
        'message': e,
        //'data': responseData
      };
      // Verification failed
      _passwordStatus = Status.Error;
      // Notify Listeners
      notifyListeners();
    }
    return result;
  }

  Future<Map<String, dynamic>> changePassword(
      String token, String password) async {
    var result;
    print('ok o');
    _resetPasswordStatus = Status.Loading;
    notifyListeners();
    try {
      print('im here');
      var response = await authService.resetPassword(token, password);
      print('auth.dart :  $response');

      // Reset Successful
      _resetPasswordStatus = Status.Completed;
      // Notify Listeners
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successfully verified',
        'email': 'userEmail'
      };
      return result;
    } on AppException catch (e) {
      _setFailure(e);
      print(e);
      result = {
        'status': false,
        'message': e,
        //'data': responseData
      };
      // Verification failed
      _resetPasswordStatus = Status.Error;
      // Notify Listeners
      notifyListeners();
    }
  }

  Future uploadData(patientId, firstname, surname, email, dob) async {
    try {
      await authService.uploadFirestore(
          patientId, firstname, surname, email, dob);
    } on AppException catch (e) {
      _setFailure(e);
    }
  }

  /*Future<Map<String, dynamic>> getPatientData(String patientId) async {
    var result;
    print('ok o');
    _verifiedStatus = Status.Loading;
    notifyListeners();
    try {
      print('im here');
      var response = await authService.getPatients(patientId);
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
  }*/
  /*Future<bool> usersLogin() async {
    //var authService = new AuthService();
    final response = await auth.signIn(
      _emailController.text,
      _passwordController.text,
    );
    print('response: $response');

    if (response != null) {
      User user = response['user'];
      /*String token = response['user'];
        User use = Provider.of<UserProvider>(context, listen: false).user;
        Map<String, dynamic> userData= {
          'patientId': use.patientId,
          'firstname': use.firstname,
          'surname': use.surname,
          'email': use.email,
          'dob': use.dob,
          'token': token
        };
        User user = User.fromJson(userData);*/
      Provider.of<UserProvider>(context, listen: false).setUser(user);

      Future.delayed(Duration(milliseconds: 4000)).then(
              (value) => Navigator.pushReplacementNamed(context, '/dashboard'));
      //
    } else {
      print('response');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(auth.failure.toString()),
      ));
    }
  }*/
  // User wants to remain logged in app
  bool _stayLoggedIn = true;

  bool get stayLogged => _stayLoggedIn;

  bool stayLoggedIn(value) {
    _stayLoggedIn = value;
    notifyListeners();
    return _stayLoggedIn;
  }

  // Text field auto validation
  bool _autoValidate = false;

  bool get autoValidate => _autoValidate;

  bool autoValidated() {
    _autoValidate = true;
    notifyListeners();
    return _autoValidate;
  }

  delay() {
    _registeredInStatus = Status.NotRegistered;
    notifyListeners();
  }

  delayLogin() {
    _loggedInStatus = Status.NotLoggedIn;
    notifyListeners();
  }

  delayOtp() {
    _verifiedStatus = Status.Initial;
    notifyListeners();
  }

// Image variable
/*File _image;
  final picker = ImagePicker();

  String _dropdownValue = 'One';
  String get dropDownValue => _dropdownValue;

  // variable to check if file was uploaded
  bool _isFileUploaded = false;
  bool get isFileUploaded => _isFileUploaded;
  // Method to get image from user
  Future getImage() async {
    final pickedFile = _dropdownValue == 'Camera'
        ? await picker.getImage(source: ImageSource.camera)
        : await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isFileUploaded = true;
      } else {
        print('No image selected.');
      }
    notifyListeners();
  }*/
/*Future<Map<String, dynamic>> login(String email, String password, context) async {
    var result;
    // Set login status to authenticating
    _loggedInStatus = Status.Authenticating;

    // Notify Listeners
    notifyListeners();
    try {
      // Login Request with email and password
      var response = await Authentication.login(email, password, context);
      //print('auth response: $response');
      // Store token from response
      //var token = response['data']['token'];

      //print('auth.dart:  $token');
      User user = UserProvider().user;
      var dd = user.email;
      print('user $user');
      print('user email: $dd');

      Map<String, dynamic> userData = {
        'patientId': 'qwerty', //user.patientId,
        'firstname': 'alex', //user.firstname,
        'surname': 'okani', //user.surname,
        'email': 'aconalexx@gmail.com', //user.email,
        'dob': '12 July, 2018', //user.dob,
        'token': 'token'
      };

      // store user data in user object
      User authUser = User.fromJson(userData);
      if (_stayLoggedIn) {
        // save using shared prefs
        //UserPreferences().saveUser(authUser);
      }

      // Change login status to logged in
      _loggedInStatus = Status.LoggedIn;
      //_state = Status.Completed;

      // Notify Listeners
      notifyListeners();
      //print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': authUser};
      return result;
    } catch (e) {
      //_setFailure(e);
      print(e);
      _loggedInStatus = Status.Error;
      //_state = Status.Error;
      notifyListeners();
      ErrorHandler().errorDialog(context, e);
    }

    //return result;
  }

  Future<Map<String, dynamic>> create(String email, String password,
      String firstname, String surname, String dob, context) async {
    var result;
    _registeredInStatus = Status.Registering;
    notifyListeners();
    try {
      print('im here');
      var response =
      await Authentication.signUp(email, password, firstname, surname, dob,  context);
     /* print('ppp $response');
      users.User user = response as users.User;

      Map<String, dynamic> userData = {
        'patientId': user.uid,
        'firstname': firstname,
        'surname': surname,
        'email': email,
        'dob': dob,
        'isVerified': user.emailVerified,
      };
      // store user data in user object
      User authUser = User.fromJson(userData);
      //print('token $(authUser.token)');
      // save using shared prefs
      //print('auth user $authUser');
      UserPreferences().saveUser(authUser);*/
      //Provider.of<UserProvider>(context, listen: false).setUser(user);

      _registeredInStatus = Status.Registered;
      notifyListeners();
      print('registerstatus: $_registeredInStatus');
      result = {
        'status': true,
        'message': 'Successfully registered',
        //'user': authUser
      };

      return result;
    } catch (e) {
      print('eee $e');
      //_setFailure(e);
      /*result = {
        'status': false,
        'message': e,
        //'data': responseData
      };
      print('result: $result');
      print('failure: $failure');*/
      _registeredInStatus = Status.Error;
      notifyListeners();
      ErrorHandler().errorDialog(context, e);
    }

    //return result;
  }

  Future<Map<String, dynamic>> verify() async {
    var result;


      users.User user = users.FirebaseAuth.instance.currentUser;
      print('asss $user.emailVerified');
      if (user!= null && user.emailVerified) {
        // save using shared prefs
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isVerified', user.emailVerified);
        User userData = await UserPreferences().getUser();
        result = {
          'status': true,
          'message': 'Successfully registered',
          'user': userData
        };

        // Verification Successful
        _verifiedStatus = Status.Completed;
        // Notify Listeners
        notifyListeners();
        return result;
      } else {
        result = {
          'status': false,
          'message': 'Successfully registered',
        };
        return result;
      }

  }*/
}
