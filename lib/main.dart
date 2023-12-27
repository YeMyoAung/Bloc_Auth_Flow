import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getx_auth_flow/repositories/AuthService.dart';
import 'package:getx_auth_flow/routes/router.dart';
import 'package:starlight_utils/starlight_utils.dart';

import 'injection.dart';

final _lightTheme = ThemeData.light();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  await Injection<AuthService>().signOut();

  runApp(const BlocAuthFlow());
}

class BlocAuthFlow extends StatelessWidget {
  const BlocAuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: StarlightUtils.navigatorKey,
      theme: _lightTheme.copyWith(
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          floatingLabelStyle: TextStyle(
            color: Colors.blueAccent.shade100,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent.shade100,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.blue),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
      onGenerateRoute: router,
    );
  }
}
