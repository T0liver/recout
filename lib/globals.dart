library;

import 'package:recout/user.dart';
import 'package:recout/workout.dart';

class Globals {
  static  String language = "hu";

  static UserR? user;

  static WorkOut? workOut;

  static bool _isLoggedIn = false;

  static bool loggedin() {
    return _isLoggedIn;
  }

  static void login() {
    _isLoggedIn = true;
  }

  static void logout() {
    _isLoggedIn = false;
  }

}