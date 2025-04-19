import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/flush_bar.dart';
import 'package:taskmanagementapp/core/common/utils/space.dart';
import 'package:taskmanagementapp/core/common/utils/text_controller.dart';
import 'package:taskmanagementapp/core/common/widgets/text_divider.dart';
import 'package:taskmanagementapp/core/theme/app_colors.dart';
import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanagementapp/features/auth/presentation/signup/widget/signup_widget.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/comm_auth_button.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/register_textfield.dart';

Widget buildFormSignUp(
  BuildContext context,
  TextEditingControllers controller,
  GlobalKey<FormState> formKey,
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
              'Create An Account',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SpaceH36(),
            RegisterTextfield(
              obscureText: false,
              keyboardType: TextInputType.name,
              controller: controller.nameController,
              hintText: 'Name',
            ),
            const SpaceH20(),
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
            CommonAuthButton(
              onPressed: () {
                final name = controller.nameController.text.trim();
                final email = controller.emailController.text.trim();
                final password = controller.passwordController.text.trim();

                if (name.isEmpty) {
                  flushBar(context, "Name is required");
                  return;
                }

                if (email.isEmpty) {
                  flushBar(context, "Email is required");
                  return;
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                ).hasMatch(email)) {
                  flushBar(context, "Enter a valid email");
                  return;
                }

                if (password.isEmpty) {
                  flushBar(context, "Password is required");
                  return;
                }
                if (password.length < 6) {
                  flushBar(context, "Password must be at least 6 characters");
                  return;
                }

                context.read<AuthBloc>().add(
                  AuthSignUp(name: name, email: email, password: password),
                );
              },
              text: 'Sign up',
            ),
            SpaceH44(),
            const DividerWithText(),
            SpaceH30(),
            SpaceH40(),
            buildAlreadyHaveAccount(context),
          ],
        ),
      ],
    ),
  );
}
