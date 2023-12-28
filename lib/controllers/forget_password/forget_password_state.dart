///Initial State
///Loading State
///Error State
///Success State

abstract class ForgetPasswordBaseState {
  const ForgetPasswordBaseState();
}

class ForgetPasswordInitialState extends ForgetPasswordBaseState {
  const ForgetPasswordInitialState();
}

class ForgetPasswordLoadingState extends ForgetPasswordBaseState {
  const ForgetPasswordLoadingState();
}

class ForgetPasswordErrorState extends ForgetPasswordBaseState {
  final String error;

  const ForgetPasswordErrorState(this.error);
}

class ForgetPasswordSuccessState extends ForgetPasswordBaseState {
  const ForgetPasswordSuccessState();
}
