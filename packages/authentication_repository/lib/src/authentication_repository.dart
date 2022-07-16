import 'dart:async';
import 'dart:convert';

import 'package:models/models.dart';

import 'models/user_credentials.dart';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  late final StreamController<AuthenticationStatus> _controller;

  AuthenticationRepository() {
    _controller = StreamController<AuthenticationStatus>();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  Future<User> _login(UserCredentials user) async {
    User? userFetched;
    //print(user);
    http.Response response = await http.post(
      Uri.parse("http://80.211.57.191:8000/customer_survey/api/login"),
      body: user.toJsonLogin(),
    );
    print("Inizio");
    print((response.body));
    print(jsonDecode(response.body));
    print(User.fromJson(jsonDecode(response.body)));
    print("fine");
    if (response.statusCode == 200) {
      print(response.statusCode);
      try {
        userFetched = User.fromJson(jsonDecode(response.body)['data']);
        print(userFetched);
      } catch (e) {
        print(e);
      }
      print("End");
      return userFetched!;
    } else {
      print("Login Failure from repository");
      throw Exception("Email already taken");
    }
  }

  void authenticate() {
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<User?> logIn({
    required String username,
    required String password,
  }) async {
    try {
      return await _login(
          UserCredentials(name: "name", email: username, password: password));
    } catch (e) {
      return null;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
