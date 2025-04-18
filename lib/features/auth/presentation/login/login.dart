import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/flush_bar.dart';
import 'package:taskmanagementapp/core/common/utils/text_controller.dart';
import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/comm_auth_button.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/register_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingControllers();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            flushBar(context, state.message);
          }
        },

        builder: (context, state) {
          if (state is AuthLoading) {
            // return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 500),
              child: Column(
                children: [
                  // SpaceH200(),
                  RegisterTextfield(
                    controller: controller.emailController,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,

                    hintText: 'Email',
                  ),

                  // const SpaceH20(),
                  RegisterTextfield(
                    controller: controller.passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,

                    hintText: ' Password',
                  ),
                  // const SpaceH28(),
                  CommonAuthButton(
                    onPressed: () async {
                      context.read<AuthBloc>().add(
                        AuthLogin(
                          email: controller.emailController.text,
                          password: controller.passwordController.text,
                        ),
                      );
                    },
                    text: 'Login',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
