import 'package:flutter/material.dart';

class User {
  final String userid;
  final String username;
  final String name;
  late DateTime dateofbirth;
  final String email;

  User(DateTime dob, {
    required this.username,
    required this.email,
    this.name = '',
    required this.dateofbirth,
  }) : userid = UniqueKey().toString();
}