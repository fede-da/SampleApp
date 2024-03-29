import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/src/features/blocs/camera_bloc/camera_bloc.dart';
import 'package:sample_app/src/utils/camera_utils.dart';
import 'package:user_repository/user_repository.dart';

import '../views/app/app_view.dart';
import '../features/authentication/bloc/authentication_bloc.dart';
import '../features/blocs/internet_connection_bloc/internet_connection_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider.value(
          value: userRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider<InternetConnectionBloc>(
            create: ((context) => InternetConnectionBloc()),
          ),
          BlocProvider<CameraBloc>(
            create: ((context) => CameraBloc()),
            lazy: false,
          ),
        ],
        child: AppView(),
      ),
    );
  }
}
