import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/register/register_event.dart';
import 'package:getx_auth_flow/controllers/register/register_state.dart';
import 'package:getx_auth_flow/injection.dart';

import '../../repositories/AuthService.dart';

class RegisterBloc extends Bloc<RegisterBaseEvent, RegisterBaseState> {
  final AuthService _auth = Injection<AuthService>();

  RegisterBloc() : super(const RegisterInitialState()) {
    on<OnRegisterEvent>((event, emit) async {
      if (formKey?.currentState?.validate() != true ||
          state is RegisterLoadingState) {
        return;
      }

      emit(const RegisterLoadingState());
      final result =
          await _auth.register(emailController.text, passwordController.text);
      if (result.isError) {
        return emit(RegisterErrorState(result.error!));
      }
      emit(const RegisterSuccessState());
    });
  }

  GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();

  final ValueNotifier<bool> passwordIsShow = ValueNotifier(false),
      confirmPasswordIsShow = ValueNotifier(false);

  void passwordIsShowToggle() {
    passwordIsShow.value = !passwordIsShow.value;
  }

  void confirmPasswordIsShowToggle() {
    confirmPasswordIsShow.value = !confirmPasswordIsShow.value;
  }

  @override
  Future<void> close() {
    formKey = null;

    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    passwordIsShow.dispose();
    confirmPasswordIsShow.dispose();

    return super.close();
  }
}
