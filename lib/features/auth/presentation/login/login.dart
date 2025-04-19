import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/utils/flush_bar.dart';
import 'package:taskmanagementapp/core/common/utils/loader.dart';

import 'package:taskmanagementapp/core/common/utils/text_controller.dart';

import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanagementapp/features/auth/presentation/login/widget/login_form.dart';

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
              MaterialPageRoute(builder: (_) => const TaskScreen()),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Stack(
            children: [
              IgnorePointer(
                ignoring: isLoading,
                child: buildFormSignIn(context, controller),
              ),
              if (isLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}
