library globals;

class Globals {
  static bool isLoggedIn = true;
  String username = "";

  bool loggedin() {
    return isLoggedIn;
  }

  void login() {
    isLoggedIn = true;
  }

  void logout() {
    isLoggedIn = false;
  }
}