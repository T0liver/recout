library;

class Globals {
  static bool _isLoggedIn = true;
  static String username = "Teszt felhasználó";

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