import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/flush_bar.dart';
import 'package:taskmanagementapp/core/common/utils/space.dart';
import 'package:taskmanagementapp/core/common/utils/text_controller.dart';
import 'package:taskmanagementapp/core/common/widgets/text_divider.dart';
import 'package:taskmanagementapp/core/theme/app_colors.dart';
import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanagementapp/features/auth/presentation/login/widget/signup_link.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/comm_auth_button.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/register_textfield.dart';

Widget buildFormSignIn(
  BuildContext context,
  TextEditingControllers controller,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: AppColors.lightBackGround.withOpacity(0.2),
      borderRadius: BorderRadius.circular(25),
    ),
    child: ListView(
      children: [
        Column(
          children: [
            SpaceH100(),
            const Text(
              'Get Started',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    "Sorry for the inconvenience. Work in progress.",
                  );
                },
                child: const Text(
                  'Forgot Password',
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
            const DividerWithText(),
            SpaceH30(),
            SpaceH40(),
            buildSignUpLink(context),
          ],
        ),
      ],
    ),
  );
}
