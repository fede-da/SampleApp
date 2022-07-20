import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unauthenticated()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationStateInit>(_onAuthenticationStateInit);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
    if (state.status == AuthenticationStatus.authenticated) {
      _authenticationRepository.authenticate();
      return;
    } else {
      _authenticationRepository.unauthenticate();
      return;
    }
  }

  Future<User> register({
    required String name,
    required String username,
    required String password,
  }) async {
    try {
      User? user = await _authenticationRepository.register(
          name: name, username: username, password: password);
      if (user != null) {
        _userRepository.setUser(user);
        return user;
      }
      throw Exception("User null after attempted login");
    } catch (e) {
      print(e);
      return User.empty;
    }
  }

  Future<User> login(
      {required String username, required String password}) async {
    try {
      User? user = await _authenticationRepository.logIn(
          username: username, password: password);
      if (user != null) {
        _userRepository.setUser(user);
        return user;
      }
      throw Exception("User null after attempted login");
    } catch (e) {
      print(e);
      return User.empty;
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStateInit(
    AuthenticationStateInit event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(AuthenticationState.unauthenticated());
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    print("Changing status");
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
    _userRepository.deleteCurrentUserAfterLogout();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> map) {
    try {
      print("AuthState, fromJson method. Printing map : \n" + map.toString());
      AuthenticationState status = AuthenticationState.fromMap(map);
      print(status.toString());
      if (status.status == AuthenticationStatus.authenticated) {
        //emit(status);
        _userRepository.setUser(status.user);
        return status;
      }
    } catch (e) {
      print(e);
      return AuthenticationState.unauthenticated();
    }
    return AuthenticationState.unauthenticated();
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    try {
      print("State saved on map is : " + state.toString());
      Map<String, dynamic> map = state.toMap();
      print("Map status is : " + map['status'].toString());
      print("Map user is : " + map['user'].toString());
      return state.toMap();
    } catch (e) {
      return {};
    }
  }

  @override
  String toString() {
    return "AuthenticationBloc : " + state.toString();
  }
}
