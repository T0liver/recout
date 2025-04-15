library;

import 'package:recout/user.dart';
import 'package:recout/workout.dart';

class Globals {
  static  String language = "hu";

  static UserR? user;

  static WorkOut? workOut;

  static bool _isLoggedIn = true;

  static bool loggedin() {
    return _isLoggedIn;
  }

  void login() {
    _isLoggedIn = true;
  }

  void logout() {
    _isLoggedIn = false;
  }

}