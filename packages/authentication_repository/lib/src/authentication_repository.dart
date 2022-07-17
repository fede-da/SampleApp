import 'dart:async';
import 'package:models/models.dart';

import 'models/user_credentials.dart';
import 'package:http/http.dart' as http;

//TODO: Make your own implementation

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

  Future<User> _register(UserCredentials user) async {
    return User(token: "token", name: "name", id: 0);
  }

  Future<User> _login(UserCredentials user) async {
    return User(token: "token", name: "name", id: 0);
  }

  void authenticate() {
    _controller.add(AuthenticationStatus.authenticated);
  }

  /// {@template}
  /// Adds authenticated status to AuthenticationController
  void unauthenticate() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<User?> logIn({
    required String username,
    required String password,
  }) async {
    try {
      return await _login(UserCredentials(email: username, password: password));
    } catch (e) {
      return null;
    }
  }

  Future<User?> register({
    required String username,
    required String password,
    required String name,
  }) async {
    try {
      return await _register(
          UserCredentials(email: username, password: password));
    } catch (e) {
      return null;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  //TODO: useful function to make HTTP requests on the internet

  // Future<dynamic> _makeRequest({
  //   required String url,
  //   required RequestType request,
  //   Map<String, dynamic> body = const {},
  // }) async {
  //   http.Response response;
  //   String completeUrl = baseUrl + url;
  //   print("${request.toString()} on URL : $completeUrl ");
  //   if (request == RequestType.post) {
  //     response = await http.post(
  //       Uri.parse(completeUrl),
  //       body: body,
  //     );
  //   } else {
  //     response = await http.get(
  //       Uri.parse(completeUrl),
  //     );
  //     print(response.body);
  //   }
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     try {
  //       Map<String, dynamic> ret = jsonDecode(response.body);
  //       print("Status Code : ${response.statusCode} \n");
  //       return ret;
  //     } catch (e) {
  //       print(e);
  //       throw e;
  //     }
  //   } else {
  //     print("Error in make_request status : ${response.statusCode.toString()}");
  //     throw Exception("Server returned an error");
  //     //Show error here
  //   }
  // }

  void dispose() => _controller.close();
}
