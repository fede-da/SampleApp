import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../features/blocs/login_cubit/login_cubit.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginCubit(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
              userRepository: RepositoryProvider.of<UserRepository>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
