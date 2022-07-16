import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'init/bloc_observer.dart';
import 'init/myApp.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    )),
    blocObserver: MyBlocObserver(),
  );
}
