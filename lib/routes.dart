import 'package:flutter/material.dart';
import 'package:sample_app/views/authentication/login.dart';
import 'package:sample_app/views/no_internet.dart';

import 'app/views/homepage.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/paginaAssenzaInternet':
        return MaterialPageRoute(
          builder: (_) => const NoInternet(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
