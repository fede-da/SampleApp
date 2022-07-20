import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/bloc/authentication_bloc.dart';
import '../../features/blocs/internet_connection_bloc/internet_connection_bloc.dart';
import '../../routes.dart';

class AppView extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InternetListener(),
      onGenerateRoute: _appRouter.onGeneratedRoute,
    );
  }
}

class InternetListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool canBePopped = false;
    return BlocListener<InternetConnectionBloc, InternetConnectionState>(
      listener: (newContext, state) {
        switch (state.runtimeType) {
          case InternetConnectionOffline:
            canBePopped = true;
            Navigator.of(context).pushNamed("/paginaAssenzaInternet");
            break;
          case InternetConnectionOnline:
            if (canBePopped) {
              canBePopped = false;
              Navigator.of(context).pop();
            }
            break;
          default:
            break;
        }
      },
      child: AuthBlocListener(),
    );
  }
}

class AuthBlocListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (newContext, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            Navigator.of(context).pushNamed("/home");
            break;
          case AuthenticationStatus.unauthenticated:
            Navigator.of(context).pushNamed("/login");
            break;
          default:
            break;
        }
      },
      child: const CircularProgressIndicator(),
    );
  }
}
