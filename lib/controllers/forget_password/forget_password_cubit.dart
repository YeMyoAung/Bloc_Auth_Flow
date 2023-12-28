import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/forget_password/forget_password_state.dart';
import 'package:getx_auth_flow/injection.dart';
import 'package:getx_auth_flow/repositories/AuthService.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordBaseState> {
  final AuthService _auth = Injection<AuthService>();

  ForgetPasswordCubit() : super(const ForgetPasswordInitialState());

  GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetLink() async {
    if (formKey?.currentState?.validate() != true ||
        state is ForgetPasswordLoadingState) {
      return;
    }

    emit(const ForgetPasswordLoadingState());

    final result = await _auth.sendResetLink(emailController.text);

    if (result.isError) {
      return emit(ForgetPasswordErrorState(result.error!));
    }
    emit(const ForgetPasswordSuccessState());
  }

  @override
  Future<void> close() {
    formKey = null;

    emailController.dispose();

    return super.close();
  }
}
