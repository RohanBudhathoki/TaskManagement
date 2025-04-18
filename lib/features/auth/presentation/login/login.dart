import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/flush_bar.dart';
import 'package:taskmanagementapp/core/common/utils/space.dart';
import 'package:taskmanagementapp/core/common/utils/text_controller.dart';
import 'package:taskmanagementapp/core/theme/app_colors.dart';
import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanagementapp/features/auth/presentation/signup/sign_up.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/comm_auth_button.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/register_textfield.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/task_screen/task_screen.dart';

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
          if (state is AuthSucess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => TaskScreen()),
            );
          }
        },

        builder: (context, state) {
          if (state is AuthLoading) {
            // return const LoadingWidget();
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.lightBackGround.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ListView(
              children: [
                Column(
                  children: [
                    SpaceH100(),
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SpaceH36(),
                    RegisterTextfield(
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      hintText: 'Email',
                    ),
                    const SpaceH20(),
                    RegisterTextfield(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: controller.passwordController,
                      hintText: 'Password',
                    ),
                    SpaceH12(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          flushBar(
                            context,
                            "sorry for your inconvince ,Work in Progess",
                          );
                        },
                        child: Text(
                          'Forgot Password ',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SpaceH28(),
                    CommonAuthButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          AuthLogin(
                            email: controller.emailController.text.trim(),
                            password: controller.passwordController.text.trim(),
                          ),
                        );
                      },
                      text: 'Sign In',
                    ),
                    SpaceH44(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 28.5,
                            thickness: 1.43,
                            color: AppColors.darkBackGround,
                          ),
                        ),
                        Text(
                          'Or sign In with  ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.darkBackGround,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            endIndent: 28.5,
                            thickness: 1.43,
                            color: AppColors.darkBackGround,
                          ),
                        ),
                      ],
                    ),
                    SpaceH30(),

                    SpaceH40(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account?  ',
                          style: DefaultTextStyle.of(
                            context,
                          ).style.copyWith(fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Signup',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
