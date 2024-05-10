import 'package:flutter/cupertino.dart';
import '../pages/tabs.dart';
import '../pages/login_page.dart';
import '../pages/registration_page.dart';

final Map<String, Function> routes = {
  '/': (context) => const Tabs(),
  '/login': (context) => const LoginPage(),
  '/registration': (context) => RegistrationPage(
        onJumpToLogin: () {},
      ),
  // '/form': (context, {arguments}) => FormPage(arguments: arguments),
};
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          CupertinoPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
