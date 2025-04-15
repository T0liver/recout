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
    required this.userid
  });
}