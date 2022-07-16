part of 'internet_connection_bloc.dart';

abstract class InternetConnectionState extends Equatable {
  const InternetConnectionState();

  @override
  List<Object> get props => [];
}

class InternetConnectionInitial extends InternetConnectionState {}

class InternetConnectionOnline extends InternetConnectionState {}

class InternetConnectionOffline extends InternetConnectionState {}
