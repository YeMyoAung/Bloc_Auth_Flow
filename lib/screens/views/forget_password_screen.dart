import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/forget_password/forget_password_cubit.dart';
import 'package:getx_auth_flow/controllers/forget_password/forget_password_state.dart';
import 'package:getx_auth_flow/screens/widgets/error_dialog.dart';
import 'package:starlight_utils/starlight_utils.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordCubit forgetPasswordCubit =
        context.read<ForgetPasswordCubit>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: forgetPasswordCubit.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Forget Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: TextFormField(
                  controller: forgetPasswordCubit.emailController,
                  onEditingComplete: forgetPasswordCubit.sendResetLink,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) return "Email is required";
                    return value.isEmail ? null : "Invalid email";
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter your email",
                  ),
                ),
              ),
              SizedBox(
                width: context.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: forgetPasswordCubit.sendResetLink,
                  child: BlocConsumer<ForgetPasswordCubit,
                      ForgetPasswordBaseState>(
                    listener: (_, state) {
                      if (state is ForgetPasswordErrorState) {
                        StarlightUtils.dialog(
                          ErrorDialog(
                            title: "Failed to send reset link",
                            message: state.error,
                          ),
                        );
                      }
                    },
                    builder: (_, state) {
                      if (state is ForgetPasswordLoadingState) {
                        return const CupertinoActivityIndicator(
                          color: Colors.white,
                        );
                      }
                      return const Text("Send Reset Link");
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: StarlightUtils.pop,
                  child: Text("Back"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
