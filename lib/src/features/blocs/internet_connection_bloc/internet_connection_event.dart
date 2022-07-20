part of 'internet_connection_bloc.dart';

abstract class InternetConnectionEvent extends Equatable {
  const InternetConnectionEvent();

  @override
  List<Object> get props => [];
}

class InternetConnectionLost extends InternetConnectionEvent {}

class InternetConnectionRetrieved extends InternetConnectionEvent {}
