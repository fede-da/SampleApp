import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _logout() {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationLogoutRequested());
      return;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () => _logout(),
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
