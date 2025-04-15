import 'package:flutter/material.dart';

class UserR {
  final String userid;
  final String username;
  final String name;
  late DateTime dateofbirth;
  final String email;

  UserR({
    required this.username,
    required this.email,
    this.name = '',
    required this.dateofbirth,
  }) : userid = UniqueKey().toString();
}