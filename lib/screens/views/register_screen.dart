import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_auth_flow/controllers/register/register_bloc.dart';
import 'package:getx_auth_flow/controllers/register/register_event.dart';
import 'package:getx_auth_flow/controllers/register/register_state.dart';
import 'package:getx_auth_flow/routes/router.dart';
import 'package:starlight_utils/starlight_utils.dart';

import '../widgets/error_dialog.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = context.read<RegisterBloc>();

    void register() {
      registerBloc.confirmPasswordFocusNode.unfocus();
      registerBloc.add(const OnRegisterEvent());
    }

    return Scaffold(
      body: Form(
        key: registerBloc.formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: TextFormField(
                  onEditingComplete:
                      registerBloc.passwordFocusNode.requestFocus,
                  controller: registerBloc.emailController,
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
              ValueListenableBuilder(
                  valueListenable: registerBloc.passwordIsShow,
                  builder: (_, value, child) {
                    return TextFormField(
                      onEditingComplete:
                          registerBloc.confirmPasswordFocusNode.requestFocus,
                      obscureText: !value,
                      controller: registerBloc.passwordController,
                      focusNode: registerBloc.passwordFocusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) return "Password is required";
                        return value.isStrongPassword(
                          minLength: 6,
                          checkSpecailChar: false,
                        );
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: registerBloc.passwordIsShowToggle,
                          icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        labelText: "Enter your password",
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ValueListenableBuilder(
                    valueListenable: registerBloc.confirmPasswordIsShow,
                    builder: (_, value, child) {
                      return TextFormField(
                        onEditingComplete: register,
                        obscureText: !value,
                        controller: registerBloc.confirmPasswordController,
                        focusNode: registerBloc.confirmPasswordFocusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null) {
                            return "Confirm password is required";
                          }
                          final isStrongPassword = value.isStrongPassword(
                            minLength: 6,
                            checkSpecailChar: false,
                          );
                          if (isStrongPassword != null) {
                            return isStrongPassword;
                          }
                          return value == registerBloc.passwordController.text
                              ? null
                              : "Password does not match";
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: registerBloc.confirmPasswordIsShowToggle,
                            icon: Icon(
                              value ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          labelText: "Enter your confirm password",
                        ),
                      );
                    }),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 20),
                width: context.width,
                child: ElevatedButton(
                  onPressed: register,
                  child: BlocConsumer<RegisterBloc, RegisterBaseState>(
                    listener: (_, state) {
                      if (state is RegisterErrorState) {
                        StarlightUtils.dialog(
                          ErrorDialog(
                            title: "Failed to register",
                            message: state.error,
                          ),
                        );
                      }
                      if (state is RegisterSuccessState) {
                        StarlightUtils.pushReplacementNamed(RouteNames.home);
                      }
                    },
                    builder: (_, state) {
                      if (state is RegisterLoadingState) {
                        return const CupertinoActivityIndicator(
                          color: Colors.white,
                        );
                      }
                      return const Text("Register");
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      StarlightUtils.pushReplacementNamed(RouteNames.login);
                    },
                    child: const Text("Login"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
