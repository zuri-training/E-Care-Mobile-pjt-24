import 'package:flutter/cupertino.dart';

enum Statuss {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
}

class AuthProviders with ChangeNotifier {}
