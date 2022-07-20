import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_repository/user_repository.dart';

import 'src/init/bloc_observer.dart';
import 'src/init/myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    )),
    blocObserver: MyBlocObserver(),
    storage: storage,
  );
}
