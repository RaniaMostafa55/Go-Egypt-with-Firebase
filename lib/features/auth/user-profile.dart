class UserProfile {
  String? path;
  String name;
  String email;
  String password;
  String phone;
  UserProfile(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      this.path});
}
