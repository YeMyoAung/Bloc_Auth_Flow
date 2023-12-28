import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/home/home_event.dart';
import 'package:getx_auth_flow/controllers/home/home_state.dart';
import 'package:getx_auth_flow/injection.dart';
import 'package:getx_auth_flow/repositories/AuthService.dart';

class HomeBloc extends Bloc<HomeBaseEvent, HomeBaseState> {
  final AuthService _auth = Injection<AuthService>();

  StreamSubscription? _authState;

  HomeBloc() : super(const HomeInitialState()) {
    _authState = _auth.authState.listen((user) {
      if (user == null) {
        add(const SignOutEvent());
      } else {
        add(UserChangedEvent(user));
      }
    });
    on<UserChangedEvent>((event, emit) {
      emit(HomeUserChangedState(event.user));
    });
    on<SignOutEvent>((event, emit) {
      emit(const HomeUserSignOutState());
    });
  }

  @override
  Future<void> close() {
    _authState?.cancel();
    return super.close();
  }
}
