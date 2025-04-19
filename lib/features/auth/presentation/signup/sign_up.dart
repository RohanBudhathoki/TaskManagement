import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanagementapp/core/common/utils/flush_bar.dart';
import 'package:taskmanagementapp/core/common/utils/loader.dart';

import 'package:taskmanagementapp/core/common/utils/text_controller.dart';

import 'package:taskmanagementapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskmanagementapp/features/auth/presentation/login/login.dart';
import 'package:taskmanagementapp/features/auth/presentation/signup/widget/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  final _signUpformKey = GlobalKey<FormState>();
  SignUpScreen({super.key});

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
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Stack(
            children: [
              IgnorePointer(
                ignoring: isLoading,
                child: buildFormSignUp(context, controller, _signUpformKey),
              ),
              if (isLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}
