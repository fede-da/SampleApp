import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:io';

part 'internet_connection_event.dart';
part 'internet_connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  late final Connectivity _connectivity;

  InternetConnectionBloc() : super(InternetConnectionInitial()) {
    _connectivity = Connectivity();
    _init();
    on<InternetConnectionLost>(_onInternetConnectionLost);
    on<InternetConnectionRetrieved>(_onInternetConnectionRetrieved);
  }

  void _onInternetConnectionLost(InternetConnectionLost event,
      Emitter<InternetConnectionState> emit) async {
    return emit(InternetConnectionOffline());
  }

  void _onInternetConnectionRetrieved(InternetConnectionRetrieved event,
      Emitter<InternetConnectionState> emit) async {
    return emit(InternetConnectionOnline());
  }

  void _init() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
    return;
  }

  void _checkStatus(ConnectivityResult result) async {
    //result è di tipo Bluetooth, Wifi, Mobile...
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      add(InternetConnectionLost());
    }
    isOnline
        ? add(InternetConnectionRetrieved())
        : add(InternetConnectionLost());
    return;
  }
}
