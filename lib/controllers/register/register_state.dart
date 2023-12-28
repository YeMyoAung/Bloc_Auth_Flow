///Register Initial
///Loading
///Success State
///Error State

abstract class RegisterBaseState {
  const RegisterBaseState();
}

class RegisterInitialState extends RegisterBaseState {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterBaseState {
  const RegisterLoadingState();
}

class RegisterSuccessState extends RegisterBaseState {
  const RegisterSuccessState();
}

class RegisterErrorState extends RegisterBaseState {
  final String error;
  const RegisterErrorState(this.error);
}
