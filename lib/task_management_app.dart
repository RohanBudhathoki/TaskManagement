import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/cubit/cubit/app_user_cubit.dart';
import 'package:taskmanagementapp/features/auth/presentation/login/login.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/task_screen/task_screen.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return TaskScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
