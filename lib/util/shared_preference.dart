import 'package:e_care_mobile/userData/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("patientId", user.patientId);
    prefs.setString("firstname", user.firstname);
    prefs.setString("surname", user.surname);
    prefs.setString("email", user.email);
    prefs.setString("token", user.token);

    print("object prefere");
    print(user.token);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String patientId = prefs.getString("patientId");
    String firstname = prefs.getString("firstname");
    String surname = prefs.getString("surname");
    String email = prefs.getString("email");
    String token = prefs.getString("token");

    return User(
      patientId: patientId,
      firstname: firstname,
      surname: surname,
      email: email,
      token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //prefs.remove("name");
    prefs.remove("firstname");
    prefs.remove("surname");
    prefs.remove("email");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
