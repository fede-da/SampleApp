class UserCredentials {
  final String email;
  final String password;
  UserCredentials({required this.email, required this.password});

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
  Map<String, String> toJsonRegistration() {
    return {
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
    return email + " " + password + '\n';
  }
}
