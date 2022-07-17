// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStateInit extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

// ignore: must_be_immutable
class AuthenticationLoginRequested extends AuthenticationEvent {
  String username;
  String password;

  AuthenticationLoginRequested({
    required this.username,
    required this.password,
  });
  @override
  List<Object> get props => [username, password];
}
