import 'package:flutter/material.dart';

import 'views/app/homepage.dart';
import 'views/authentication/login.dart';
import 'views/no_internet.dart';

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
