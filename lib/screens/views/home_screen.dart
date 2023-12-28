import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/home/home_bloc.dart';
import 'package:getx_auth_flow/controllers/home/home_state.dart';
import 'package:starlight_utils/starlight_utils.dart';

import '../../injection.dart';
import '../../repositories/AuthService.dart';
import '../../routes/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Injection<AuthService>().signOut();
    });
    return BlocListener<HomeBloc, HomeBaseState>(
      listener: (_, state) {
        print("New state $state");
        if (state is HomeUserSignOutState) {
          StarlightUtils.pushReplacementNamed(RouteNames.login);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Auth Flow"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
