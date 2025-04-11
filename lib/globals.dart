library;

import 'package:recout/user.dart';
import 'package:recout/workout.dart';

class Globals {
  static bool _isLoggedIn = true;
  static String username = "Teszt felhasználó";

  static User? user;

  static WorkOut? workOut;

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