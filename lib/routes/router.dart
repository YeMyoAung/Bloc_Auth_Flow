import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/login/login_bloc.dart';
import 'package:getx_auth_flow/injection.dart';
import 'package:getx_auth_flow/repositories/AuthService.dart';
import 'package:getx_auth_flow/screens/views/login_screen.dart';

abstract class RouteNames {
  static const String home = "/";
  static const String login = "/login";
  static const String register = "/register";
}

Route? router(RouteSettings setting) {
  String incomingRoute = setting.name ?? "/";
  // final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  //
  // if (incomingRoute == "/" && !isLoggedIn) {
  //   incomingRoute = "/login";
  // }

  switch (incomingRoute) {
    case RouteNames.home:
      // if (FirebaseAuth.instance.currentUser == null) {
      //   return _loadRoute(
      //       Scaffold(
      //         body: Center(
      //           child: Text("Login"),
      //         ),
      //       ),
      //       setting);
      // }
      return _protectedRoute(
          incomingRoute,
          const Scaffold(
            body: Center(
              child: Text("Home"),
            ),
          ),
          setting);
    case RouteNames.login:
      return _protectedRoute(
          incomingRoute,
          BlocProvider(
            create: (_) => LoginBloc(),
            child: const LoginScreen(),
          ),
          setting);
    case RouteNames.register:
      return _protectedRoute(
          incomingRoute,
          const Scaffold(
            body: Center(
              child: Text("Register"),
            ),
          ),
          setting);
    default:
      return _loadRoute(
          const Scaffold(
            body: Center(
              child: Text("Not Found"),
            ),
          ),
          setting);
  }
}

List<String> _protectedRoutes = ["/"];

Route? _protectedRoute(String path, Widget child, RouteSettings settings) {
  return _loadRoute(
    Injection<AuthService>().currentUser == null &&
            _protectedRoutes.contains(path)
        ? BlocProvider(
            create: (_) => LoginBloc(),
            child: const LoginScreen(),
          )
        : child,
    settings,
  );
}

Route _loadRoute(Widget child, RouteSettings setting) {
  return MaterialPageRoute(
    builder: (_) => child,
    settings: setting,
  );
}
