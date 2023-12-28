import 'package:firebase_auth/firebase_auth.dart';

///Initial State
///Loading State
///Success State
///Error State
///User Changes State

abstract class HomeBaseState {
  const HomeBaseState();
}

class HomeInitialState extends HomeBaseState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeBaseState {
  const HomeLoadingState();
}

class HomeSuccessState extends HomeBaseState {
  const HomeSuccessState();
}

class HomeErrorState extends HomeBaseState {
  const HomeErrorState();
}

class HomeUserChangedState extends HomeBaseState {
  final User user;

  const HomeUserChangedState(this.user);
}

class HomeUserSignOutState extends HomeBaseState {
  const HomeUserSignOutState();
}
