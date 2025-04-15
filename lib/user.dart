import 'package:flutter/material.dart';

class UserR {
  final String userid;
  final String username;
  String? name;
  DateTime? dateofbirth;
  final String email;

  UserR({
    required this.username,
    required this.email,
    this.name,
    this.dateofbirth,
  }) : userid = UniqueKey().toString();
}