import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/forget_password/forget_password_cubit.dart';
import 'package:getx_auth_flow/controllers/home/home_bloc.dart';
import 'package:getx_auth_flow/controllers/login/login_bloc.dart';
import 'package:getx_auth_flow/controllers/register/register_bloc.dart';
import 'package:getx_auth_flow/injection.dart';
import 'package:getx_auth_flow/repositories/AuthService.dart';
import 'package:getx_auth_flow/screens/views/forget_password_screen.dart';
import 'package:getx_auth_flow/screens/views/home_screen.dart';
import 'package:getx_auth_flow/screens/views/login_screen.dart';
import 'package:getx_auth_flow/screens/views/register_screen.dart';

abstract class RouteNames {
  static const String home = "/",
      login = "/login",
      register = "/register",
      forgetPassword = "/forgetPassword";
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
        BlocProvider(
          create: (_) => HomeBloc(),
          lazy: false,
          child: const HomeScreen(),
        ),
        setting,
      );
    case RouteNames.login:
      return _protectedRoute(
        incomingRoute,
        BlocProvider(
          create: (_) => LoginBloc(),
          child: const LoginScreen(),
        ),
        setting,
      );
    case RouteNames.register:
      return _protectedRoute(
        incomingRoute,
        BlocProvider(
          create: (_) => RegisterBloc(),
          child: const RegisterScreen(),
        ),
        setting,
      );
    case RouteNames.forgetPassword:
      return _protectedRoute(
        incomingRoute,
        BlocProvider(
          create: (_) => ForgetPasswordCubit(),
          child: const ForgetPasswordScreen(),
        ),
        setting,
      );
    default:
      return _loadRoute(
        const Scaffold(
          body: Center(
            child: Text("Not Found"),
          ),
        ),
        setting,
      );
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
