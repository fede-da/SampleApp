class UserCredentials {
  final String name;
  final String email;
  final String password;
  UserCredentials(
      {required this.name, required this.email, required this.password});

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
  Map<String, String> toJsonRegistration() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }

  Map<String, String> toJsonLogin() {
    return {
      "email": email,
      "password": password,
    };
  }

  @override
  String toString() {
    return name + " " + email + " " + password + '\n';
  }
}
