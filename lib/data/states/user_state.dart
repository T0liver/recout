import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String? _username;

  String? get username => _username;

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void clear() {
    _username = null;
    notifyListeners();
  }
}
